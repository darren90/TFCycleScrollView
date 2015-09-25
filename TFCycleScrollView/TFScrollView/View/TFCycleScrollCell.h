//
//  TFCycleScrollCell.h
//  TFCycleScrollView
//
//  Created by Tengfei on 15/9/25.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFCycleScrollModel;

@interface TFCycleScrollCell : UICollectionViewCell

@property (nonatomic,strong)TFCycleScrollModel * model;
@property (nonatomic,copy)NSString * placeholderImage;


@end
