//
//  TestModelRuntime.m
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import "TestModelRuntime.h"

@implementation TestModelRuntime

+ (NSDictionary*)yc_objectClassInArray{
    return @{@"arrUsers":@"UserModelRuntime"};
}


+ (NSDictionary *)yc_propertyKeyReplaceWithValue
{
    return @{@"_id":@"id"};
}

@end

@implementation UserModelRuntime


@end
