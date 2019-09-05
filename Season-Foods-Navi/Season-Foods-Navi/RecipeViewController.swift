//
//  RecipeViewController.swift
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
import WebKit
var check:[Bool] = []
var tapped_row = 0
class RecipeViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    let webView = WKWebView()
    var recipename = ""
    var recipeScrollView:UIScrollView!
    var recipeInfo:rakuten!
    var recipiInfo:recipi!
    var foods:foods!
    var foodInfo:Recipe!
    var foodsInfo:[Recipe] = []
    var foodsServer:String!
//    @IBOutlet weak var howtomake: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBOutlet weak var recipeimageview: UIImageView!
    
    @IBOutlet weak var recipematerial: UITableView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print(recipeInfo)
      //  recipeScrollView = UIScrollView()
      /*  recipeScrollView.bounces = false
        recipeScrollView.contentSize = CGSize(width:self.view.frame.width,height:self.view.frame.height)
        recipeScrollView.center = self.view.center
        recipeScrollView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height)
        recipeScrollView.indicatorStyle = .default
        recipeScrollView.delegate = self*/
    //    self.view.addSubview(recipeScrollView)
        recipematerial?.frame = view.bounds
        recipematerial?.rowHeight = view.frame.height/6
        recipematerial?.delegate = self
        recipematerial?.dataSource = self
  //      howtomake?.delegate = self
  //      howtomake?.dataSource = self
      //  recipematerial.reloadData()
        webView.frame = self.view.frame
        setRecipeView()
        setRecipeTable()
       // webView.navigationDelegate = self as! WKNavigationDelegate
        //webView.uiDelegate = self as! WKUIDelegate
    }
    func setRecipeTable(){
        if recipiInfo == nil{return}
        for i in 0..<recipiInfo.foods.count{
            if self.recipiInfo.foods[i].id == 0{
                 self.foodsServer = "http://localhost:3000/api/v1/food/1"
            }else{
            self.foodsServer = "http://localhost:3000/api/v1/food/\(recipiInfo.foods[i].id)"
            }
            Alamofire.request(foodsServer,method: .get).responseString{response in
                switch response.result{
                case .success:
                    /* print("result",response)
                     guard let json = response.data else{return}*/
                    //if let data = json.data(using:.utf8){
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                        self.foodInfo = try decoder.decode(Recipe.self,from:response.data!)
                        self.foodsInfo.append(self.foodInfo)
                       // print(self.foodsInfo)

                    }catch{
                        print(response)
                        print("JSON convert failed",error.localizedDescription)
                    }
                    break
                case .failure(let ERROR):
                    print(ERROR)
                    break
                }
                self.recipeNameLabel.text = self.recipename
                print(response)
                self.recipematerial.reloadData()
                
            }
        }
        // print(self.foodsInfo)
    }
    func setRecipeView(){
        if recipiInfo == nil{
            return
        }
    //    recipeimageview = UIImageView()
       // var image = UIImage()
        recipeimageview.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.width)
    //  print(recipename)
      //  print(recipeInfo)
