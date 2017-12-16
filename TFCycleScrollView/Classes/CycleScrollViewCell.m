//
//  CycleScrollViewCell.m
//  ParallexCycleScrollView
//
//  Created by Fengtf on 2016/11/16.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "CycleScrollViewCell.h"

@interface CycleScrollViewCell()



@end

@implementation CycleScrollViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        self.imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        UIScrollView *scrollView = [[UIScrollView alloc]init];
        self.scrollView = scrollView;
        scrollView.userInteractionEnabled = NO;
        scrollView.scrollEnabled = NO;

        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.frame = self.bounds;
    self.imageView.frame = self.scrollView.bounds;
}





@end
