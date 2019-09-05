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
    
    @IBOutlet weak var goNext: UIButton!
    
    @IBOutlet weak var geo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleImageView.image = UIImage(named:"yasai.png")
       goNext.titleLabel?.text = "タップしてスタート"
        geo.image = UIImage(named:"geoapi.png")
        goNext.addTarget(self, action: #selector(self.tapped(_:)), for: .touchUpInside)
    }
    @objc func tapped(_ sender:UIButton){
        //print("tappped")
        //let vc = ViewController()
        //vc.modalTransitionStyle = .crossDissolve
        performSegue(withIdentifier: "toHome", sender: nil)
    }
}
