//
//  NSObject+ycModel.m
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import "NSObject+ycModel.h"
#import <objc/runtime.h>

NSString *const YCClassType_object  =   @"对象类型";
NSString *const YCClassType_basic   =   @"基础数据类型";
NSString *const YCClassType_other   =   @"其它";

@implementation NSObject (ycModel)

+ (instancetype)yc_initWithDict:(NSDictionary*)dict{
    id obj = [[self alloc] init];
    unsigned int count = 0;
    objc_property_t *arrPropertys = class_copyPropertyList([self class],&count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = arrPropertys[i];
        //获取属性名称字符
        NSString *propertyName = [[NSString alloc] initWithUTF8String:property_getName(property)];
        NSString *propertyNameNew;
        if ([self respondsToSelector:@selector(yc_propertyKeyReplaceWithValue)]){
            propertyNameNew = [[self yc_propertyKeyReplaceWithValue] objectForKey:propertyName];
        }
        if (!propertyNameNew) propertyNameNew = propertyName;
        NSLog(@"属性名:%@",propertyName);
        id propertyValue = dict[propertyNameNew];
        if (!propertyValue) continue;
        NSDictionary *dictType = [self propertyTypeFromProperty:property];
        NSString *classType = [dictType objectForKey:@"classType"];
        NSString *type = [dictType objectForKey:@"type"];
        if ([type isEqualToString:YCClassType_object]){
            //如果是对象类型
            if ([classType isEqualToString:@"NSArray"] || [classType isEqualToString:@"NSMutableArray"]){
                if ([self respondsToSelector:@selector(yc_objectClassInArray)]){
                    id propertyValueType = [[self yc_objectClassInArray] objectForKey:propertyName];
                    NSLog(@"");
                    if ([propertyValueType isKindOfClass:[NSString class]]){
                        propertyValue = [NSClassFromString(propertyValueType) yc_initWithArray:propertyValue];
                    }else{
                        propertyValue = [propertyValueType yc_initWithArray:propertyValue];
                    }
                    if (propertyValue) [obj setValue:propertyValue forKey:propertyName];
                }
            }else if ([classType isEqualToString:@"NSDictionary"] || [classType isEqualToString:@"NSMutableDictionary"]){
                //一般不处理
            }else if ([classType isEqualToString:@"NSString"] || [classType isEqualToString:@"NSMutableString"]){
                if (propertyValue) [obj setValue:propertyValue forKey:propertyName];
            }else{
                //自定义类
                propertyValue = [NSClassFromString(classType) yc_initWithDict:propertyValue];
                if (propertyValue) [obj setValue:propertyValue forKey:propertyName];
            }
            
        }else if ([type isEqualToString:YCClassType_basic]){
            //基本类型
            if ([propertyValue isKindOfClass:[NSString class]]){
                propertyValue = [[[NSNumberFormatter alloc] init] numberFromString:propertyValue];
            }else{
                
            }
            if (propertyValue) [obj setValue:propertyValue forKey:propertyName];
        }else{
            //其他类型
        }
    }
    if (arrPropertys) free(arrPropertys);
    return obj;
}


+ (instancetype)yc_initWithArray:(NSArray *)arr{
	NSAssert([arr isKindOfClass:[NSArray class]],@"不是数组");
    NSMutableArray *arrModels = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]){
            [arrModels addObject:[self yc_initWithArray:obj]];
        }else{
            id model = [self yc_initWithDict:obj];
            if (model) [arrModels addObject:model];
        }
    }];
    return arrModels;
}


+ (NSDictionary*)propertyTypeFromProperty:(objc_property_t)property{
    NSMutableDictionary *dictType = [NSMutableDictionary dictionary];
    NSString *propertyAtrr = @(property_getAttributes(property));
    NSRange range = [propertyAtrr rangeOfString:@","];
    NSString *propertyType = [propertyAtrr substringWithRange:NSMakeRange(1, range.location - 1)];
    if ([propertyType hasPrefix:@"@"] && range.location > 2){
        //对象类型
        NSString *classType = [propertyType substringWithRange:NSMakeRange(2, propertyType.length - 3)];
        [dictType setObject:classType forKey:@"classType"];
        [dictType setObject:YCClassType_object forKey:@"type"];
    }else if ([propertyType hasPrefix:@"q"]){
        [dictType setObject:@"NSInteger" forKey:@"classType"];
        [dictType setObject:YCClassType_basic forKey:@"type"];
        //nsinteger
    }else if ([propertyType hasPrefix:@"d"]){
        //cgfloat
        [dictType setObject:@"CGFloat" forKey:@"classType"];
        [dictType setObject:YCClassType_basic forKey:@"type"];
    }else if ([propertyType hasPrefix:@"c"]){
        //bool
        [dictType setObject:@"BOOL" forKey:@"classType"];
        [dictType setObject:YCClassType_basic forKey:@"type"];
    }else{
        //其他类型
        [dictType setObject:YCClassType_other forKey:@"type"];
    }
    return dictType;
}
@end
