//
//  MMUsageBudgetThermoViewController.h
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 19/06/15.
//
//

#import <UIKit/UIKit.h>

@interface MMUsageBudgetThermoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *daysTable;
    
}


@property (nonatomic,retain ) NSString *DollarIntLblStr;
@property (nonatomic,retain ) NSString *DollarFractionLblStr;
@property (nonatomic)int str ;

@end
