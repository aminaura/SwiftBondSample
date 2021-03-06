//
//  TimeViewModel.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import Foundation
import Bond

class TimeViewModel : NSObject {
    
    let timestamp = Observable<NSDate>(NSDate())
    
    override init() {
        super.init()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
        
    }
    
    func onUpdate(timer : NSTimer){
        timestamp.value = NSDate()
    }
    
}