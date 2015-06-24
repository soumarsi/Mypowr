//
//  MMUsageBudgetThermoViewController.h
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 19/06/15.
//
//

#import <UIKit/UIKit.h>

@interface MMUsageBudgetThermoViewController : UIViewController
{
    
    int sunpricesave,monpricesave,tuepricesave,wedpricesave,thupricesave,fripricesave,satpricesave;
    int sunpricedec,monpricedec,tuepricedec,wedpricedec,thupricedec,fripricedec,satpricedec;
    
}


@property (nonatomic,retain ) NSString *DollarIntLblStr;
@property (nonatomic,retain ) NSString *DollarFractionLblStr;
@property (nonatomic)int str ;
@property (nonatomic)int rts ;


@end
