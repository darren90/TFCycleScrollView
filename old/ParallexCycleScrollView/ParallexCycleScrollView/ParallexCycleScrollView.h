//
//  ParallexCycleScrollView.h
//  ParallexCycleScrollView
//
//  Created by Fengtf on 2016/11/16.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ParallexBannerTransition){
    ParallexBannerNormal,
    ParallexBannerParallex
};

@class ParallexCycleScrollView;
@protocol ParallexCycleDeledate <NSObject>
@optional
-(void)rarallexCycle:(ParallexCycleScrollView *)parallexCycleScrollView didClickAtIndex:(NSInteger)index;

-(void)rarallexCycle:(ParallexCycleScrollView *)parallexCycleScrollView didScrollToIndex:(NSInteger)index;
@end

@protocol ParallexCycleDataSource<NSObject>
@optional
-(NSInteger)numberOfBannersIn:(ParallexCycleScrollView *)parallexCycleScrollView;
-(NSString *)urlOrImageAtIndex:(ParallexCycleScrollView *)parallexCycleScrollView;

@end

@interface ParallexCycleScrollView : UIView

@property (nonatomic, assign) id<ParallexCycleDeledate>delegate;

@property (nonatomic, assign) id<ParallexCycleDataSource>dataSouce;




@property (nonatomic,strong)NSArray * imgsArray;

@property (nonatomic,copy)NSString * placeholderImage;


//@property (nonatomic,weak)id<CycleScrollViewDelegate> delegate;

@end
