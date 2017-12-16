//
//  ViewController.m
//  TFCycleScrollView
//
//  Created by Tengfei on 15/9/25.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "TFCycleScrollView.h"

@interface ViewController ()<CycleScrollViewDelegate>
@property (nonatomic,weak)TFCycleScrollView *cycleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TFCycleScrollView *cycleView = [[TFCycleScrollView alloc]init];
    cycleView.frame = CGRectMake(0,160, self.view.frame.size.width, 180);
    self.cycleView = cycleView;
    [self.view addSubview:cycleView];
    cycleView.delegate = self;
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"http://p2.so.qhimg.com/t013314dfd21f1c9bf7.jpg",
                                  @"http://p4.so.qhimg.com/t010f4d848562ee4d89.jpg",
                                  @"http://p0.so.qhimg.com/t0161c53eef11d4a13f.jpg",
                                  @"http://p1.so.qhimg.com/t018e0d5c95413e8716.jpg",
                                  @"http://p1.so.qhimg.com/t01739d7baafb216b61.jpg"
                                  ];
    cycleView.placeholderImage = @"nopic_780x420";
    cycleView.imgsArray = imagesURLStrings;
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)cycleScrollViewDidSelectAtIndex:(NSInteger)index
{
    NSLog(@"----当前点击的是第%ld个",(long)index);
}


@end
