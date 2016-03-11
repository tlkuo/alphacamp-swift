//
//  student.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/11.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation

struct Student {
    var name: String
    var score: Int
}

struct Class {
     var students: [Student] = [
        Student(name: "Petper", score: 100),
        Student(name: "John", score: 95)   
    ]
}


