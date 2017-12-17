//
//  TFViewController.m
//  TFCycleScrollView
//
//  Created by 1005052145@qq.com on 12/16/2017.
//  Copyright (c) 2017 1005052145@qq.com. All rights reserved.
//

#import "TFViewController.h"
#import "TFCycleScrollView.h"

@interface TFViewController () <TFCycleScrollViewDeledate>

@property (nonatomic,weak)TFCycleScrollView *cycleView;

@end

@implementation TFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFCycleScrollView *cycleView = [[TFCycleScrollView alloc]init];
    cycleView.frame = CGRectMake(0,0, self.view.frame.size.width, 200);
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
    
    NSArray *titles = @[
                                  @"想去那段充实而虚无的生活，我们只有一个目的，考上好的学校",
                                  @"这是我们听过最好笑的笑话，高考只是人生中的一道坎儿。",
                                  @"她们的生活费是我的两倍，一次吃饭看电影就得花费我一天的工资。",
                                  @"她们的生活费是我的两倍，一次吃饭看电影就得花费我一天的工资。",
                                  @"在书店认识的服务员就靠着工资旅游，挣满了车费"
                                  ];
    cycleView.placeholderImage = @"nopic_780x420";
    cycleView.titlsArray = titles;
    cycleView.imgsArray = imagesURLStrings;
}


-(void)cycleScrollView:(TFCycleScrollView *)cycleScrollView didClickAtIndex:(NSInteger)index title:(NSString *)title {
    NSLog(@"----当前点击的是第%ld个,title:%@",(long)index, title);

}

-(void)cycleScrollViewDidSelectAtIndex:(NSInteger)index {
    NSLog(@"----当前点击的是第%ld个",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
