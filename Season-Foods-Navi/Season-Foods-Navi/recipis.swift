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
struct recipilist:Codable{
    let result:[recipi]
}
struct recipi:Codable{
    let id:Int
    var name:String
    var picture:String
    var foods:[foods]
    var cal:Int!
    var pref_id:Int
    var prefecture:String
    var howto:String
    var post:Bool
    var cost:String
    var time:String
    //let id,name,picture,price,area:String
    //let used:[String]
}
struct foods:Codable{
  //  let foods:[fod]
    let id:Int
    let name:String
    let syun:Bool!
    let pref_id:Int
}
/*struct fod:Codable{
 let id:Int
 let name:String
 let syun:Bool!
 let pref_id:Int
}*/
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
struct result: Codable {
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
    let rank:String
}

struct food_info:Codable{
    var food_info:[foodinfo]!
    var prices:[price]!
    var nutritional:[nutritional]!
}
struct nutritional:Codable{
    var id:Int!
    var info:[inform]!
}
struct inform:Codable{
    var name:String
    var value:String
    var unit:String
}
struct foodinfo:Codable{
    var id:Int!
    var name:String!
    var base_food:Int!
    var picture:String!
    var months:String
    var pref_id:Int!
    var post:Int!
}
struct price:Codable{
    var key:[key]
}

struct key:Codable{
    var HighPrice:[String]!
    var MeduimPrice:[String]!
}
// MARK: - Recipe
struct Recipe: Codable {
    var foodInfo: FoodInfo!
    var prices: [String: Price]!
    var nutritional: Nutritional!
    
    enum CodingKeys: String, CodingKey {
        case foodInfo = "food_info"
        case prices, nutritional
    }
}

// MARK: - FoodInfo
struct FoodInfo: Codable {
    var id: Int
    var name: String
    var baseFood, picture: JSONNull?
    var months: String
    var prefID, post: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case baseFood = "base_food"
        case picture, months
        case prefID = "pref_id"
        case post
    }
}

// MARK: - Nutritional
struct Nutritional: Codable {
    var food: String!
    var info: [Info]!
}

// MARK: - Info
struct Info: Codable {
    var name, value: String!
    var unit: Unit!
}

enum Unit: String, Codable {
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
}

// MARK: - Price
struct Price: Codable {
    let highPrice, mediumPrice: [String]!
    
    enum CodingKeys: String, CodingKey {
        case highPrice = "HighPrice"
        case mediumPrice = "MediumPrice"
    }
}
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
struct eiyou:Codable{
    let food:String!
    let info:[info]!
}
struct info:Codable{
    let name:String!
    var value:String!
    let unit:String!
}
/*struct foodsinfo:Codable{
}*/
