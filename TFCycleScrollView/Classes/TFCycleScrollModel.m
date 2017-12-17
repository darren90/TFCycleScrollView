//
//  TFCycleScrollModel.m
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import "TFCycleScrollModel.h"

@implementation TFCycleScrollModel

+ (instancetype)modelWithTitle:(NSString *)title imgUrl:(NSString *)imgUrl {
    TFCycleScrollModel *model = [[TFCycleScrollModel alloc] init];
    model.title = title;
    model.imgUrl = imgUrl;
    return model;
}

@end
