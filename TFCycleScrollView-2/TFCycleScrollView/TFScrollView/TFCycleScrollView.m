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
#import "LineLayout.h"

@interface TFCycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray * dataArray;
/** UICollectionView */
@property (nonatomic,weak)UICollectionView * TFCollectionView;
/** UICollectionView的布局 */
@property (nonatomic,strong) LineLayout *flowLayout;
/**UIPageControl */
@property (nonatomic,weak)UIPageControl * pageControl;
/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;


@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic,assign)NSInteger currentSection;

@end

@implementation TFCycleScrollView

static NSString *const identifier = @"tfcycle";
/**UICollectionView的分组数 */
static int const TFSection = 100;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

-(void)initialization
{
    //init UICollectionView
    LineLayout *flowLayout = [[LineLayout alloc] init];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    UICollectionView *TFCollectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    self.TFCollectionView = TFCollectionView;
    [self addSubview:TFCollectionView];
    TFCollectionView.backgroundColor = [UIColor whiteColor];
    TFCollectionView.delegate = self;
    TFCollectionView.dataSource = self;
//    self.flowLayout = flowLayout;
//    TFCollectionView.pagingEnabled = YES;
    TFCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.TFCollectionView registerClass:[TFCycleScrollCell class] forCellWithReuseIdentifier:identifier];
    
    //init pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    [self addSubview:pageControl];

    self.backgroundColor = [UIColor cyanColor];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.TFCollectionView.frame = self.bounds;
    
    //设置布局
//    self.flowLayout.itemSize = self.frame.size; //CGSizeMake(self.frame.size.width, imgH);
//    self.flowLayout.minimumLineSpacing = 0;
//    self.flowLayout.minimumInteritemSpacing = 0;
//    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

//    [self.TFCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TFSection / 2] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    [self addTimer];

    //
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.numberOfPages = self.dataArray.count;
    CGSize page1Size = [self.pageControl sizeForNumberOfPages:1];
    CGFloat pageW = self.dataArray.count * page1Size.width;
    CGFloat pageH = 20;
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    self.pageControl.frame = CGRectMake(viewW - pageW - 25, viewH - pageH - 6, pageW, pageH);
}

#pragma - mark UICollectionView代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return TFSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSection = indexPath.section;
    TFCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.placeholderImage = self.placeholderImage;
    cell.titleLabe.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollViewDidSelectAtIndex:)]) {
        [self.delegate cycleScrollViewDidSelectAtIndex:indexPath.item];
    }
}
//rtmp://live.hkstv.hk.lxdns.com/live/hks
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat itemW =  self.frame.size.width - 80 + 30;
    int pageNum = (int)((scrollView.contentOffset.x + itemW * 0.5 + 10 + 15) / itemW )% (self.dataArray.count);

//    NSLog(@"contentOffsetX:%f---pageNum:%d",scrollView.contentOffset.x,pageNum);

    self.pageControl.currentPage = pageNum;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self destroyTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)setImgsArray:(NSArray *)imgsArray
{
    _imgsArray = imgsArray;
    if (imgsArray.count == 0) return;
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < imgsArray.count; i++) {
        TFCycleScrollModel *model = [[TFCycleScrollModel alloc]init];
        model.imgUrl = imgsArray[i];
        [images addObject:model];
    }
    self.dataArray = images;
}

#pragma mark - 增加定时器
-(void)addTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(goToNext) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //消息循环，添加到主线程
        //extern NSString* const NSDefaultRunLoopMode;  //默认没有优先级
        //extern NSString* const NSRunLoopCommonModes;  //提高优先级
    }
}
#pragma mark - 销毁定时器
-(void)destroyTimer
{
//    NSLog(@"---destroyTimer");
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"");
}
- (NSIndexPath *)resetIndexPath
{
    NSArray *visibleCellIndex = [self.TFCollectionView visibleCells];
    NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self.TFCollectionView indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self.TFCollectionView indexPathForCell:obj2];
        return [path1 compare:path2];
    }];


    NSArray *arr = [self.TFCollectionView indexPathsForVisibleItems];
    NSArray *arr2 = [self.TFCollectionView visibleCells];

    for (int i = 0 ; i< sortedIndexPaths.count ; i++) {
        UICollectionViewCell *cell = sortedIndexPaths[i];
        NSIndexPath *path = [self.TFCollectionView indexPathForCell:cell];
        NSLog(@"-cell-:%d-:%ld-:%ld",i,(long)path.section,(long)path.item);

    }
//    for (int i = 0 ; i< arr.count ; i++) {
//        NSIndexPath *path = arr[1];
//        NSLog(@"-path-:%d-:%ld-:%ld",i,(long)path.section,(long)path.item);
//    }

    // 当前正在展示的位置

//    NSIndexPath *currentIndexPath = [self.TFCollectionView indexPathsForVisibleItems].lastObject;
//    if (arr.count == 3) {
//        currentIndexPath = [self.TFCollectionView indexPathsForVisibleItems][1];
//    }
    UICollectionViewCell *cell = sortedIndexPaths[1];
    NSIndexPath *currentIndexPath = [self.TFCollectionView indexPathForCell:cell];
    NSLog(@"-currentIndexPath Row-:%ld,count:%lu,cellCount:%lu",(long)currentIndexPath.item,(unsigned long)arr.count,(unsigned long)arr2.count);
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:TFSection/2];
    [self.TFCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    return currentIndexPathReset;
}

-(void)goToNext
{
    if (!self.timer)  return; //计时器清空了，这个方法还是会调用？？
    NSIndexPath *currentIndexPath = [self resetIndexPath];
//    NSLog(@"currentIndexPath:%ld",(long)currentIndexPath.item);
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.TFCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

//
//    NSLog(@":%ld-:%@",(long)nextItem,NSStringFromCGPoint(contentOffset));
//    [self.TFCollectionView setContentOffset:contentOffset animated:YES];
    NSLog(@"---nextItem:%ld",(long)nextIndexPath.item);
    self.pageControl.currentPage = nextItem;
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    NSLog(@"---scrollViewDidEndScrollingAnimation-");

}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


@end
