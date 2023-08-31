#![allow(non_snake_case,non_camel_case_types,dead_code)]

/*
    Below is the function stub for deal. Add as many helper functions
    as you like, but the deal function should not be modified. Just
    fill it in.
    
    Test your code by running 'cargo test' from the war_rs directory.
*/
/*
fn deal(shuf: &[u8; 52]) -> [u8; 52]
{
    shuf.clone()
    
}
*/

fn deal(shuf: &[u8; 52]) -> [u8; 52] 
{
    //Create player1 & player2 hands
    let (p1, p2) = split_deck(shuf);
    //Begin War Game
    let start = play_war(&p1[..], &p2[..], vec![]);
    //u8 used for final result 
    let mut result = [0; 52];
    //Convert the resulting vector of cards to an array and restore any aces
    //.enumerate() is used for i to represent index, and card to represent the value/element in the for loop
    //For each element in the final deck - start, put in result & apply restore_ace
    for (i, &card) in start.iter().enumerate() {
        result[i] = restore_ace(&card);
    }
    //Return result (winner hand)
    result
}

//Splits the deck into two hands taking alternating elements 
fn split_deck(deck: &[u8; 52]) -> ([u8; 26], [u8; 26]) 
{
    //Represent player1 & player2 hand - size 26 (half of deck - 52)
    let mut p1 = [0; 26];
    let mut p2 = [0; 26];

    //Iterate over the deck - Reverse the deck - Map each element to replace_ace function
    //.enumerate() is used for i to represent index, and card to represent the element in the for loop
    for (i, card) in deck.iter().rev().map(replace_ace).enumerate() {
        //If index even add to p1 hand
        if i % 2 == 0 {
            //Iterating over a deck of 52 cards compared to p1 & p2 of length 26
            //Divide index by 2 with integer division (remainder discarded) to get correct indexes to place card/element
            p1[i / 2] = card;
        //Else index odd add to p2 hand
        } else {
            p2[i / 2] = card;
        }
    }
    //Return player1 & player2 hand
    (p1, p2)
}

//Ace is highest card, have it represent 14 for now (2-14 rank order)
fn replace_ace(card: &u8) -> u8 {
    if *card == 1 {
        14
    } else {
        *card
    }
}

//Restore value of Ace back to 1 from 14 (2-13, 1 rank order)
fn restore_ace(card: &u8) -> u8 {
    if *card == 14 {
        1
    } else {
        *card
    }
}

//Sort cards in decreasing (descending order)
//Used for when cards are added to bottom of pile (sorting war pile)
fn sort_descending(cards: &mut [u8]) {
    for i in 0..cards.len() {
        for j in i + 1..cards.len() {
            if cards[i] < cards[j] {
                cards.swap(i, j);
            }
        }
    }
}

//Simulates game of war between two players recursively 
fn play_war(p1: &[u8], p2: &[u8], mut war: Vec<u8>) -> Vec<u8> {
    //Create mutable copies of the player card slices
    let mut p1_remaining = p1.to_vec();
    let mut p2_remaining = p2.to_vec();
    
    //Check if both player card slices are empty
    if p1_remaining.is_empty() && p2_remaining.is_empty() {
        //If so, return the sorted war vector 
        sort_descending(&mut war);
        return war;
    //Check if player1 card slice is empty
    } else if p1_remaining.is_empty() {
        //If so, return player2's cards + sorted war vector 
        sort_descending(&mut war);
        p2_remaining.extend(war);
        return p2_remaining;
    //Check if player2 card slice is empty
    } else if p2_remaining.is_empty() {
        //If so, return player1's cards + sorted war vector 
        sort_descending(&mut war);
        p1_remaining.extend(war);
        return p1_remaining;
    }
    
    //Remove the first card from each players card slice - Get respective top first card from each player hand
    let card1 = p1_remaining.remove(0);
    let card2 = p2_remaining.remove(0);
    //Add cards to a new vector representing the cards played in this round
    let mut cards = vec![card1, card2];
    //Add potential war cards 
    cards.extend(war);
    //Sort the cards played in this round in descending order
    sort_descending(&mut cards); 

    //Rounds of the game
    //Compare the first card from each players card slice
    match card1.cmp(&card2) {
        //If player1 card is greater than player2 card - Player1 wins, add cards to bottom of p1 deck 
        std::cmp::Ordering::Greater => {
            //Sort the cards played in this round in descending order
            sort_descending(&mut cards);
            p1_remaining.extend(cards);
            play_war(&p1_remaining, &p2_remaining, vec![])
        }
        //If player2 card is greater than player1 card - Player2 wins, add cards to bottom of p2 deck
        std::cmp::Ordering::Less => {
            //Sort the cards played in this round in descending order
            sort_descending(&mut cards); 
            p2_remaining.extend(cards);
            play_war(&p1_remaining, &p2_remaining, vec![])
        }
        //If both players play equal card - Check if players still have cards remaining
        //War - tied card condition
        std::cmp::Ordering::Equal if !p1_remaining.is_empty() && !p2_remaining.is_empty() => {
            //Remove the next card from each players card slice 
            //Get respective first face down card from each player hand - set to card?_down
            let card1_down = p1_remaining.remove(0);
            let card2_down = p2_remaining.remove(0);
            
            //Add face down cards to a new war vector, along with the cards played in this round
            let mut new_war = Vec::new();
            new_war.push(card1_down);
            new_war.push(card2_down);
            new_war.extend(cards);
            //Call function again with new war cards to compare next face up cards 
            play_war(&p1_remaining, &p2_remaining, new_war)
        }
        //Catch all case when none above match 
        //Return everything
        _ => {
            play_war(&p1_remaining, &p2_remaining, cards)
        }
    }
}


#[cfg(test)]
#[path = "tests.rs"]
mod tests;

