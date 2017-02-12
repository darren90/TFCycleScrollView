//
//  TFCycleScrollView.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

let TFSection = 100

protocol TFCycleScrollViewDelegate {
    func cycleScrollViewDidSelectAtIndex(index:Int)
}

class TFCycleScrollView: UIView {
    
    var deledate:TFCycleScrollViewDelegate?

    var imgsArray:[String]?{
        didSet{
            guard let imgsArray = imgsArray else{
                return
            }
            
            if imgsArray.count == 0 {
                return
            }
            
            for str in imgsArray {
                let m = TFCycleScrollModel()
                m.imgUrl = str
                dataArray?.append(m)
            }
            waterView.reloadData()
        }
    }

    var dataArray:[TFCycleScrollModel]?
    lazy var waterView:UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var pageControl:UIPageControl = UIPageControl()

    var timer : Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)

        initSubViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initSubViews(){
        self .addSubview(waterView)
        waterView.isPagingEnabled = true
        waterView.delegate = self
        waterView.dataSource = self
        waterView.showsHorizontalScrollIndicator = false
        waterView.backgroundColor = UIColor.white
        waterView.frame = self.bounds
        waterView.register(TFCycleScrollCell.self, forCellWithReuseIdentifier: "cycleCell")

        let flowLayout = waterView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: frame.width, height: frame.height)
        flowLayout.scrollDirection = .horizontal
    }


    override func layoutSubviews() {
        super.layoutSubviews()


    }

    func addTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.goToNext), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }
    
    func destroyTimer(){
        if let timer = timer{
            timer.invalidate()
        }
    }

    func resetIndexPath() -> IndexPath{
        let currentIndexPath = waterView.indexPathsForVisibleItems.last
        
        let currentIndexPathReset = IndexPath(item: (currentIndexPath?.item)!, section: TFSection/2)
        waterView.scrollToItem(at: currentIndexPathReset, at: .left, animated: false)
        return currentIndexPathReset
    }

    func goToNext(){
        if timer == nil {
            return
        }
        
        let currentIndexPath = resetIndexPath()
        var nexItem = currentIndexPath.item + 1
        var nexSection = currentIndexPath.section
        if nexItem == dataArray?.count {
            nexItem = 0
            nexSection = nexSection + 1
        }
        
        let nexIndexPath = IndexPath(item: nexItem, section: nexSection)
        waterView.scrollToItem(at: nexIndexPath, at: .left, animated: true)
        pageControl.currentPage = nexItem
    }
}


extension TFCycleScrollView : UICollectionViewDataSource,UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TFSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cycleCell", for: indexPath) as! TFCycleScrollCell
        let model = dataArray?[indexPath.item]
        cell.model = model
        cell.backgroundColor = UIColor.red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let deledate = deledate else{
            return
        }
        
        deledate.cycleScrollViewDidSelectAtIndex(index: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageNum = Float(((Float(scrollView.contentOffset.x) / Float(self.frame.width)) + 0.5)) % (Float(dataArray!.count))
//        pageControl.currentPage  = Int(pageNum)
    }

}











