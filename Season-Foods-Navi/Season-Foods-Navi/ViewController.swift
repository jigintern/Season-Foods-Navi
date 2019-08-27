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
import CoreLocation
let myjson = """
{
    "recipilist": [
    {
"id" : "1",
"name" : "SampleFood",
"picture" : "./img/recipi/SampleFood.jpeg",
"price" : "200",
"area" : "all",
"used":[
"にんじん", "ジャガイモ" , "null"
]
},
{
"id" : "2",
"name" : "焼き鯖サンド",
"picture" : "https://tabihow.jp/imgtrip/trip118s2.jpg",
"price" : "Null",
"area" : "福井",
"used":[
"レタス", "玉ねぎ" , "鯖" , "パプリカ"
]
},
{
"id" : "3",
"name" : "若狭たかはま鮨",
"picture" : "https://tabihow.jp/imgtrip/trip118u1.jpg",
"price" : "900",
"area" : "福井",
"used":[
"にんじん", "ジャガイモ" , "null"
]
},
{
"id" : "4",
"name" : "とんちゃん",
"picture" : "https://tabihow.jp/imgtrip/trip118d2.jpg",
"price" : "400",
"area" : "福井",
"used":[
"豚肉" , "長ネギ" , "もやし"
]
},
{
"id" : "null",
"name" : "null",
"picture" : "./img/recipi/.jpeg",
"price" : "null",
"area" : "null",
"used":[
"null" , "null" , "null"
]

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
var isfirstload = true
var menujson:JSON!
var results:[Result]=[]
var locationmaneger:CLLocationManager!
var rakutenResults:[rakutenResult]=[]
class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate{

    // let CELLID = "menu"
    
    @IBOutlet var menucollection: UICollectionView!
    let SERVER:String! = "http://localhost:3000/public"
    var datas:recipilist?
    //var food_datas:foodlsit?
   // var users:Users?
    var menutable:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menucollection.delegate = self
        self.menucollection.dataSource = self
      /*  Alamofire.request(SERVER,method: .get).responseString{response in
            switch response.result{
            case .success:
               /* print("result",response)
                menujson = JSON(response.result.value ?? kill)
                guard let json = response.data else{return}*/
                if let data = myjson.data(using:.utf8){
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                      //  let result:Result = try decoder.decode(Result.self,from:json)
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
          }*/
        
            if let data = myjson.data(using:.utf8){
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    let result:Result = try decoder.decode(Result.self,from:data)
                 //   print(result,result.recipilist[0].id)
                    results.append(result)
                }catch{
                    print("JSON convert failed",error.localizedDescription)
                }
                }
      //  print(results)
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
        LAYOUT.minimumLineSpacing = 1
        LAYOUT.itemSize = CGSize(width:self.view.frame.width/2-CGFloat(5),height:self.view.frame.height/3)
      //  LAYOUT.minimumInteritemSpacing = 0.1
                menucollection.collectionViewLayout = LAYOUT
        
        view.addSubview(menucollection)
        menucollection.reloadData()
        Setuplocationmanager()
        searchCategoryRanking()
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の画像が選択されました。")
        print(results[0].recipilist[indexPath.row].name)
    }
    func Setuplocationmanager(){
        locationmaneger = CLLocationManager()
        locationmaneger.requestWhenInUseAuthorization()
        var status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined || status == CLAuthorizationStatus.denied{
                locationmaneger.requestWhenInUseAuthorization()
                status = CLLocationManager.authorizationStatus()
        }else if status == CLAuthorizationStatus.authorizedWhenInUse{
            locationmaneger.delegate = self
            locationmaneger.distanceFilter = 10
            locationmaneger.startUpdatingLocation()
        }
       //  print(status)
    }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.first
            let latitude:Double = Double((location?.coordinate.latitude)!)
            let longitude:Double = Double((location?.coordinate.longitude)!)
            let locate :[String:Double] = ["Latitude": latitude, "Longitude": longitude]
            print("latitude: \(latitude)\nlongitude: \(longitude)")
            let encoder:JSONEncoder = JSONEncoder()
            let urlstring = "http://localhost:3000/api/v1/menu"
          //  let parameter = try? encoder.encode(locate)
         //   Alamofire.request(urlstring,method: .post,parameters: locate)
         /*   Alamofire.request(SERVER, method: .post, parameters:locate, encoding:JSONEncoding.default , headers: [
                "Contenttype": "application/json"
                ]).responseJSON{ response in
                    if let result = response.result.value as? [String:Double]{
                        print(result)
                    }
            }*/
        }
    }

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print(results.count)
        if results.count == 0{
            return 0
        }
        return results[0].recipilist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if results.count == 0{
       //     print("first")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath)as! LoadingCell
            cell.backgroundColor = .white
            cell.loading.frame = CGRect(x:0,y:0,width:cell.frame.width,height:cell.frame.height)
            cell.loading.startAnimating()
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath)as! MyCustomCell
   //     print("second")
        cell.backgroundColor = .white
        cell.imageview = UIImageView(frame:cell.frame)
        print(indexPath.row)
       var imagepath = results[0].recipilist[indexPath.row].picture
        
        var imageurl:String!
        if imagepath.hasPrefix("."){
            imagepath.removeFirst()
            imageurl = "http://localhost:3000\(imagepath)"
        }else{
            imageurl = "\(imagepath)"
        }
        
        print(imageurl)
        cell.imageview.sd_setImage(with: URL(string:imageurl), placeholderImage:UIImage(named:"loading.png"))
        
        if imagepath == "./img/recipi/.jpeg" {
            cell.imageview.image = UIImage(named: "dust.png")
        }
        self.view.addSubview(cell.imageview)
       // isfirstload = false
        return cell
    }
}
extension ViewController{
    func searchCategoryRanking(){
        let APPLICATION_ID = 1077779649169295378
        var today = "\(Date())"
        today = today.replacingOccurrences(of:"-", with:"")
        today = String(today.prefix(8))
        print(today)
        var rakutenurl = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=\(APPLICATION_ID)&categoryType=large"
        Alamofire.request(rakutenurl,method: .get).responseString{response in
            switch response.result{
            case .success:
                 print("result",response)
               //  menujson = JSON(response.result.value ?? kill)
                 guard let json = response.data else{return}
                 if let data = myjson.data(using: .utf8){
                    var str = String(data: json, encoding: .utf8)!
                    let delete = str.replacingOccurrences(of: "\n", with: "")
                    let trim = str.components(separatedBy: CharacterSet.newlines)
                    let encoder:JSONEncoder = JSONEncoder()
                    print("str",str)
                    print("trimmed?",trim)
                    print("deleted?",delete)
                    let trimmedjson = try? encoder.encode(delete)
                    print("trimmed?",trimmedjson)
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                          let result:rakutenResult = try decoder.decode(rakutenResult.self,from:json)
                          print(result)
                          rakutenResults.append(result)
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
    }
}
class MyCustomCell:UICollectionViewCell{
    @IBOutlet var imageview: UIImageView!
    var image:UIImage!
   
}
class LoadingCell:UICollectionViewCell{
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
}


