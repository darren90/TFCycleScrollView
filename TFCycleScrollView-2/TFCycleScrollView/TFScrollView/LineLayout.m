//
//  LineLayout.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 15/12/27.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "LineLayout.h"

//static const CGFloat ItemHW = 100;

@implementation LineLayout

-(instancetype)init
{
    if (self = [super init]) {
        //        UICollectionViewLayoutAttributes


    }
    return self;
}

/**
 *  一些初始化工作，最好在这里实现
 */
-(void)prepareLayout
{
    [super prepareLayout];

    CGFloat inset = 40;
//    CGFloat inset = (self.collectionView.frame.size.width - ItemHW) / 2;
    CGFloat ItemHW = self.collectionView.frame.size.width - 2*inset;

    //初始化
    self.itemSize = CGSizeMake(ItemHW, self.collectionView.frame.size.height);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 30;//item之间的间距
//    self.sectionInset
    self.sectionInset =  UIEdgeInsetsMake(0, inset, 0, -10);//左右两边都往里缩进的距离//UIEdgeInsetsMake(0, 0, 0, self.minimumLineSpacing);//
}


/**
 *  控制最后srollview的最后去哪里
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本Scrollview停止滚动那一刻的位置
 *  @param velocity              滚动速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1.计算scrollview最后停留的范围
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;

    //2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];

    //计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2.0 ;

    //3.遍历所有的属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)){//取出最小值
            adjustOffsetX = attrs.center.x - centerX;
            break;
        }
    }

    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

/**
 *  返回yes，只要显示的边界发生改变，就需要重新布局：(会自动调用layoutAttributesForElementsInRect方法，获得所有cell的布局属性)
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end









