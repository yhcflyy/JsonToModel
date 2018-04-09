//
//  NSObject+ycModel.h
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YcModelProtocol

+ (NSDictionary*)yc_propertyKeyReplaceWithValue;

@end



@interface NSObject (ycModel)

+ (instancetype)yc_initWithDict:(NSDictionary*)dict;

+ (instancetype)yc_initWithArray:(NSArray *)arr;


@end
