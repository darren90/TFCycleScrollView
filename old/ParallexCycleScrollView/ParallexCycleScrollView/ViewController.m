//
//  ViewController.m
//  ParallexCycleScrollView
//
//  Created by Fengtf on 2016/11/16.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "ParallexCycleScrollView.h"

@interface ViewController ()


@property (nonatomic,weak) ParallexCycleScrollView *cycleView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ParallexCycleScrollView *cycleView = [[ParallexCycleScrollView alloc]init];
    cycleView.frame = CGRectMake(0,0, self.view.frame.size.width, 200);
    self.cycleView = cycleView;
    [self.view addSubview:cycleView];
//    cycleView.delegate = self;

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

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
