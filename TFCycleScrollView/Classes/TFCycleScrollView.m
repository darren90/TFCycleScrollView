//
//  TFCycleScrollView.m
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import "TFCycleScrollView.h"
#import "TFCycleScrollCell.h"
#import "UIImageView+WebCache.h"

#define KparllexSpeed 0.5

@interface TFCycleScrollView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray * dataArray;
/** UICollectionView */
@property (nonatomic,weak)UICollectionView * TFCollectionView;
/** UICollectionView的布局 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
/**UIPageControl */
@property (nonatomic,weak)UIPageControl * pageControl;
/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;

@end

@implementation TFCycleScrollView


static NSString *const identifier = @"tfcycle";
/**UICollectionView的分组数 */
static int const TFSection = 100;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

-(void)initialization {
    //init UICollectionView
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
    TFCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.TFCollectionView registerClass:[TFCycleScrollCell class] forCellWithReuseIdentifier:identifier];
    
    //init pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.TFCollectionView.frame = self.bounds;
    
    //设置布局
    self.flowLayout.itemSize = self.frame.size; //CGSizeMake(self.frame.size.width, imgH);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //TODO
    //    [self.TFCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TFSection / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [self addTimer];
    
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:90 / 255.0 green:141 / 255.0 blue:209 / 255.0 alpha:1.0];
    self.pageControl.numberOfPages = self.dataArray.count;
//    CGSize page1Size = [self.pageControl sizeForNumberOfPages:1];
//    [self.pageControl sizeToFit];
    CGFloat pageW = [self.pageControl sizeForNumberOfPages:self.dataArray.count].width;//self.dataArray.count * page1Size.width;
    CGFloat pageH = 18;
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    self.pageControl.frame = CGRectMake(viewW - pageW - 10, viewH - pageH - 4, pageW, pageH);
//    self.pageControl.center = CGPointMake( self.pageControl.frame.origin.x, self.frame.size.width / 2);
}


#pragma - mark UICollectionView代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return TFSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TFCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.item];
    //    cell.placeholderImage = self.placeholderImage;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TFCycleScrollModel *model = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didClickAtIndex:title:)]) {
        [self.delegate cycleScrollView:self didClickAtIndex:indexPath.item title:model.title];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageNum = (int)((scrollView.contentOffset.x / self.frame.size.width) + 0.5) % self.dataArray.count;
    self.pageControl.currentPage = pageNum;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = CGRectGetWidth(scrollView.bounds);
    if (offsetX > width * (self.dataArray.count + 1)) {
        offsetX = width;
        scrollView.contentOffset = CGPointMake(offsetX, 0);
    }else if (offsetX < 0){
        offsetX = width * self.dataArray.count;
        scrollView.contentOffset = CGPointMake(offsetX, 0);
    }
    
    //视差 效果 的实现
    NSArray *arrCells = self.TFCollectionView.visibleCells;
    for (TFCycleScrollCell *cell in arrCells) {
        [self handleEffect:cell];
    }    
}


-(void)handleEffect:(TFCycleScrollCell *)cell {
    CGFloat minusX = self.TFCollectionView.contentOffset.x - cell.frame.origin.x;
    CGFloat imageOffsetX = -minusX * KparllexSpeed;
    cell.scrollView.contentOffset = CGPointMake(imageOffsetX, 0);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self destroyTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

-(void)setImgsArray:(NSArray *)imgsArray {
    _imgsArray = imgsArray;
    if (imgsArray.count == 0) return;
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < imgsArray.count; i++) {
        NSString *imgUrl = imgsArray[i];
        NSString *title = @"";
        if (i < self.titlsArray.count) {
            title = self.titlsArray[i];
        }
        TFCycleScrollModel *model = [TFCycleScrollModel modelWithTitle:title imgUrl:imgUrl];
        [images addObject:model];
    }
    self.dataArray = images;
}

#pragma mark - 增加定时器
-(void)addTimer {
    //     NSLog(@"---addTimer");
    if (!self.timer) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goToNext) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //消息循环，添加到主线程
        //extern NSString* const NSDefaultRunLoopMode;  //默认没有优先级
        //extern NSString* const NSRunLoopCommonModes;  //提高优先级
    }
}

#pragma mark - 销毁定时器
-(void)destroyTimer {
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"");
}

- (NSIndexPath *)resetIndexPath {
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.TFCollectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:TFSection/2];
    [self.TFCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

-(void)goToNext {
    if (!self.timer)  return; //计时器清空了，这个方法还是会调用？？
    NSIndexPath *currentIndexPath = [self resetIndexPath];
    
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
//    [UIView animateWithDuration:1 animations:^{
        [self.TFCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    }];
    
    self.pageControl.currentPage = nextItem;
}


-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
