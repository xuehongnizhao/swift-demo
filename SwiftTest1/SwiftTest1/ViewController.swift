//
//  ViewController.swift
//  SwiftTest1
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var buton1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        buton1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        buton1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        askQustion(nil)
    }
    
    func askQustion(action: UIAlertAction!) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        buton1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        
        title = countries[correctAnswer].uppercaseString
    }
    
    @IBAction func buttonAction(sender: UIButton){
        var title:String
        
        if sender.tag == correctAnswer {
            title = "正确"
            score += 1
        }else{
            title = "错误"
            score -= 1
        }
        
        let ac = UIAlertController(title:title,message: "你的记录是\(score).",preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title:"继续",style: .Default,handler: askQustion))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

