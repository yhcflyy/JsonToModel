//
//  ViewController.m
//  JsonToModel
//
//  Created by yao hongchao on 2018/4/9.
//  Copyright © 2018年 yao hongchao. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import "TestModelRuntime.h"
#import "NSObject+ycModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dicTest = @{@"id":@"121",
                              @"name":@"张三",
                              @"phone":@"110",
                              @"age":@"10",
                              @"user":@{@"userId":@"2"},
                              @"arrUsers":@[@{@"userId":@"2"},@{@"userId":@"2"},@{@"userId":@"2"}]};
    TestModel *model = [[TestModel alloc] init];
    [model setValuesForKeysWithDictionary:dicTest];
    NSLog(@"%@",model.name);
    
    TestModelRuntime *modelRunTime = [TestModelRuntime yc_initWithDict:dicTest];
    NSLog(@"%@",modelRunTime.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
