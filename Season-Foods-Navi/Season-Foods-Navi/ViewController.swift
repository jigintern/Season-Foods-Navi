//
//  ViewController.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/08/22.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
let myjson = """
{
    "recipilist": [
    {
    "id" : "1",
    "name" : "SampleFood",
    "picture" : "./img/recipi/samplefood.jpeg",
    "price" : "200",
    "link" : "./recipi"
    }
    ],
    
    "foodlsit": [
    {
    "id" : "1",
    "name" : "SampleVegetable",
    "picture" : "./img/foods/samplevegetable.png",
    "price" : "108",
    "link" : "./foods"
    }
    ]
}
"""

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout{

    // let CELLID = "menu"
    
    
    @IBOutlet var menucollection: UICollectionView!
    
    let SERVER:String! = "http://localhost:3000/"
    var menujson:JSON!
    var datas:recipilist?
    //var food_datas:foodlsit?
   // var users:Users?
    var menutable:UITableView!
  //  let jsondec =
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menucollection.delegate = self
        self.menucollection.dataSource = self
        Alamofire.request(SERVER,method: .get).responseString{response in
            switch response.result{
            case .success:
              //  print("result",response)
             /*   self.menujson = JSON(response.result.value ?? kill)
                guard let json = response.data else{return}
                let huga=JSON(json)
                if let data = myjson.data(using:.utf8){
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                        let result:Result = try decoder.decode(Result.self,from:data)
                        print(result)
                    }catch{
                        print("JSON convert failed",error.localizedDescription)
                    }
                }*/
                break
            case .failure(let ERROR):
                print(ERROR)
                break
            }
            
            
            //let jsondata = json["recipi"][0]["name"]
           // print(jsondata)
           // print(huga)
        //    let shiftjis_json_string = String(data:json,encoding: .shiftJIS)
        //    let utf8json = shiftjis_json_string!.data(using: .utf8)
           // print(json.description)
           // self.datas = try!
            
       //     self.datas = try! JSONDecoder().decode(recipilist.self,from:json)
            
        }
            /*switch response.result{
            case .success:
                print("result",response.data)
                self.menujson = JSON(response.result.value ?? kill)
                break
            case .failure(let ERROR):
                print(ERROR)
                break
            }
        }*/
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumLineSpacing = 0
        LAYOUT.itemSize = CGSize(width:self.view.frame.width/2,height:self.view.frame.height/3)
      //  LAYOUT.minimumInteritemSpacing = 0.1
                menucollection.collectionViewLayout = LAYOUT
    //    menucollection = UICollectionView(frame:self.view.frame,collectionViewLayout:LAYOUT)
      //  menucollection.delegate = self
      //  menucollection.dataSource = self
     //   menucollection.backgroundColor = UIColor.red
        
        view.addSubview(menucollection)
      //  menucollection = UICollectionView()
       // menucollection.dataSource = self as! UICollectionViewDataSource
       // menucollection.collectionViewLayout = UICollectionViewFlowLayout()
        
       // view.addSubview(menucollection)
       /* menutable = UITableView()
        menutable.frame = view.bounds
        menutable.rowHeight = view.frame.height/6
        menutable.delegate = self
        menutable.dataSource = self
        menutable.register(MenuCell.self,forCellReuseIdentifier:"MenuCell")
        view.addSubview(menutable)
        print(menujson as Any)*/
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number",section)
        return 50
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL=tableView.dequeueReusableCell(withIdentifier:"MenuCell",for: indexPath)as! MenuCell/*インデックスパスに対応したセルを返す。*/
        let index=indexPath.row
    /*    if thumbnails.count>index{
            cell.set(title:titles[index], channelTitle: channelTitles[index], image: thumbnails[index], url: url[index])
        }*/
        return CELL
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print("did",indexPath.row)
        print("\(indexPath.row)番目の行が選択されました。")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/6
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の画像が選択されました。")
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath)as! MyCustomCell
        cell.backgroundColor = .red
        
        return cell
    }
}
class MyCustomCell:UICollectionViewCell{
    
}


