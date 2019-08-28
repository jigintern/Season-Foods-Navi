//
//  recipis.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/08/22.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
struct Foodlsit: Codable {
    let id, name, picture, price,area: String
    let used: [String]
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
    let recipilist: [recipi]
}
struct locate:Codable{
    let latitude:Float
    let longitude:Float
}
struct rakutenResult:Codable{
    let result:[rakuten]
}
struct rakuten:Codable{
    let recipeId:Int
    let recipeTitle:String
    let recipeUrl:String
    let foodImageUrl:String
    let mediumImageUrl:String
    let smallImageUrl:String
    let pickup:Int
    let shop:Int
    let nickname:String
    let recipeDescription:String
    let recipeMaterial:[String]
    let recipeIndication:String
    let recipeCost:String
    let recipePublishday:String
    let rank:Int
}
struct foodinfo:Codable{
    let monthly_cost:[Int]
    let eiyou:[String]
    let syun:[Int]
    let name:String
}
