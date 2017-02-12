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
    let titleLabel = UILabel()
    
    var model:TFCycleScrollModel?{
        didSet{
            guard let model = model else {
                return
            }
            let url = URL(string: model.imgUrl ?? "")
            iconView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initImg(){
        contentView.addSubview(iconView)
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
