//
//  ModelMakanan.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 19/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import Foundation

var tableMakanan = [Makanan]()

class Makanan{
    var namaMakanan: String
    var kaloriMakanan: Int
    
    init(namaMakanan: String, kaloriMakanan: Int){
        self.namaMakanan = namaMakanan
        self.kaloriMakanan  = kaloriMakanan
    }
}
