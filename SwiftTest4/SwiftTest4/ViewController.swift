//
//  ViewController.swift
//  SwiftTest4
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score:Int = 0{
        didSet {
            scoreLabel.text = "得分\(score)"
        }
    }
    
    var level = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for subView in view.subviews where subView.tag == 1001 {
            let btn = subView as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), forControlEvents: .TouchUpInside)
            
        }
        
        loadLevel()
    
    }
    
    func loadLevel() {
        var cluesString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile:levelFilePath,usedEncoding: nil) {
                var lines = levelContents.componentsSeparatedByString("\n")
                
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                
                for (index,line) in lines.enumerate() {
                    let parts = line.componentsSeparatedByString(":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    cluesString += "\(index + 1).\(clue)\n"
                    
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    
                    solutions.append(solutionWord)
                    
                    let bits = answer.componentsSeparatedByString("|")
                    
                    letterBits += bits
                    
                }
                
            }
        }
        
       cluesLabel.text = cluesString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
        letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
        
    }
    @IBAction func submitAction(sender: UIButton) {
        
        if  let solutionPosition = solutions.indexOf(currentAnswer.text!) {
            var splitClues = answersLabel.text!.componentsSeparatedByString("\n")
            splitClues[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitClues.joinWithSeparator("\n")
            currentAnswer.text = ""
            score += 1
            clerarAction(sender)
            loadLevel()
            if score%7 == 0 {
                let ac = UIAlertController(title: "恭喜",message: "准备进入下一关",preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "出发", style: .Default, handler: levelUp))
                presentViewController(ac, animated: true, completion: nil)
                
            }
            
        }
    }
    @IBAction func clerarAction(sender: UIButton) {
        currentAnswer.text = ""
        
        for bt in activatedButtons {
            bt.hidden = false
        }
        activatedButtons.removeAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func levelUp(action:UIAlertAction) {
        level += 1
        solutions.removeAll(keepCapacity: true)
        
        loadLevel()
    }
    func letterTapped(button:UIButton) {
        currentAnswer.text = currentAnswer.text! + button.titleLabel!.text!
        activatedButtons.append(button)
        button.hidden = true
    }

}

