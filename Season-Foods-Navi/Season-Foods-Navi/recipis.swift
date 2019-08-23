//
//  recipis.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/08/22.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
struct Foodlsit: Codable {
    let id, name, picture, price: String
    let link: String
}
struct recipi:Codable{
    let id,name,picture,price,area:String
    let used:[String]
}
struct recipilist:Codable{
    let recipi:[recipi]
}
struct food:Codable{
    let id,name,picture,price,area:String
}
struct foodList:Codable{
    let food:[food]
}
struct seasonFood:Codable{
    let name:String
    let season:[String]
}
struct seasonFoods:Codable{
    let seasonFood:[seasonFood]
}
struct Result: Codable {
    let recipilist: [Foodlsit]
}
