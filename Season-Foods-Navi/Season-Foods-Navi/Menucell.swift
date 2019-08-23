//
//  Menucell.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/08/22.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
import UIKit

class MenuCell:UITableViewCell{
    var thumbnailView:UIImageView!
    var titleLabel:UILabel!
    var channelLabel:UILabel!
    var url:URL!
    override init(style:UITableViewCell.CellStyle,reuseIdentifier:String?){
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        thumbnailView=UIImageView()
        titleLabel=UILabel()
        contentView.addSubview(thumbnailView)
        contentView.addSubview(titleLabel)/*contentViewとはcellを覆っているviewのことを指す*/
    }
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        let w=contentView.frame.width
        let h=contentView.frame.height
        thumbnailView.frame=CGRect(x:0,y:0,width:h*16/9,height:h)
        titleLabel.frame=CGRect(x:h*16/9*1.05,y:0,width:w/2,height:h/2)
    }
    func set(title:String,channelTitle:String,image:UIImage){
        titleLabel.text=title
        thumbnailView.image=image
    }
}

