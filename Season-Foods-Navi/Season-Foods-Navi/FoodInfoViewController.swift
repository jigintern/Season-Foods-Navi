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
let needs = [2650.0,60.0,20.0,250.0,3149.0,2500.0,650.0,340.0,0.0,7.0]
class FoodInfoViewController:UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{
 //   var scrollView:UIScrollView!
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var graphView: LineChartView!
   // var barView: LineChartView!
    var foodName = "食材"
    @IBOutlet weak var eiyouTableView: UITableView!
    @IBOutlet weak var foodNameLabel: UILabel!
    //var foodInfo:food_info!
    var food_info:Recipe!
    //let foodInfoSERVER = "storings"
    var foodid = 1
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
   
      //  print(foodInfo)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eiyouTableView.delegate = self
        eiyouTableView.dataSource = self
      //  print(foodInfo)
      /*  scrollView = UIScrollView()
        
        scrollView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height)
        scrollView.bounces = false
        scrollView.center = self.view.center
        scrollView.contentSize = CGSize(width:self.view.frame.width,height:self.view.frame.height)
        scrollView.indicatorStyle = .default
        scrollView.delegate = self*/
       // scrollView.addSubview(foodNameLabel)
        //self.view.addSubview(scrollView)
        setchart()
        if food_info.foodInfo.picture != nil{
            
            foodImageView.sd_setImage(with: URL(string:"\(food_info.foodInfo.picture)"), placeholderImage:UIImage(named:"loading.png"))
        }else{
            foodImageView.image = UIImage(named:"notfound.png")
        }
    }
    func setchart(){
       //if foodInfo == nil{return}
        foodNameLabel!.text = foodName//foodInfo.name
        var entries:[BarChartDataEntry] = []
        if food_info.prices == nil{
            return
        }
        for key in food_info.prices.keys{
        
        }
     /*   for  i in 0 ..< food_info.prices.merging(:, uniquingKeysWith: <#T##(Price, Price) throws -> Price#>){
            entries.append(BarChartDataEntry(x:Double(i),y:Double(foodInfo.monthly_cost[i])))
        }*/
        let set = LineChartDataSet(entries:entries,label:"価格")
        graphView.data = LineChartData(dataSet: set)
      //  scrollView.addSubview(graphView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if food_info == nil {
            return 0
        }
        return 10
       // return foodInfo.eiyou.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if food_info.nutritional == nil{
         //   print("yes")
            cell.textLabel?.text = "データがありません"
            return cell
        }
        if indexPath.row == 0{
            cell.textLabel?.text = "材料の栄養価(100gあたり)\t 成人男性の目標摂取量との割合"
            return cell
        }
        
        if food_info.nutritional.info[indexPath.row-1].value == ""{
            cell.textLabel?.text = "\((food_info.nutritional.info[indexPath.row-1].name)!):0\((food_info.nutritional.info[indexPath.row-1].unit)!)"
        }
        else{
            if needs[indexPath.row-1] == 0{
            cell.textLabel?.text = "\((food_info.nutritional.info[indexPath.row-1].name)!):\((food_info.nutritional.info[indexPath.row-1].value)!)\((food_info.nutritional.info[indexPath.row-1].unit)!)"
            }
            var value = food_info.nutritional.info[indexPath.row-1].value
            value = value?.replacingOccurrences(of: ",", with: "")
            var val = atof(value)
            let persent = 10000*val/needs[indexPath.row-1]
            cell.textLabel?.text = "\((food_info.nutritional.info[indexPath.row-1].name)!):\((food_info.nutritional.info[indexPath.row-1].value)!)\((food_info.nutritional.info[indexPath.row-1].unit)!)\t\(round(persent)/100)%"
        }
       // var value = atof(foodInfo.eiyou.info[indexPath.row]*/
        return cell
    }
}

