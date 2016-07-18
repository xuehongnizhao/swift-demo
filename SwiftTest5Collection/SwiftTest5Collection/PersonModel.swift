//
//  PersonModel.swift
//  SwiftTest5Collection
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit

class PersonModel: NSObject {
    var name:String
    var image:String
    init(name:String,image:String) {
        self.name = name
        self.image = image
    }
}
