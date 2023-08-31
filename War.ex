defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add 
    as many additional helper functions as you want. 

    The tests for the deal function can be found in test/war_test.exs. 
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory 
    (the one containing mix.exs)
  """

  #def deal(shuf) do
    #shuf
  #end

  def deal(deck) do
    #Create player1 & player2 hands
    {p1, p2} = deck |> Enum.reverse() |> Enum.map(&replaceAce/1) |> splitDeck() 
      #Reverse list (to set appropriate cards at the top)
      #Apply function replaceAce to each element in deck
      #Apply function splitDeck to split cards in deck for p1 & p2 respectfully

    #Begin War Game
    start = playWar(p1, p2)
    #Final Return Value (winner's hand) - Apply restoreAce to each element in deck 
    Enum.map(start, &restoreAce/1)
  end

  #Ace is highest card, have it represent 14 for now (2-14 rank order)
  defp replaceAce(card) do
    if card == 1 do
      14
    else
      card
    end
  end

  #Enum.take_every creates player1's hand by taking every 2nd element from deck 
  #Enum.drop_every creates player2's hand by excluding every 2nd element from deck
  #Thus two lists get created taking alternating elements - representing each hand
  def splitDeck(deck) do
    {Enum.take_every(deck, 2), Enum.drop_every(deck, 2)}
  end

  #Restore value of Ace back to 1 from 14 (2-13, 1 rank order)
  defp restoreAce(card) do
    if card == 14 do
      1
    else
      card
    end
  end

  #Sort cards in decreasing (descending order)
  #Used for when cards are added to bottom of pile (sorting war pile)
  def sortDescending(list) do
    Enum.sort(list, fn x, y -> x > y end)
  end

  #Optional (\\) third argument - war
  #Simulates game of war between two players recursively 
  defp playWar(p1, p2, war \\ [])

  #End results of games where both or one of players runs out of cards 

  #If both players have no more cards, return sorted war pile
  defp playWar([], [], war), do: sortDescending(war)

  #If player1 has no more cards, return player2's cards + sorted war pile
  defp playWar([], p2, war), do: p2 ++ sortDescending(war)

  #If player2 has no more cards, return player1's cards + sorted war pile
  defp playWar(p1, [], war), do: p1 ++ sortDescending(war)

  #Rounds of the game  
  defp playWar([card1 | p1_remaining], [card2 | p2_remaining], war) do
    #Sort top cards for each deck + potential war cards in descending order
    cards = sortDescending([card1, card2] ++ war)

    cond do
      card1 > card2 ->
        #Player1 wins, add cards to bottom of p1 deck 
        playWar(p1_remaining ++ cards, p2_remaining)

      card1 < card2 ->
        #Player2 wins, add cards to bottom of p2 deck
        playWar(p1_remaining, p2_remaining ++ cards)

      #Check if players still have cards remaining for War 
      p1_remaining != [] and p2_remaining != [] ->
        #War - tied card condition 
        #Get first face down card from each player - set to card?_down 
        #Remaining hand set to p?_remaining 
        [card1_down | p1_remaining] = p1_remaining
        [card2_down | p2_remaining] = p2_remaining
        #Call function again to compare next face up cards
        #Add War Cards (the first face down from each player) into cards
        playWar(p1_remaining, p2_remaining, cards ++ [card1_down, card2_down])

      #Catch all case when none above match 
      #If one player has no more cards, return everything
      true ->
        playWar(p1_remaining, p2_remaining, cards)
    end
  end

end
