//
//  TFCycleScrollCell.m
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import "TFCycleScrollCell.h"
#import "UIImageView+WebCache.h"

@interface TFCycleScrollCell ()

@property (nonatomic, strong) UILabel *labelForTitle;
@property (strong, nonatomic) CAGradientLayer *bottomGLayer;

@end


@implementation TFCycleScrollCell

-(instancetype)initWithFrame:(CGRect)frame {
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
        
        self.labelForTitle = [[UILabel alloc] init];
        self.labelForTitle.font = [UIFont systemFontOfSize:15];
        self.labelForTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.labelForTitle];
        self.labelForTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.labelForTitle.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.labelForTitle];
        
        if (self.bottomGLayer == nil) {
            //bottom 渐变
            self.bottomGLayer = [[CAGradientLayer alloc] init];
            self.bottomGLayer.startPoint = CGPointMake(0, 0);
            self.bottomGLayer.endPoint = CGPointMake(0, 1);
            self.bottomGLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                         (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor,
                                         (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor
                                         ];
            self.bottomGLayer.locations =  @[@(0.2f) ,@(0.6f),@(1.0)];
//            [self.labelForTitle.layer insertSublayer:self.bottomGLayer above:self.labelForTitle.layer];
        }
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    
    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.frame = self.bounds;
    self.imageView.frame = self.scrollView.bounds;
    
    CGFloat labelH = 30;
    CGFloat moreMarinLeft = 56;
    self.labelForTitle.frame = CGRectMake(0, viewH - labelH, viewW - moreMarinLeft, labelH);
    [self.imageView.layer insertSublayer:self.bottomGLayer above:self.imageView.layer];
    self.bottomGLayer.frame =  CGRectMake(0, viewH - labelH, viewW, labelH);
}

- (void)setModel:(TFCycleScrollModel *)model {
    _model = model;
    
    NSString *imageUrl = model.imgUrl == nil ? @"" : model.imgUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"nopic_190x210"]];
    self.labelForTitle.text = [NSString stringWithFormat:@"  %@  ", model.title];
}

@end
