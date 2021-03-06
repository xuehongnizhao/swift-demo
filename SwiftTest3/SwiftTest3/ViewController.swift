//
//  ViewController.swift
//  SwiftTest3
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.redColor()
        label1.text = "这"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyanColor()
        label2.text = "是"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellowColor()
        label3.text = "一些"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.greenColor()
        label4.text = "牛逼的"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orangeColor()
        label5.text = "labels"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewDictionary = ["label1":label1,"label2":label2,"label3":label3,"label4":label4,"label5":label5]
        
        for label in viewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
            
        }
        
        view.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: ["labelHeight": 88], views: viewDictionary)))
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

