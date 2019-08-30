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
let rakutenDummyjson = """
{"result":[{
"recipeId":1010011230,
"recipeTitle":"なすがとろける簡単焼きなすの煮びたし",
"recipeUrl":"https://recipe.rakuten.co.jp/recipe/1010011230/",
"foodImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/1f7d28e4fbbeed2f559e0ee7f2a56392702f8c2f.30.2.3.2.jpg",
"mediumImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/1f7d28e4fbbeed2f559e0ee7f2a56392702f8c2f.30.2.3.2.jpg?thum=54",
"smallImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/1f7d28e4fbbeed2f559e0ee7f2a56392702f8c2f.30.2.3.2.jpg?thum=55",
"pickup":1,
"shop":0,
"nickname":"ラズベリっち","recipeDescription":"味つけはめんつゆと生姜で超簡単焼いた茄子をすりおろし生姜を入れためんつゆで味を浸み込ませて、ねぎを散らしましたとろける茄子に家族も絶賛の簡単な一品です",
"recipeMaterial":["茄子","ごま油","生姜のすりおろし","めんつゆ（３倍濃縮）","水","ねぎ（小ねぎ等）"],
"recipeIndication":"約10分",
"recipeCost":"300円前後",
"recipePublishday":"2014/08/10 08-47-35",
"rank":"1"
},
{"recipeId":1890008883,
"recipeTitle":"簡単！揚げない！ナスとオクラの揚げ浸し",
"recipeUrl":"https://recipe.rakuten.co.jp/recipe/1890008883/",
"foodImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/6d24a49874fd19a0cd512577a34b933b05342ab6.86.2.3.2.jpg",
"mediumImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/6d24a49874fd19a0cd512577a34b933b05342ab6.86.2.3.2.jpg?thum=54",
"smallImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/6d24a49874fd19a0cd512577a34b933b05342ab6.86.2.3.2.jpg?thum=55",
"pickup":1,
"shop":0,
"nickname":"ゆぅ",
"recipeDescription":"茄子はこの焼き方だと少ない油でもトロトロに焼きあがります。出来たてを食べても、冷やして食べても美味しいです 麺つゆの他に、ポン酢でも美味しいです",
"recipeMaterial":["なす","オクラ","大根","めんつゆ（ストレート）","サラダ油"],
"recipeIndication":"約15分",
"recipeCost":"300円前後",
"recipePublishday":"2015/08/18 00-12-36",
"rank":"2"
},
{
"recipeId":1390015585,
"recipeTitle":"ご飯がすすむ 豚肉となすの味噌炒め",
"recipeUrl":"https://recipe.rakuten.co.jp/recipe/1390015585/",
"foodImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/b9439a7c2fd591879279d91e61d4fb6b09388f27.92.2.3.2.jpg",
"mediumImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/b9439a7c2fd591879279d91e61d4fb6b09388f27.92.2.3.2.jpg?thum=54",
"smallImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/b9439a7c2fd591879279d91e61d4fb6b09388f27.92.2.3.2.jpg?thum=55",
"pickup":1,
"shop":0,
"nickname":"はなまる子",
"recipeDescription":"ささっと簡単、豚バラ肉と夏野菜の味噌味の炒めものです。　ご飯のおかずに、おつまみにお箸が進みます。",
"recipeMaterial":["豚バラ肉","なす","ピーマン","オリーブオイル","・・調味料","Ａ・・","味噌、酒","砂糖","しょうゆ"],
"recipeIndication":"約10分",
"recipeCost":"300円前後",
"recipePublishday":"2013/03/26 16-31-30",
"rank":"3"
},
{
"recipeId":1290001623,
"recipeTitle":"主人が、いくらでも食べれると絶賛のナス・ピーマン",
"recipeUrl":"https://recipe.rakuten.co.jp/recipe/1290001623/",
"foodImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/eb2f27f434436225566c034083f98ddf2aaa0a50.50.2.3.2.jpg",
"mediumImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/eb2f27f434436225566c034083f98ddf2aaa0a50.50.2.3.2.jpg?thum=54",
"smallImageUrl":"https://image.space.rakuten.co.jp/d/strg/ctrl/3/eb2f27f434436225566c034083f98ddf2aaa0a50.50.2.3.2.jpg?thum=55",
"pickup":1,
"shop":0,
"nickname":"ライム2141",
"recipeDescription":"お弁当のおかずにと思って作ったら、主人が、お弁当箱の半分のスペースは、これでいいよと言うぐらい絶賛してくれたので、我が家の定番おかずになりました",
"recipeMaterial":["長ナス","ピーマン","砂糖","醤油","ゴマ油orサラダ油","だしの素","白いりゴマ"],
"recipeIndication":"約10分",
"recipeCost":"100円以下",
"recipePublishday":"2011/04/01 14-52-17",
"rank":"4"}]}
"""
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
var menujson:JSON!
var results:[Result]=[]
var locationmaneger:CLLocationManager!
var rakutenResults:[rakutenResult]=[]
var tapped_path:Int!
class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate{

