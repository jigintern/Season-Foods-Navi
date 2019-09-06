//
//  titleViewController.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/09/03.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreLocation
import Charts

class titleViewController:UIViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var logoimage: UIImageView!
 //   var logoimage:UIImageView!
    @IBOutlet weak var goNext: UIButton!
    
    @IBOutlet weak var geo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    //    logoimage = UIImageView()
        titleImageView.image = UIImage(named:"yasai.png")
       goNext.titleLabel?.text = "タップしてスタート"
        geo.image = UIImage(named:"geoapi.png")
        goNext.addTarget(self, action: #selector(self.tapped(_:)), for: .touchUpInside)
        goNext.backgroundColor = .blue
       // goNext.layer.position.x = (width / 4) * 3
       // goNext.frame = CGRect(x:5*self.view.frame.width/6,y:10*self.view.frame.height/6,width:self.view.frame.width/6,height:self.view.frame.height/10)
        
        goNext.layer.cornerRadius = 20.0
        goNext.layer.masksToBounds = true
//        logoimage.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:200)
  //      logoimage.image = UIImage(named:"logo.png")
        
       // self.view.addSubview(logoimage)//
    }
    @objc func tapped(_ sender:UIButton){
        //print("tappped")
        //let vc = ViewController()
        //vc.modalTransitionStyle = .crossDissolve
        performSegue(withIdentifier: "toHome", sender: nil)
    }
}
