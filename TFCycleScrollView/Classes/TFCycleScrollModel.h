//
//  TFCycleScrollModel.h
//  TFCycleScrollView
//
//  Created by Fengtf on 2017/12/16.
//

#import <Foundation/Foundation.h>

@interface TFCycleScrollModel : NSObject
@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * imgUrl;

+ (instancetype)modelWithTitle:(NSString *)title imgUrl:(NSString *)imgUrl;

@end
