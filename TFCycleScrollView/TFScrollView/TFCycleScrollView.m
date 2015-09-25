//
//  TFCycleScrollView.m
//  TFCycleScrollView
//
//  Created by Tengfei on 15/9/26.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "TFCycleScrollView.h"
#import "TFCycleScrollCell.h"
#import "TFCycleScrollModel.h"

@interface TFCycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray * dataArray;

@property (nonatomic,weak)UICollectionView * TFCollectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;


@property (nonatomic,strong)NSTimer * timer;

@end

@implementation TFCycleScrollView

static NSString *const identifier = @"tfcycle";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
//        [self setupMainView];
//        [self initIndicaView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
//        [self setupMainView];
//        [self initIndicaView];
    }
    return self;
}

-(void)initialization
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    UICollectionView *TFCollectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    self.TFCollectionView = TFCollectionView;
    [self addSubview:TFCollectionView];
    TFCollectionView.backgroundColor = [UIColor whiteColor];
    TFCollectionView.delegate = self;
    TFCollectionView.dataSource = self;
    self.flowLayout = flowLayout;
    TFCollectionView.pagingEnabled = YES;
 
    
    [self.TFCollectionView registerClass:[TFCycleScrollCell class] forCellWithReuseIdentifier:identifier];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.TFCollectionView.frame = self.bounds;
    
    //设置布局
    self.flowLayout.itemSize = self.frame.size; //CGSizeMake(self.frame.size.width, imgH);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.TFCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:50] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [self addTimer];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 100;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.placeholderImage = self.placeholderImage;
     return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

-(void)setImgsArray:(NSArray *)imgsArray
{
    _imgsArray = imgsArray;
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < imgsArray.count; i++) {
        TFCycleScrollModel *model = [[TFCycleScrollModel alloc]init];
        model.imgUrl = imgsArray[i];
        [images addObject:model];
    }
    self.dataArray = images;
//    [self loadImageWithImageURLsGroup:imageURLStringsGroup];

}

#pragma mark - 增加定时器
-(void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(goToNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
-(void)destroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)goToNext
{
    NSIndexPath *currentIndexPath = [[self.TFCollectionView indexPathsForVisibleItems] firstObject];
    
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.TFCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


@end
