//
//  MMGlobalUrlClass.m
//  MeterMaid
//
//  Created by Iphone_1 on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMGlobalUrlClass.h"

@implementation MMGlobalUrlClass

+(MMGlobalUrlClass *)GetInstance
{
    
    static MMGlobalUrlClass *GlobalClassObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GlobalClassObj = [[self alloc] init];
    });
    return GlobalClassObj;
    
    
    
}

-(NSString *)EncodingOfString:(NSString *)ParamStr
{
    NSString *EccodedStr= [ParamStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return EccodedStr;
}
-(NSMutableArray  *)GlobalUrlFire:(NSString *)ParamUrlString
{
    NSError *error;

    //device_list.php
    NSString *  Url_Str=[NSString stringWithFormat:@"%@%@",DOMAIN_APP_URL,ParamUrlString];

    NSData *ReturnData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Url_Str]];
    ArrayToSend=[NSJSONSerialization JSONObjectWithData:ReturnData options:kNilOptions error:&error];
    
    
    return ArrayToSend;
}
-(NSString *)GlobalUrlFireToGetResponseString:(NSString *)ParamUrlString
{
    NSError *error;
    
    //device_list.php
    NSString *  Url_Str=[NSString stringWithFormat:@"%@%@",DOMAIN_APP_URL,ParamUrlString];

  ReturnStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:Url_Str] encoding:kNilOptions error:&error];

    return ReturnStr;
    
}


@end
