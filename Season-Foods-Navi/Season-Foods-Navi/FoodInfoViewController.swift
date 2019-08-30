//
//  FoodInfoViewController.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/08/27.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreLocation
import Charts
let foodjson = """
{
"monthly_cost": [100,110,120,130,140,150,160,170,180,190,200,190,180],
"eiyou":{ "food": '穀類/あわ/精白粒',
"info":
[ { "name": "エネルギー", "value": "367", "unit": "kcal" },
{ "name": "たんぱく質", "value": "11.2", "unit": "g" },
{ "name": "脂質", "value": "4.4", "unit": "g" },
{ "name": "炭水化物", "value": "69.7", "unit": "g" },
{ "name": "ナトリウム", "value": "1", "unit": "mg" },
{ "name": "カリウム", "value": "300", "unit": "mg" },
{ "name": "カルシウム", "value": "14", "unit": "mg" },
{ "name": "マグネシウム", "value": "110", "unit": "mg" },
{ "name": "コレステロール", "value": "", "unit": "mg" },
{ "name": "食塩相当量", "value": "0", "unit": "g" } ] },
"syun":[2,3,4,5],
"name":"宇宙"
}
"""
class FoodInfoViewController:UIViewController,UIScrollViewDelegate{
    
    var scrollView:UIScrollView!
    var barView: LineChartView!
    var foodName = "食材"
    var foodNameLabel:UILabel!
    var foodInfo:foodinfo!
    let SERVER = "storings"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(SERVER,method: .get).responseString{response in
            switch response.result{
            case .success:
                /* print("result",response)
                 menujson = JSON(response.result.value ?? kill)
                 guard let json = response.data else{return}*/
                if let data = foodjson.data(using:.utf8){
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                        self.foodInfo = try decoder.decode(foodinfo.self,from:response.data!)
                        //  print(result)
                        //  results.append(result)
                        //  print("temp",results)
                    }catch{
                        print("JSON convert failed",error.localizedDescription)
                    }
                }
                break
            case .failure(let ERROR):
                print(ERROR)
                break
            }
        }
        if let data = foodjson.data(using:.utf8){
            let decoder:JSONDecoder = JSONDecoder()
            do{
                print("data",data,foodjson)
                self.foodInfo = try decoder.decode(foodinfo.self,from:data)
                  print(foodInfo)
                //  results.append(result)
                //  print("temp",results)
            }catch{
                print("JSON convert failed",error.localizedDescription)
            }
        }
        print(foodInfo)
        foodNameLabel = UILabel()
        foodNameLabel.text = foodName
        foodNameLabel.frame = CGRect(x:0,y:0,width:100,height:50)
        scrollView = UIScrollView()
        setchart()
        scrollView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height)
        scrollView.bounces = false
        scrollView.center = self.view.center
        scrollView.contentSize = CGSize(width:self.view.frame.width,height:self.view.frame.height)
        scrollView.indicatorStyle = .default
        scrollView.delegate = self
        scrollView.addSubview(foodNameLabel)
        self.view.addSubview(scrollView)
    }
    func setchart(){
        if foodInfo == nil{return}
        barView = LineChartView()
        barView.frame = CGRect(x:0,y:self.view.frame.height/3,width:self.view.frame.width,height:self.view.frame.height/3 )
        var entries:[BarChartDataEntry] = []
        for  i in 0 ..< foodInfo.monthly_cost.count{
            entries.append(BarChartDataEntry(x:Double(i),y:Double(foodInfo.monthly_cost[i])))
        }
        let set = LineChartDataSet(entries:entries,label:"価格")
        barView.data = LineChartData(dataSet: set)
        scrollView.addSubview(barView)
    }
}
