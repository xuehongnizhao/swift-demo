
//
//  PlayData.swift
//  SwiftTest6Filter
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import Foundation
class PlayData{
    var allWords = [String]()
    var filteredWords = [String]()
    
    var wordCounts:NSCountedSet!
    init(){
        if let path = NSBundle.mainBundle().pathForResource("plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile:path,usedEncoding: nil) {
                allWords = plays.componentsSeparatedByCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
                allWords = allWords.filter { $0 != ""}
                wordCounts = NSCountedSet(array:allWords)
                
                let sorted = wordCounts.allObjects.sort{wordCounts.countForObject($0)>wordCounts.countForObject($1)}
                
                allWords = sorted as! [String]
                

            }
        }
        
        applyUserFilter("swift")
    }
    
    func applyFilter(filter:(String) -> Bool){
        filteredWords = allWords.filter(filter)
    }
    func applyUserFilter(input:String) {
        if let userNumber = Int(input) {
            applyFilter {self.wordCounts.countForObject($0) >= userNumber}
            
        }else{
            applyFilter { $0.rangeOfString(input,options: .CaseInsensitiveSearch) != nil}
        }
    }
}