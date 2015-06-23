//
//  MMGlobalFunctionClass.h
//  MeterMaid
//
//  Created by Iphone_1 on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMGlobalFunctionClass : NSObject



+(MMGlobalFunctionClass *)GetInstance;
- (UIImage *) imageFromColor:(UIColor *)color;
@end
