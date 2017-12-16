//
//  TFCycleScrollCell.m
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import "TFCycleScrollCell.h"

@implementation TFCycleScrollCell

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
