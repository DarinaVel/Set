//
//  ViewController.swift
//  Set
//
//  Created by Admin on 09/04/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        self.newGame()
    }
    private lazy var game = SetGame();
    private var color = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)]
    private var numberOfCardsThatWereDealt = 12
    private var hint: [Int] = [Int]()
    private let scoreLabelText = "Количество очков:"
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var turnInCardButton: UIButton!
    @IBOutlet private weak var hintButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let index = self.cardButtons.firstIndex(of: sender){
            self.game.selectCard(index: index)
            self.updateViewModel()
        }
    }
    
    @IBAction func NewGameButtonAction(_ sender: Any) {
        self.newGame()
    }
    
    private func newGame(){
        for index in (0..<24){
            self.cardButtons[index].setAttributedTitle(NSAttributedString(string: String()), for: .normal)
        }
        self.game = SetGame()
        self.numberOfCardsThatWereDealt = 12
        self.hint = [Int]()
        self.showCardsThatWereDealt()
        self.updateViewModel()
    }
    
    func showCardsThatWereDealt(){
        for index in (0..<numberOfCardsThatWereDealt) {
            let card = self.game.cards[index]
            let newColor: UIColor = UIColor(cgColor: color[card.color].cgColor.copy(alpha: CGFloat(self.game.cards[index].texture))!)
            let strokeTextAttributes = [
                .strokeColor : color[card.color],
                .foregroundColor : newColor,
                .strokeWidth : -2.0,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ] as [NSAttributedString.Key : Any]
            self.cardButtons[index].setAttributedTitle(NSAttributedString(string: String(repeating: card.symbol, count: card.count+1), attributes: strokeTextAttributes), for: .normal)
        }
    }
    
    @IBAction func turnInCardsButtonAction(_ sender: Any) {
        numberOfCardsThatWereDealt += 3
        showCardsThatWereDealt()
        updateViewModel()
    }

    private func updateViewModel() {
        for index in (0..<numberOfCardsThatWereDealt) {
            let card = self.game.cards[index]
            if (card.isSelect){
                self.cardButtons[index].layer.borderWidth = 3.0
                self.cardButtons[index].layer.borderColor = UIColor.blue.cgColor
                self.cardButtons[index].layer.cornerRadius = 8.0
            }
            else{
                self.cardButtons[index].layer.borderWidth = 0
                self.cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                self.cardButtons[index].layer.cornerRadius = 0
            }
            if (card.isMatched){
                self.cardButtons[index].setAttributedTitle(NSAttributedString(string: String()), for: .normal)
            }
        }
        self.scoreLabel.text = "\(scoreLabelText) \(self.game.score)"
        hint = self.game.findHint(countCards: numberOfCardsThatWereDealt)
        turnInCardButton.isEnabled = self.hint.isEmpty && numberOfCardsThatWereDealt != 24
        hintButton.isEnabled = !self.hint.isEmpty
    }
    
    @IBAction func showHint(_ sender: Any){
        for index in hint{
            self.cardButtons[index].layer.borderWidth = 3.0
            self.cardButtons[index].layer.borderColor = UIColor.green.cgColor
            self.cardButtons[index].layer.cornerRadius = 8.0
        }
        self.game.score -= 1
    }
}

