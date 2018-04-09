//
//  TestModel.m
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import "TestModel.h"

#import "TestModel.h"

@implementation TestModel

+ (NSDictionary *)yj_objectClassInArray
{
    return @{@"arrUsers":@"UserModel"};
}

+ (NSDictionary *)yj_propertykeyReplacedWithValue
{
    return @{@"_id":@"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"id"]){
        self._id = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"arrUsers"]){
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *dict in value) {
            UserModel *user = [[UserModel alloc] init];
            [user setValuesForKeysWithDictionary:dict];
            [users addObject:user];
        }
        self.arrUsers = users;
    }else if ([key isEqualToString:@"user"]){
        UserModel *user = [[UserModel alloc] init];
        [user setValuesForKeysWithDictionary:value];
        self.user = user;
    }
}
@end

@implementation UserModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end



@implementation BaseModel : NSObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
