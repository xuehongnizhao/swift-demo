//
//  ViewController.swift
//  SwiftTest5Collection
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var people = [PersonModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add,target: self,action: #selector(addNewPerson))
    }
    func addNewPerson()  {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    func getDocumentsDirectory() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = path[0]
        
        return documentsDirectory
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage:UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        }else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            newImage = possibleImage
            
        }
        else{
            return
        }
        
        let imageName = NSUUID().UUIDString
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent          (imageName)
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            jpegData.writeToFile(imagePath, atomically:true)
        }
        
        let person = PersonModel(name:"未命名",image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCollectionViewCell
        
        let person = people[indexPath.row]
        
        cell.name.text = person.name
        

        
        let path = getDocumentsDirectory().stringByAppendingPathComponent(person.image)
        cell.image.image = UIImage(contentsOfFile:path)
        cell.image.layer.borderWidth = 2
        cell.image.layer.borderColor = UIColor(red: 0,green: 1,blue: 222,alpha: 0.3).CGColor
        cell.image.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let person = people[indexPath.row]

        let ac = UIAlertController(title: "重命名",message: "",preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        ac.addAction(UIAlertAction(title: "取消",style: .Cancel,handler:nil))
        ac.addAction(UIAlertAction(title: "确定",style: .Default){
            [unowned self,ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            
            self.collectionView.reloadData()
            })
        presentViewController(ac, animated: true, completion: nil)
        
    }
    

}

