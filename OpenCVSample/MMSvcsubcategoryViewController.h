//
//  MMSvcsubcategoryViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMSvcsubcategoryViewController : UIViewController{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *outagebtn,*svccallbtn;
    UIButton *linelocatbtn,*auditbtn,*treetirmbtn,*otherbtn,*Backbtn;
    UILabel *linelocatlbl,*auditlbl,*treetirmlbl,*otherlbl;
    UIImageView *meterlogo;
    NSDictionary *dict;
    NSMutableArray *Svcsubcat_Array;
}

@property(nonatomic,retain)NSString *Svc_catid;

@end
