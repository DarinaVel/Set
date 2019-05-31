//
//  SetGame.swift
//  Set
//
//  Created by Admin on 26/04/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
struct SetGame{
    var cards = [SetCard]()
    private var countCards = 24;
    private let max = 80;
    private var current = 0;
    private var step = 0;
    private var num = 0;
    private var selectedCards = [Int]()
    var score = 0
    
    init(){
        for i in (0..<countCards){
            step = (max - current) / (countCards - i) + 1;
            num = current + Int(arc4random_uniform(UInt32(step)))
            print(num)
            self.cards += [SetCard(num: num)]
            current = num + 1
        }
        self.cards = self.cards.shuffled()
    }
    
    mutating func findHint(countCards: Int) -> [Int]{
        for x in (0..<countCards-2){
            for y in (x+1..<countCards-1){
                for z in (y+1..<countCards){
                    if !(self.cards[x].isMatched || self.cards[y].isMatched || self.cards[z].isMatched){
                        if (isSet(arrayCard: [x, y, z])){
                            return [x, y, z]
                        }
                    }
                }
            }
        }
        return [Int]()
    }
    
    mutating func selectCard(index: Int){
        if !self.cards[index].isMatched{
            if (self.cards[index].isSelect){
                self.cards[index].isSelect = false
                self.selectedCards = self.selectedCards.filter(){$0 != index}
            }
            else{
                selectedCards.append(index)
                if selectedCards.count == 3 {
                    if isSet(arrayCard: selectedCards){
                        self.cards[selectedCards[0]].isMatched = true
                        self.cards[selectedCards[1]].isMatched = true
                        self.cards[selectedCards[2]].isMatched = true
                        self.score += 3
                    }
                    else{
                        self.score -= 1
                    }
                    self.cards[selectedCards[0]].isSelect = false
                    self.cards[selectedCards[1]].isSelect = false
                    self.cards[selectedCards[2]].isSelect = false
                    selectedCards.removeAll()
                }
                else{
                    self.cards[index].isSelect = true
                }
            }
        }
    }
    
    private func isSet(arrayCard: [Int]) -> Bool{
        var set = true
        set = (self.cards[arrayCard[0]].color == self.cards[arrayCard[1]].color &&
            self.cards[arrayCard[2]].color == self.cards[arrayCard[1]].color ||
            self.cards[arrayCard[0]].color != self.cards[arrayCard[1]].color &&
            self.cards[arrayCard[2]].color != self.cards[arrayCard[1]].color &&
            self.cards[arrayCard[2]].color != self.cards[arrayCard[0]].color) &&
            (self.cards[arrayCard[0]].count == self.cards[arrayCard[1]].count &&
            self.cards[arrayCard[2]].count == self.cards[arrayCard[1]].count ||
            self.cards[arrayCard[0]].count != self.cards[arrayCard[1]].count &&
            self.cards[arrayCard[2]].count != self.cards[arrayCard[1]].count &&
            self.cards[arrayCard[2]].count != self.cards[arrayCard[0]].count) &&
            (self.cards[arrayCard[0]].symbol == self.cards[arrayCard[1]].symbol &&
            self.cards[arrayCard[2]].symbol == self.cards[arrayCard[1]].symbol ||
            self.cards[arrayCard[0]].symbol != self.cards[arrayCard[1]].symbol &&
            self.cards[arrayCard[2]].symbol != self.cards[arrayCard[1]].symbol &&
            self.cards[arrayCard[2]].symbol != self.cards[arrayCard[0]].symbol) &&
            (self.cards[arrayCard[0]].texture == self.cards[arrayCard[1]].texture &&
            self.cards[arrayCard[2]].texture == self.cards[arrayCard[1]].texture ||
            self.cards[arrayCard[0]].texture != self.cards[arrayCard[1]].texture &&
            self.cards[arrayCard[2]].texture != self.cards[arrayCard[1]].texture &&
            self.cards[arrayCard[2]].texture != self.cards[arrayCard[0]].texture)
        return set
    }
}
