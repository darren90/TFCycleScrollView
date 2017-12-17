//
//  TFCycleScrollCell.h
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import <UIKit/UIKit.h>
#import "TFCycleScrollModel.h"

@interface TFCycleScrollCell : UICollectionViewCell

@property (nonatomic, weak)UIImageView * imageView;
@property (nonatomic, weak)UIScrollView * scrollView;

@property (nonatomic, strong)TFCycleScrollModel *model;

@end
