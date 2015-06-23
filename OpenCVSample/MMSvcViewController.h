//
//  MMSvcViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMSvcViewController : UIViewController{
    
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *outagebtn,*svccallbtn;
    UIButton *Homebtn,*publightbtn,*outreachbtn,*otherbtn,*Backbtn;
    UILabel *Homelbl,*publightlbl,*outreachlbl,*otherlbl;
    UIImageView *meterlogo;
    NSDictionary *dict;
    NSMutableArray *Svc_Array;

}

@end
