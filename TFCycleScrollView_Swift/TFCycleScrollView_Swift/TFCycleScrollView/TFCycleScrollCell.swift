//
//  TFCycleScrollCell.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class TFCycleScrollCell: UICollectionViewCell {
    
    let iconView:UIImageView = UIImageView()
    let scrollView = UIScrollView()

    let titleLabel = UILabel()
    
    var model:TFCycleScrollModel?{
        didSet{
            guard let model = model else {
                return
            }
            let url = URL(string: model.imgUrl ?? "")
            iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "nopic_780x420"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initImg()
    }
    
    func initImg(){
        contentView.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.isUserInteractionEnabled = false
        
        scrollView.addSubview(iconView)
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize = self.bounds.size;
        scrollView.frame = self.bounds
        iconView.frame = scrollView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
