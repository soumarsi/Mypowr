//
//  MMGlobalFunctionClass.m
//  MeterMaid
//
//  Created by Iphone_1 on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMGlobalFunctionClass.h"

@implementation MMGlobalFunctionClass
+(MMGlobalFunctionClass *)GetInstance
{
    
    static MMGlobalFunctionClass *GlobalClassObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GlobalClassObj = [[self alloc] init];
    });
    return GlobalClassObj;
    
    
    
}
- (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
