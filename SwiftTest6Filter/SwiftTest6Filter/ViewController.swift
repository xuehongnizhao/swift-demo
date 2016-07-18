//
//  ViewController.swift
//  SwiftTest6Filter
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search,target: self,action: #selector(searchTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel,target: self,action:#selector(clearTapped) )
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.filteredWords.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath)
        
        let word = playData.filteredWords[indexPath.row]
        cell.textLabel!.text = word
        cell.detailTextLabel!.text = "\(playData.wordCounts.countForObject(word))"
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.playData.filteredWords)
    }
    func searchTapped()  {
       let ac = UIAlertController(title: "筛选",message: nil,preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        ac.addAction(UIAlertAction(title: "筛选",style: .Default,handler: {
            [unowned self] _ in
            let userINput = ac.textFields?[0].text ?? "0"
            self.playData.applyUserFilter(userINput)
            self.tableView.reloadData()
            
        }))
        ac.addAction(UIAlertAction(title: "取消",style: .Cancel,handler: nil))
        presentViewController(ac,animated: true,completion: nil)
    }
    func clearTapped(){
        self.playData.applyUserFilter("swift")
        self.tableView.reloadData()
    }
}

