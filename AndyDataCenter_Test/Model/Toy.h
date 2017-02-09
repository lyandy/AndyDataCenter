//
//  Toys.h
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/21.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Toy : NSObject

@property (nonatomic, copy) NSString *no;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *toyName;

@property (nonatomic, assign) CGFloat price;

@end