    // let CELLID = "menu"
   // var statusBarHidden = true
    @IBOutlet var menucollection: UICollectionView!
    let SERVER:String! = "http://localhost:3000/public"
    var datas:recipilist?
    //var food_datas:foodlsit?
   // var users:Users?
    var menutable:UITableView!
    override func viewWillAppear(_ animated: Bool) {
     //   menucollection.frame = CGRect(x:0,y:100,width:self.view.frame.width,height:self.view.frame.height)
        super.viewWillAppear(animated)
   //     self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
      //  self.setNeedsStatusBarAppearanceUpdate()
        //setNeedsStatusBarAppearanceUpdate()
   //     self.navigationController?.setToolbarHidden(true, animated: false)
        self.menucollection.delegate = self
        self.menucollection.dataSource = self
        Alamofire.request(SERVER,method: .get).responseString{response in
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
          }
        
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
        if let data = rakutenDummyjson.data(using: .utf8){
            // var str = String(data: rakutenDummyjson, encoding: .utf8)!
            //  let encoder:JSONEncoder = JSONEncoder()
            let decoder:JSONDecoder = JSONDecoder()
            do{
                let result:rakutenResult = try decoder.decode(rakutenResult.self,from:data)
                print(result)
                rakutenResults.append(result)
                //  print("temp",results)
            }catch{
                print("JSON convert failed",error.localizedDescription)
            }
        }
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumLineSpacing = 0
        LAYOUT.itemSize = CGSize(width:self.view.frame.width/2-CGFloat(5),height:self.view.frame.height/3)
      //  LAYOUT.minimumInteritemSpacing = 0.1
                menucollection.collectionViewLayout = LAYOUT
        
       // view.addSubview(menucollection)
        menucollection.reloadData()
        Setuplocationmanager()
        searchCategoryRanking()
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // print("\(indexPath.row)番目の画像が選択されました。")
       // print(results[0].recipilist[indexPath.row].name)
        tapped_path = indexPath.row
        let nextvc = RecipeViewController()
        let next = self.storyboard!.instantiateViewController(withIdentifier: "recipeview") as? RecipeViewController
        next?.recipename = rakutenResults[0].result[indexPath.row].recipeTitle
        nextvc.view.backgroundColor = UIColor.blue
      //  print(indexPath.row)
        performSegue(withIdentifier: "toRecipe", sender: nil)
       // self.navigationController?.pushViewController(nextvc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipe" {
          //  let nc = segue.destination as! UINavigationController
            let nextView = segue.destination as! RecipeViewController
            //print(rakutenResults[0].result[tapped_path])
            nextView.recipename = rakutenResults[0].result[tapped_path].recipeTitle
            nextView.recipeInfo = rakutenResults[0].result[tapped_path]
        }
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
            let locate :[String:Double] = ["lat": latitude, "long": longitude]
            print("latitude: \(latitude)\nlongitude: \(longitude)")
            let encoder:JSONEncoder = JSONEncoder()
            let urlstring = "http://localhost:3000/api/v1/menu"
          //  let parameter = try? encoder.encode(locate)
            Alamofire.request(urlstring,method: .get,parameters: locate)
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
        if rakutenResults.count == 0{
            return 0
        }
        return rakutenResults[0].result.count
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if rakutenResults.count == 0{
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
       var imagepath = rakutenResults[0].result[indexPath.row].foodImageUrl
        
        var imageurl:String!
        if imagepath.hasPrefix("."){
            imagepath.removeFirst()
            imageurl = "http://localhost:3000\(imagepath)"
        }else{
            imageurl = "\(imagepath)"
        }
        
        print(imageurl)
        cell.imageview.sd_setImage(with: URL(string:imageurl), placeholderImage:UIImage(named:"loading.png"))
        
        if indexPath.row == 4 {
            cell.imageview.image = UIImage(named: "dust.png")
        }
        self.view.addSubview(cell.imageview)
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
            //     print("result",response)
               //  menujson = JSON(response.result.value ?? kill)
                 guard let json = response.data else{return}
                 if let data = myjson.data(using: .utf8){
                    var str = String(data: json, encoding: .utf8)!
                    let delete = str.replacingOccurrences(of: "\n", with: "")
                    let trim = str.components(separatedBy: CharacterSet.newlines)
                    let encoder:JSONEncoder = JSONEncoder()
               //     print("str",str)
               //     print("trimmed?",trim)
               //     print("deleted?",delete)
                    let trimmedjson = try? encoder.encode(delete)
                    print("trimmed?",trimmedjson)
                    let decoder:JSONDecoder = JSONDecoder()
                    do{
                          let result:rakutenResult = try decoder.decode(rakutenResult.self,from:json)
                 //         print(result)
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
       //     print(rakutenDummyjson)
            if let data = rakutenDummyjson.data(using: .utf8){
               // var str = String(data: rakutenDummyjson, encoding: .utf8)!
              //  let encoder:JSONEncoder = JSONEncoder()
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    let result:rakutenResult = try decoder.decode(rakutenResult.self,from:data)
               //     print(result)
                    rakutenResults.append(result)
                    //  print("temp",results)
                }catch{
                    print("JSON convert failed",error.localizedDescription)
                }
            }
        }
    }
 /*   override var prefersStatusBarHidden: Bool {
        return false
    }*/
}
class MyCustomCell:UICollectionViewCell{
    @IBOutlet var imageview: UIImageView!
    var image:UIImage!
   
}
class LoadingCell:UICollectionViewCell{
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
}


