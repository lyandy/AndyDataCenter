//
//  ViewController.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/20.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "AndyDataCenter.h"
#import "Toy.h"
#import "School.h"
#import "Road.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:[[Person andy_db_dbName] stringByAppendingPathExtension:@"db"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *srcPath = [bundle pathForResource:@"AndyDataCenter" ofType:@"db"];
        [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
        [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dbPath error:nil];
    }
}

- (IBAction)btnSaveSingleClick:(UIButton *)sender
{
    School *sch1 = [[School alloc] init];
    sch1.Id = @"sch1";
    sch1.name = @"山东科技大学";
    
    
    Toy *t1 = [[Toy alloc] init];
    t1.no = @"t1";
    t1.name = @"小狗";
    t1.price = 13.32;
    
    Person *p1 = [[Person alloc] init];
    p1.Id = @"p1";
    p1.name = @"李扬";
    p1.age = 27;
    p1.toy = t1;
    
    Toy *t2 = [[Toy alloc] init];
    t2.no = @"t2";
    t2.name = @"小猫";
    t2.price = 25.56;
    
    Person *p2 = [[Person alloc] init];
    p2.Id = @"p2";
    p2.name = @"王强";
    p2.age = 23;
    p2.toy = t2;
    
    Toy *t3 = [[Toy alloc] init];
    t3.no = @"t3";
    t3.name = @"大驴子";
    t3.price = 25.56;
    
    Person *p3 = [[Person alloc] init];
    p3.Id = @"p3";
    p3.name = @"李晨";
    p3.age = 50;
    p3.toy = t3;
    
    sch1.persons = @[p1, p2, p3];
    
    [sch1 andy_db_saveObject];
    
    [sch1.persons enumerateObjectsUsingBlock:^(Person * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.parentId = sch1.Id;
        [obj andy_db_saveObject];
        
        obj.toy.parentId = obj.Id;
        [obj.toy andy_db_saveObject];
        
    }];
}

- (IBAction)btnSaveMultiplyClick:(UIButton *)sender
{
    Road *r1 = [[Road alloc] init];
    r1.no = @"京0001";
    r1.name = @"北苑路";
    
    Road *r2 = [[Road alloc] init];
    r2.no = @"京0002";
    r2.name = @"北苑路";
    
    Road *r3 = [[Road alloc] init];
    r3.no = @"京0003";
    r3.name = @"红军营南路";
    
    NSArray *rArr = @[r1, r2, r3];
    
    [rArr andy_db_saveArrayObjects];
}

- (IBAction)btnDeleteSingleClick:(UIButton *)sender
{
//    Road *r4 = [[Road alloc] init];
//    r4.no = @"京0004";
//    r4.name = @"软件路";
//    
//    [r4 andy_db_saveObject];
    
    Road *r = [Road andy_db_objectForId:@"京0001"];
    if (r != nil)
    {
        [r andy_db_deleteObject];
        
        NSArray *rArr = [Road andy_db_objectsWhere:nil arguments:nil];
        
        [rArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@", obj);
        }];
    }
}

- (IBAction)btnDeleteMultiplyClick:(UIButton *)sender
{
    //[Road andy_db_deleteObjectsWhere:@"where name = ?" arguments:@[@"北苑路"]];
    
    [Road andy_db_deleteObjectsWhere:@"where name like '%北%'" arguments:nil];
}

- (IBAction)btnSelectSingleClick:(UIButton *)sender
{
    Toy *t = [Toy andy_db_objectForId:@"t1"];
    
    NSLog(@"%@", t.name);
}

- (IBAction)btnSelectMultiplyClick:(UIButton *)sender
{
//    NSArray<Person *> *pArr = [Person andy_db_objectsWhere:@"where parentId = ?" arguments:@[@"sch1"]];
    NSArray *pArr = [Person andy_db_objectsWhere:nil arguments:nil];
    
    [pArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}

- (IBAction)btnSelectIdsClick:(UIButton *)sender
{
//    NSArray *pArr = [Person andy_db_idsWhere:@"where parentId = ?" arguments:@[@"sch1"]];
    
    NSArray *pArr = [Person andy_db_idsWhere:nil arguments:nil];
    
    [pArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}

- (IBAction)btnSelectLikeClick:(UIButton *)sender
{
    NSArray *rArr = [Road andy_db_objectsWhere:@"where no like '%00%'" arguments:nil];
    
    [rArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}

- (IBAction)btnUpdateSingleClick:(UIButton *)sender
{
    NSArray *pArr = [Person andy_db_objectsWhere:@"where name = ?" arguments:@[@"李扬"]];

    Person *pChange = [pArr.firstObject andy_db_updateObjectSet:@{@"name" : @"测试"}];
    
    NSLog(@"%@", pChange.name);
}

- (IBAction)btnUpdateMultiplyClick:(UIButton *)sender
{
    [Person andy_db_updateObjectsSet:@{@"age" : @"40"} Where:@"where name = ?" arguments:@[@"测试"]];
    
//    [Person andy_db_updateObjectsSet:@{@"age" : @"40"} Where:nil arguments:nil];
}

- (IBAction)btnAggregateClick:(UIButton *)sender
{
    NSNumber *num = [Road andy_db_aggregate:@"count(*)" where:nil arguments:nil];
    
    NSLog(@"%zd", [num integerValue]);
    
    NSNumber *sum = [Person andy_db_aggregate:@"sum(age)" where:@"where age < ? " arguments:@[@"30"]];
    
    NSLog(@"%lf", [sum floatValue]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
