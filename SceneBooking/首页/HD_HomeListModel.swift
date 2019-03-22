//
//  HD_HomeListModel.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/20.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

@objc(Talks)
class Talks :NSObject{
    var tYPEID: Int = 0
    var tALKS: Int = 0
    var cONTENTS: Int = 0
    var dELFLAG: Bool = false
    var cTIME: String!
    var tEXTS: String!
    var uSERS: Int = 0
    var iD: Int = 0
    
}

class HD_HomeListModel: HD_BaseModel {
    var tYPESETTING: Int = 0
    var liked: Int = 0
    var talks: [Talks]!
    var title: String!
    var url: String!
    var pUBLISH: Bool = false
    var duration: String!
    var cTIME: String!
    var imglink: String!
    var talkcount: Int = 0
    var readarts: Int = 0
    var dELFLAG: Bool = false
    var imglink_1: String!
    var imglink_3: String!
    var sourcename: String!
    var likecount: Int = 0
    var sORT: Int = 0
    var oPENSOURCE: Bool = false
    var recommond: Int = 0
    var date: String!
    var content168: String!
    var faved: Int = 0
    var tYPE: String!
    var iD: Int = 0
    var videolink: String!
    var sharearts: Int = 0
    var imglink_2: String!
    var author: String!
    var titlespelling: String!
    
}
