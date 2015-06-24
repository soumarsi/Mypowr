//
//  daysAndPrice.m
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 24/06/15.
//
//

#import "daysAndPrice.h"

@implementation daysAndPrice

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.mainView = [[UIView alloc]init];
        self.mainView.frame = CGRectMake(3.0f, DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+40.0f, 135.0f, 245.0f);
        
        
    }
    
    return self;
}


@end
