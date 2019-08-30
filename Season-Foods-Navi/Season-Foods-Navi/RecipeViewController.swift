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
var check:[Bool] = []
var tapped_row = 0
class RecipeViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    var recipename = ""
    var recipeScrollView:UIScrollView!
    var recipeInfo:rakuten!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBOutlet weak var recipeimageview: UIImageView!
    
    @IBOutlet weak var recipematerial: UITableView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     /*   let goButton = UIButton(frame: CGRect(x: 0,y: 0,width: 100,height:100))
        goButton.setTitle("\(recipename)", for: .normal)
        goButton.backgroundColor = UIColor.red
        goButton.addTarget(self, action: #selector(RecipeViewController.goNext(_:)), for: .touchUpInside)*/
       // view.addSubview(goButton)
      //  print(recipeInfo)
        recipeScrollView = UIScrollView()
        setRecipeView()
        recipeScrollView.bounces = false
        recipeScrollView.contentSize = CGSize(width:self.view.frame.width,height:self.view.frame.height)
        recipeScrollView.center = self.view.center
        recipeScrollView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height)
        recipeScrollView.indicatorStyle = .default
        recipeScrollView.delegate = self
    //    self.view.addSubview(recipeScrollView)
        recipematerial?.frame = view.bounds
        recipematerial?.rowHeight = view.frame.height/6
        recipematerial?.delegate = self
        recipematerial?.dataSource = self
      //  recipematerial.reloadData()
    }
    func setRecipeView(){
        if recipeInfo == nil{
            return
        }
    //    recipeimageview = UIImageView()
       // var image = UIImage()
        recipeimageview.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.width)
      print(recipename)
        recipeimageview.sd_setImage(with:URL(string: recipeInfo.foodImageUrl),placeholderImage: UIImage(named:"loading.png"))
       // recipeScrollView.addSubview(recipeimageview)
   //     var recipeNameLabel = UILabel()
     //   recipeNameLabel.frame =  CGRect(x:0,y:recipeimageview.frame.maxY,width:self.view.frame.width,height:20)
        recipeNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        recipeNameLabel.numberOfLines = 2
        recipeNameLabel.text = recipename
        recipeNameLabel.font = UIFont.systemFont(ofSize: 20.0)
        recipematerial.isUserInteractionEnabled = true
        recipematerial.allowsSelection = true
        //recipeScrollView.addSubview(recipeNameLabel)
        // material_table = UITableView()
        //material_table.frame = CGRect(x:,y:,width:view.,height:)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCustomCell", for: indexPath)as! RecipeCustomCell
        cell.materialName.text = "Loading..."
      //  print(recipeInfo)
        if recipeInfo == nil {
            return cell
        }
        cell.materialName.text = recipeInfo.recipeMaterial[indexPath.row]
       // var image = UIImage(named:"check.png")
     //   image?.scaleImage(scaleSize:image!.size.width/CGFloat(self.view.frame.width/12))
        check.append(false)
     //   print(check)
        cell.checkbox.setImage(UIImage(named:"check.png"), for: .normal)
        cell.checkbox.tag = indexPath.row
        cell.checkbox.isUserInteractionEnabled = true
        cell.checkbox.addTarget(self, action: #selector(checked(_ :)), for: .touchUpInside)
     //   checked(cell.checkbox)
        //cell.materialName.isUserInteractionEnabled = false
        return cell
        /* let CELL=tableView.dequeueReusableCell(withIdentifier:"MenuCell",for: indexPath)as! MenuCell/*インデックスパスに対応したセルを返す。*/
        let index=indexPath.row
        return CELL*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  print("did",indexPath.row)
        print("\(indexPath.row)番目の行が選択されました。")
        tapped_row = indexPath.row
        performSegue(withIdentifier: "toFoodInfo", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFoodInfo" {
            //  let nc = segue.destination as! UINavigationController
            let nextView = segue.destination as! FoodInfoViewController
            //print(rakutenResults[0].result[tapped_path])
            nextView.foodName = recipeInfo.recipeMaterial[tapped_row]
          //  nextView.recipeInfo = rakutenResults[0].result[tapped_path]
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/15
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipeInfo == nil{ return 1}
        return recipeInfo.recipeMaterial.count
            
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
class RecipeCustomCell:UITableViewCell{
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var materialName: UILabel!
}
