//
//  ViewController.swift
//  TFCycleScrollView_Swift
//
//  Created by Tengfei on 2017/2/12.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let cycleView = TFCycleScrollView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        cycleView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        view.addSubview(cycleView)
        cycleView.deledate = self
        cycleView.imgsArray = ["http://p2.so.qhimg.com/t013314dfd21f1c9bf7.jpg",
                               "http://p4.so.qhimg.com/t010f4d848562ee4d89.jpg",
                               "http://p0.so.qhimg.com/t0161c53eef11d4a13f.jpg",
                               "http://p1.so.qhimg.com/t018e0d5c95413e8716.jpg",
                               "http://p1.so.qhimg.com/t01739d7baafb216b61.jpg"]
        cycleView.backgroundColor = UIColor.brown
        cycleView.cycleScrollType = .parallex
        
        
        let cycleNormalView = TFCycleScrollView(frame:CGRect(x: 0, y: 250, width: view.frame.width, height: 200))
        view.addSubview(cycleNormalView)
        cycleNormalView.deledate = self
        cycleNormalView.imgsArray = ["http://p2.so.qhimg.com/t013314dfd21f1c9bf7.jpg",
                               "http://p4.so.qhimg.com/t010f4d848562ee4d89.jpg",
                               "http://p0.so.qhimg.com/t0161c53eef11d4a13f.jpg",
                               "http://p1.so.qhimg.com/t018e0d5c95413e8716.jpg",
                               "http://p1.so.qhimg.com/t01739d7baafb216b61.jpg"]
        cycleNormalView.backgroundColor = UIColor.brown
        cycleNormalView.cycleScrollType = .normal

    }


}


extension ViewController : TFCycleScrollViewDelegate {
    func cycleScrollViewDidSelectAtIndex(index: Int) {
        print("item is click :\(index)")
    }
}
