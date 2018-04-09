//
//  TestModel.h
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface BaseModel : NSObject

@end

@interface TestModel : BaseModel

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, strong) UserModel *user;

@property (nonatomic, strong) NSArray *arrUsers;

@end


@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end
