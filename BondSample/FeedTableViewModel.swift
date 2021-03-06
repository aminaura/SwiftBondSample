//
//  FeedTableViewModel.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import Foundation
import Bond
import Alamofire
import SwiftyJSON

class FeedTableViewModel : NSObject {
    
    let items = ObservableArray<Feed>()
    
    func request(){
        let url = "https://qiita.com/api/v2/items"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_, subJson) in json {
                        let feed = Feed(title: subJson["title"].string,
                            username: subJson["user"]["id"].string,
                            userImageURL: subJson["user"]["profile_image_url"].string,
                            url: subJson["url"].string
                        )
                        self.items.append(feed)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}