//        recipeimageview.sd_setImage(with:URL(string: recipiInfo.picture),placeholderImage: UIImage(named:"loading.png"))
        recipeimageview.sd_setImage(with:URL(string: recipiInfo.picture),placeholderImage: UIImage(named:"loading.png"))
       // recipeScrollView.addSubview(recipeimageview)
   //     var recipeNameLabel = UILabel()
     //   recipeNameLabel.frame =  CGRect(x:0,y:recipeimageview.frame.maxY,width:self.view.frame.width,height:20)
        recipeNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        recipeNameLabel.numberOfLines = 2
        recipeNameLabel.text = recipename
        recipeNameLabel.font = UIFont.systemFont(ofSize: 20.0)
        recipematerial.isUserInteractionEnabled = true
        recipematerial.allowsSelection = true
  //      recipematerial.tag = 1
  //      howtomake.tag = 2
        //recipeScrollView.addSubview(recipeNameLabel)
        // material_table = UITableView()
        //material_table.frame = CGRect(x:,y:,width:view.,height:)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  print(recipeInfo)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCustomCell", for: indexPath)as! RecipeCustomCell
        cell.materialName.text = "Loading..."
        cell.checkbox.setImage(UIImage(named:"check.png"), for: .normal)
        cell.syun.setImage(UIImage(named:"syun"), for: .normal)
     //   cell.syun.isHidden = true
     //   cell.checkbox.isHidden = true
        if foodsInfo.count == 0 {
            return cell
        }
      //  print(recipeInfo.recipeMaterial.count)
        if indexPath.row == 0{
            check.removeAll()
        }
        if indexPath.row > 0 && indexPath.row <= foodsInfo.count{
        cell.materialName.text = recipiInfo.foods[indexPath.row-1].name//recipeInfo.recipeMaterial[indexPath.row-1]//
       // var image = UIImage(named:"check.png")
     //   image?.scaleImage(scaleSize:image!.size.width/CGFloat(self.view.frame.width/12))
        check.append(false)
     //   print(recipeInfo.recipeMaterial[indexPath.row-1])
     //   print(check)
        cell.checkbox.setImage(UIImage(named:"check.png"), for: .normal)
        cell.checkbox.tag = indexPath.row-1
        cell.checkbox.isUserInteractionEnabled = true
        cell.checkbox.addTarget(self, action: #selector(checked(_ :)), for: .touchUpInside)
        //cell.syun.image = UIImage(named:"syun")
        cell.syun.setImage(UIImage(named:"syun"), for: .normal)
        cell.syun.setTitleColor(.red, for: .normal)
        let months = foodsInfo[indexPath.row-1].foodInfo.months.components(separatedBy:  ",")
        cell.checkbox.isHidden = false
            cell.syun.isHidden = false
            cell.checkbox.isEnabled = true
            cell.syun.isEnabled = true
   /*     if !foodsInfo[indexPath.row-1].months{
                cell.syun.isHidden = true
                 cell.syun.isEnabled = false
            }
            */
     //   checked(cell.checkbox)
        //cell.materialName.isUserInteractionEnabled = false
            
        }else if indexPath.row == 0{
            //cell.materialName.text = "Loading..."
            cell.materialName?.text = "材料一覧(タップして詳細を確認)"
            cell.syun.isHidden = true
            cell.checkbox.isHidden = true
            cell.syun.isEnabled = false
            cell.checkbox.isEnabled = false
            cell.selectionStyle = .none
            //return cell
        }else if indexPath.row == recipiInfo.foods.count+1{//recipeInfo.recipeMaterial.count+1{//
            cell.materialName?.text = "作り方"
            cell.syun.isHidden = true
            cell.checkbox.isHidden = true
            cell.syun.isEnabled = false
            cell.checkbox.isEnabled = false
            cell.selectionStyle = .none
        }else{
            
            cell.materialName?.text = "ここをタップするとも詳細なレシピのベージにジャンプします"
          //   cell.materialName?.text = recipeInfo.howto
             
 
            cell.syun.isHidden = true
            cell.checkbox.isHidden = true
            cell.syun.isEnabled = false
            cell.checkbox.isEnabled = false
            cell.materialName?.numberOfLines = 10
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == recipiInfo.foods.count+2 && !recipiInfo.post{
            let targetUrl = recipiInfo.howto
            let urlRequest = URLRequest(url:URL(string:targetUrl)!)
            webView.load(urlRequest)
            self.view.addSubview(webView)
        }
        if indexPath.row > foodsInfo.count||indexPath.row == 0{
            return
        }
        if recipiInfo.foods[indexPath.row-1].id == 0{
            print("idが0")
            return
        }
        tapped_row = indexPath.row-1
         print("\(indexPath.row)番目の行が選択されました。\(recipiInfo.foods[tapped_row].name)")
        performSegue(withIdentifier: "toFoodInfo", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFoodInfo" {
            //  let nc = segue.destination as! UINavigationController
            var next = 1
            let nextView = segue.destination as! FoodInfoViewController
            let id = recipiInfo.foods[tapped_row].name
            for i in 0..<foodsInfo.count{
                print(recipiInfo.foods[i].name,id)
                if recipiInfo.foods[i].name == id{
                    next = i
                    print(next)
                    break
                }
            }
            nextView.food_info = foodsInfo[next]
            nextView.foodName = foodsInfo[next].foodInfo.name
            //print(rakutenResults[0].result[tapped_path])
         //   nextView.foodName = recipeInfo.recipeMaterial[tapped_row]
   //         nextView.foodid = 
         //   nextView.foodInfo = [0].result[tapped_path]
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/15
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodsInfo == nil{ return 1}
       //print(recipeInfo.recipeMaterial.count)
       if !recipiInfo.post{
            return recipiInfo.foods.count+3
        }
        
        return recipiInfo.foods.count+100
    //return recipeInfo.recipeMaterial.count+10
        
            
    }
    @objc func checked(_ sender: UIButton) {
//        print("tapped!!")
//        print(check)
        check[sender.tag] = !check[sender.tag]
        if check[sender.tag]{
            sender.setBackgroundImage(UIImage(named:"checked.png"), for: .normal)
        }else{
            sender.setBackgroundImage(UIImage(named:"check.png"), for: .normal)
        }
    }
    class MyScrollView: UIScrollView {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            superview?.touchesBegan(touches, with: event)
        }
        
    }

}
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
extension ViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}
class RecipeCustomCell:UITableViewCell{
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var materialName: UILabel!
    
   // @IBOutlet weak var syun: UIImageView!
    
    @IBOutlet weak var syun: UIButton!
}
