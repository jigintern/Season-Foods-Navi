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

class RecipeViewController:UIViewController{
    var recipename = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let goButton = UIButton(frame: CGRect(x: 100,y: 0,width: 100,height:100))
        goButton.setTitle("\(recipename)", for: .normal)
        goButton.backgroundColor = UIColor.red
        goButton.addTarget(self, action: #selector(RecipeViewController.goNext(_:)), for: .touchUpInside)
        view.addSubview(goButton)
        print(recipename)
    }
    @objc func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func goNext(_ sender: UIButton) {
        let next2vc = FoodInfoViewController()
        next2vc.view.backgroundColor = UIColor.red
        performSegue(withIdentifier: "toFoodInfo", sender: nil)
        
        //self.navigationController?.pushViewController(next2vc, animated: true)
    }
}
