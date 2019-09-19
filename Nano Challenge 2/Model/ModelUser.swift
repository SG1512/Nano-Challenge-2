//
//  ModelUser.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 19/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import Foundation

var tableUser = [User]()

class User{
    var userNamaMakanan: String
    var userKaloriMakanan: Int
    
    init(userNamaMakanan: String, userKaloriMakanan: Int){
        self.userNamaMakanan = userNamaMakanan
        self.userKaloriMakanan  = userKaloriMakanan
    }
}
