//
//  ImageModel.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/17.
//

import Foundation
import SwiftyJSON

class ImageModel {
    private(set) var sourceName: String?
    private(set) var createDate: String?
    private(set) var thumbnailURL: String?
    private(set) var imageURL: String?
    private(set) var size: CGSize?
    
    init(json: JSON) {
        sourceName = json["display_sitename"].string
        thumbnailURL = json["thumbnail_url"].string
        imageURL = json["image_url"].string
        createDate = json["datetime"].string
        
        guard let height = json["height"].int,
              let width = json["width"].int else { return }
        size = CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}


//class MarvelHeroModel {
//
//    private(set) var name: String?
//    private(set) var description: String?
//    private(set) var thumbnail: String?
//
//    init(json: JSON) {
//        name = json["name"].string
//        description = json["description"].string
//        if let dicThumnail = json["thumbnail"].dictionary {
//            guard let path = dicThumnail["path"]?.string else {return}
//            guard let thumbnailEx = dicThumnail["extension"]?.string else {return}
//            thumbnail = "\(path).\(thumbnailEx)"
//        }
//    }
//}
