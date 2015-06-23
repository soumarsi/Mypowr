//
//  MMGlobalUrlClass.h
//  MeterMaid
//
//  Created by Iphone_1 on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMGlobalUrlClass : NSObject
{
     NSMutableArray *ArrayToSend;
    NSString *ReturnStr;
}


+(MMGlobalUrlClass *)GetInstance;

- (UIImage *) imageFromColor:(UIColor *)color;
-(NSMutableArray  *)GlobalUrlFire:(NSString *)ParamUrlString;
-(NSString *)EncodingOfString:(NSString *)ParamStr;
-(NSString *)GlobalUrlFireToGetResponseString:(NSString *)ParamUrlString;

@end
