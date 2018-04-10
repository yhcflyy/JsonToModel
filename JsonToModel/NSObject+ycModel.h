//
//  NSObject+ycModel.h
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YcModelProtocol

@optional
+ (NSDictionary*)yc_propertyKeyReplaceWithValue;

+ (NSDictionary*)yc_objectClassInArray;

@end



@interface NSObject (ycModel)<YcModelProtocol>

+ (instancetype)yc_initWithDict:(NSDictionary*)dict;

+ (instancetype)yc_initWithArray:(NSArray *)arr;


@end
