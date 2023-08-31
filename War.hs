module War (deal) where

import Data.List

{--
Function stub(s) with type signatures for you to fill in are given below. 
Feel free to add as many additional helper functions as you want. 

The tests for these functions can be found in src/TestSuite.hs. 
You are encouraged to add your own tests in addition to those provided.

Run the tester by executing 'cabal test' from the war directory 
(the one containing war.cabal)
--}
{-
deal :: [Int] -> [Int]
deal shuf = shuf
-}

deal :: [Int] -> [Int]
deal deck =
  --Create player1 & player2 hands
  --Reverse the deck (set appropriate cards at the top)
  --Map function replaceAce to each element in deck 
  let (p1, p2) = splitDeck (map replaceAce (reverse deck))
  --Begin War Game
  --Final Return Value (winner's hand) - Apply restoreAce to each element in deck using <$> operator 
  in restoreAce <$> playWar p1 p2 []

--Ace is highest card, have it represent 14 for now (2-14 rank order)
replaceAce :: Int -> Int
replaceAce 1 = 14
replaceAce n = n

--Splits the deck into two hands of alternating elements
--Returns a tuple of two lists representing the hands of each player 
splitDeck :: [a] -> ([a], [a])
--Zips elements of deck with infinite list - [0,1,2,...] to indexedDeck - list of tuples
--Where the first element is an index, and the second element is an element/card from deck
splitDeck deck = let indexedDeck = zip [0..] deck
                     --P1 contains every second element from the indexedDeck list 
                     --The filter condition takes elements where the index is even
                     p1 = [card | (index, card) <- indexedDeck, index `mod` 2 == 0]
                     --P2 excludes every second element from the indexedDeck list 
                     --The filter condition takes elements where the index is odd
                     p2 = [card | (index, card) <- indexedDeck, index `mod` 2 == 1]
                 -- Return a tuple of the two lists, p1 and p2
                 in (p1, p2)

--Restore value of Ace back to 1 from 14 (2-13, 1 rank order)
restoreAce :: Int -> Int
restoreAce 14 = 1
restoreAce n = n

--Sort cards in decreasing (descending order)
--Used for when cards are added to bottom of pile (sorting war pile)
sortDescending :: Ord a => [a] -> [a]
sortDescending [] = []
sortDescending (first:remaining) = sortDescending larger ++ [first] ++ sortDescending smaller
  where
    --Recursively list elements smaller than or equal to first element - Store in 'smaller'
    smaller = [element | element <- remaining, element <= first]
    --Recursively list elements larger than first element - Store in 'larger'
    larger = [element | element <- remaining, element > first]

--Simulates game of war between two players recursively 
playWar :: [Int] -> [Int] -> [Int] -> [Int]

--If both players have no more cards, return sorted war pile
playWar [] [] war = sortDescending war

--If player1 has no more cards, return player2's cards + sorted war pile
playWar [] p2 war = p2 ++ sortDescending war

--If player2 has no more cards, return player1's cards + sorted war pile
playWar p1 [] war = p1 ++ sortDescending war

--Rounds of the game  
playWar (card1 : p1Remaining) (card2 : p2Remaining) war =
  case compare card1 card2 of
    --Player1 wins, add cards to bottom of p1 deck sorted - Use empty list for war arg
    GT -> playWar (p1Remaining ++ sortDescending (card1 : card2 : war)) p2Remaining []
    --Player2 wins, add cards to bottom of p2 deck sorted - Use empty list for war arg
    LT -> playWar p1Remaining (p2Remaining ++ sortDescending (card1 : card2 : war)) []
    --War - tied card condition 
    EQ ->
      case (p1Remaining, p2Remaining) of
        --Check if players still have cards remaining for War 
        --Else end game, and return remaining p? hand + sorted cards 
        ([], _) -> p2Remaining ++ sortDescending (card1 : card2 : war)
        (_, []) -> p1Remaining ++ sortDescending (card1 : card2 : war)
        --Get first face down card from each player - set to card?Down 
        (card1Down : p1Rest, card2Down : p2Rest) ->
          --Call function again to compare next face up cards
          --Add War Cards (the first face down from each player) into cards
          playWar p1Rest p2Rest (card1Down : card2Down : card1 : card2 : war)
  
    
