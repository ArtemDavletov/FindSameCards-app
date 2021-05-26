//
//  ViewController.swift
//  FindSameCards
//
//  Created by Artem on 26.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet var buttonsCollection: [UIButton]!
    
    var checkedButtons: Array<UIButton> = []
    var openedButtons: Array<UIButton> = []
    var allEmojies: Array<String> = []
    var emojies: Array<String> = []
    
    func defineRandomEmojies() {
        for i in 0x1F601...0x1F64F {
            self.allEmojies.append(String(UnicodeScalar(i) ?? "-"))
        }
        allEmojies.shuffle()
        
        for i in 1...buttonsCollection.count/2 {
            emojies.append(allEmojies[i])
            emojies.append(allEmojies[i])
        }
        
        emojies.shuffle()
    }
    
    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    func flipButton(emoji: String, button: UIButton) {
        button.setTitle(emoji, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        openedButtons.append(button)
    }
    
    func closeButton(button: UIButton) {
        button.setTitle("", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4565797448, blue: 0.9212551713, alpha: 1)
    }
    
    func checkOpened() {
        if openedButtons[0].currentTitle != openedButtons[1].currentTitle {
            closeButton(button: openedButtons[0])
            closeButton(button: openedButtons[1])
        } else {
            checkedButtons.append(openedButtons[0])
            checkedButtons.append(openedButtons[1])
        }
            
        openedButtons.removeAll()
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if emojies.isEmpty {
            defineRandomEmojies()
        }
        
        if !checkedButtons.contains(sender){
            let buttonIndex = buttonsCollection.firstIndex(of: sender)!
            flipButton(emoji: emojies[buttonIndex], button: sender)
            
            if openedButtons.count == 2 {
                touches += 1
                let delayTime = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
                    self.checkOpened()
                })
            }
        }
    }
    
    func reset() {
        for button in buttonsCollection {
            closeButton(button: button)
        }
        defineRandomEmojies()
        touches = 0
        openedButtons.removeAll()
        checkedButtons.removeAll()
        emojies.removeAll()
    }
    
    
    @IBAction func resetAction(_ sender: UIButton) {
        reset()
    }
}

