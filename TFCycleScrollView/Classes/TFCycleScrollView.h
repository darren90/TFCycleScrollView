//
//  TFCycleScrollView.h
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ParallexBannerTransition){
    ParallexBannerNormal,
    ParallexBannerParallex
};


@class TFCycleScrollView;
@protocol TFCycleScrollViewDeledate <NSObject>

@optional
-(void)cycleScrollView:(TFCycleScrollView *)cycleScrollView didClickAtIndex:(NSInteger)index title:(NSString *)title;

-(void)cycleScrollView:(TFCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;
@end



@protocol ParallexCycleDataSource<NSObject>
@optional
-(NSInteger)numberOfBannersIn:(TFCycleScrollView *)parallexCycleScrollView;
-(NSString *)urlOrImageAtIndex:(TFCycleScrollView *)parallexCycleScrollView;

@end


@interface TFCycleScrollView : UIView

@property (nonatomic, assign) id<TFCycleScrollViewDeledate>delegate;

@property (nonatomic, assign) id<ParallexCycleDataSource>dataSouce;

@property (nonatomic,strong)NSArray *imgsArray;
@property (nonatomic,strong)NSArray *titlsArray;

@property (nonatomic,copy)NSString * placeholderImage;

@end
