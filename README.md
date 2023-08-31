# War-Project
In this project, the code will simulate a game of War. War is a card game between two players. A description of this game and its rules can be found here: https://bicyclecards.com/how-to-play/war

Game Description

The deck of cards is shuffled before the game begins. As described below, the deck will be provided into your program already shuffled. Each player receives an alternating hand of cards, giving them a total of 26 cards.

Each round, the top card from each player's pile is revealed. Both cards are won by the player holding the highest card (by rank), who then adds them to their pile at the bottom. Aces are seen as being high, which means that the card rankings are 2 through 10, Jack, Queen, and King, then Ace. 

War results if the cards that are revealed are tied. Each player turns over two cards: one card face down followed by one card face up. The person who has the higher face-up card takes both piles (a total of six cards, the two original cards that were tied and the four cards from the War). If the turned-up cards are once more of the same rank, each player deals another card face down and turns another card face up. All ten cards in this case are dealt to the player who has the higher card, and so forth.

When one player runs out of cards, they are the loser, and the other player wins. A player also loses if they run out of cards in the middle of a war.

Technical Details 

Input: The input to your program will consist of a permutation of 52 integers, each of which appears four times and represents a shuffled deck of cards. According to the following table, the integers in this permutation represent the cards four kings, four tens, four threes, and so forth. Because the game of War doesn't call for it, you'll see that we don't bother to represent the suit.

1   2 3 4 5 6 7 8 9 10  11   12    13
Ace 2 3 4 5 6 7 8 9 10 Jack Queen King

The game: Two piles will be dealt by your program using the supplied permutation. It is entirely up to you how to depict your stacks. When the piles have been dealt, continue to "play" the game in your software until one person runs out of cards. Again, it's entirely up to you how you manage your piles while playing the game. Continue until one player has no more cards.

A player's pile should always have cards at the bottom added in decreasing order of rank. That is, place the card with the highest ranking at the bottom, followed by the card with the next highest rating. Wars also fall under this category. Six cards should be added to the bottom, starting with the highest rank and ending with the smallest, if a player wins six cards as a result of a war. The highest rank is Ace, while the lowest is Two.

Output: Your application will give the winner player's pile back. According to how the game was played, this pile should contain all 52 integers from the first input permutation and be arranged correctly.

I will simulate a game of war using 3 different coding languages: Elixir, Haskell, & Rust. Through Elixir and Haskell, I will implement a function called deal that accepts and returns a list of integers. Through Rust, I will implement a function called deal that accepts an immutable reference to an array of u8, and returns ownership of a new array of u8. 


