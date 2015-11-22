//
//  TFCycleScrollView.h
//  TFCycleScrollView
//
//  Created by Tengfei on 15/9/26.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CycleScrollViewDelegate <NSObject>

@optional
-(void)cycleScrollViewDidSelectAtIndex:(NSInteger)index;
@end

@interface TFCycleScrollView : UIView
@property (nonatomic,strong)NSArray * imgsArray;

@property (nonatomic,copy)NSString * placeholderImage;


@property (nonatomic,weak)id<CycleScrollViewDelegate> delegate;
@end
