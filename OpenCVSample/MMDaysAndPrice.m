//
//  MMDaysAndPrice.m
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 24/06/15.
//
//

#import "MMDaysAndPrice.h"

@implementation MMDaysAndPrice

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
        
        self.sunPrice = 11;
        self.monPrice = 10;
        self.tuePrice = 10;
        self.wedPrice = 12;
        self.thuPrice = 11;
        self.friPrice = 9;
        self.satPrice = 9;
        
        self.mainView = [[UIView alloc]init];
        self.mainView.frame = CGRectMake(3.0f, 230.0f, 145.0f, 245.0f);
        self.mainView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mainView];
        
        self.sunLabel = [[UILabel alloc]init];
        self.sunLabel.frame = CGRectMake(3.0f, 0.0f, self.mainView.frame.size.width, 35.0f);
        self.sunLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3f];
        self.sunLabel.font = [UIFont systemFontOfSize:17.0f];
        self.sunLabel.textColor = [UIColor whiteColor];
        self.sunLabel.text = @"SUN";
        [self.mainView addSubview:self.sunLabel];
        
        self.monLabel = [[UILabel alloc]init];
        self.monLabel.frame = CGRectMake(3.0f, self.sunLabel.frame.origin.y+self.sunLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.monLabel.backgroundColor = [UIColor clearColor];
        self.monLabel.font = [UIFont systemFontOfSize:17.0f];
        self.monLabel.textColor = [UIColor whiteColor];
        self.monLabel.text = @"MON";
        [self.mainView addSubview:self.monLabel];
        
        self.tueLabel = [[UILabel alloc]init];
        self.tueLabel.frame = CGRectMake(3.0f, self.monLabel.frame.origin.y+self.monLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.tueLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3f];
        self.tueLabel.font = [UIFont systemFontOfSize:17.0f];
        self.tueLabel.textColor = [UIColor whiteColor];
        self.tueLabel.text = @"TUE";
        [self.mainView addSubview:self.tueLabel];
        
        self.wedLabel = [[UILabel alloc]init];
        self.wedLabel.frame = CGRectMake(3.0f, self.tueLabel.frame.origin.y+self.tueLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.wedLabel.backgroundColor = [UIColor clearColor];
        self.wedLabel.font = [UIFont systemFontOfSize:17.0f];
        self.wedLabel.textColor = [UIColor whiteColor];
        self.wedLabel.text = @"WED";
        [self.mainView addSubview:self.wedLabel];
        
        self.thuLabel = [[UILabel alloc]init];
        self.thuLabel.frame = CGRectMake(3.0f, self.wedLabel.frame.origin.y+self.wedLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.thuLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3f];
        self.thuLabel.font = [UIFont systemFontOfSize:17.0f];
        self.thuLabel.textColor = [UIColor whiteColor];
        self.thuLabel.text = @"THU";
        [self.mainView addSubview:self.thuLabel];
        
        self.friLabel = [[UILabel alloc]init];
        self.friLabel.frame = CGRectMake(3.0f, self.thuLabel.frame.origin.y+self.thuLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.friLabel.backgroundColor = [UIColor clearColor];
        self.friLabel.font = [UIFont systemFontOfSize:17.0f];
        self.friLabel.textColor = [UIColor whiteColor];
        self.friLabel.text = @"FRI";
        [self.mainView addSubview:self.friLabel];
        
        self.satLabel = [[UILabel alloc]init];
        self.satLabel.frame = CGRectMake(3.0f, self.friLabel.frame.origin.y+self.friLabel.frame.size.height, self.mainView.frame.size.width, 35.0f);
        self.satLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3f];
        self.satLabel.font = [UIFont systemFontOfSize:17.0f];
        self.satLabel.textColor = [UIColor whiteColor];
        self.satLabel.text = @"SAT";
        [self.mainView addSubview:self.satLabel];
        
        //-------All label stored in NSMUTABLE ARRAY-------//
        
        self.viewLabel = [[NSMutableArray alloc]initWithObjects:self.sunLabel,self.monLabel,self.tueLabel,self.wedLabel,self.thuLabel,self.friLabel,self.satLabel, nil];
        
        //--------FOR DOLLAR $ SIGN-------//
        
        
        for (int row = 0; row < 7; row++) {
            
                self.dollarLabel = [[UILabel alloc]init];
                self.dollarLabel.frame = CGRectMake(90, -5.0f, 35.0f, 35.0f);
                self.dollarLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:16];
                self.dollarLabel.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
                self.dollarLabel.text = @"$";
                [[self.viewLabel objectAtIndex:row] addSubview:self.dollarLabel];
            }
        
        //--------For price-------//
        
        self.sunP = [[UILabel alloc]init];
        self.sunP.frame = CGRectMake(110.0f, 0.0f, 40.0f, 35.0f);
        self.sunP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.sunP.backgroundColor = [UIColor clearColor];
        self.sunP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.sunP.text = [NSString stringWithFormat:@"%d",self.sunPrice];
        [self.mainView addSubview:self.sunP];
        
        self.monP = [[UILabel alloc]init];
        self.monP.frame = CGRectMake(110.0f, self.sunLabel.frame.origin.y+self.sunLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.monP.backgroundColor = [UIColor clearColor];
        self.monP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.monP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.monP.text = [NSString stringWithFormat:@"%d",self.monPrice];
        [self.mainView addSubview:self.monP];
        
        self.tueP = [[UILabel alloc]init];
        self.tueP.frame = CGRectMake(110.0f, self.monLabel.frame.origin.y+self.monLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.tueP.backgroundColor = [UIColor clearColor];
        self.tueP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.tueP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.tueP.text = [NSString stringWithFormat:@"%d",self.tuePrice];
        [self.mainView addSubview:self.tueP];
        
        self.wedP = [[UILabel alloc]init];
        self.wedP.frame = CGRectMake(110.0f, self.tueLabel.frame.origin.y+self.tueLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.wedP.backgroundColor = [UIColor clearColor];
        self.wedP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.wedP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.wedP.text = [NSString stringWithFormat:@"%d",self.wedPrice];
        [self.mainView addSubview:self.wedP];
        
        self.thuP = [[UILabel alloc]init];
        self.thuP.frame = CGRectMake(110.0f, self.wedLabel.frame.origin.y+self.wedLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.thuP.backgroundColor = [UIColor clearColor];
        self.thuP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.thuP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.thuP.text = [NSString stringWithFormat:@"%d",self.thuPrice];
        [self.mainView addSubview:self.thuP];
        
        self.friP = [[UILabel alloc]init];
        self.friP.frame = CGRectMake(110.0f, self.thuLabel.frame.origin.y+self.thuLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.friP.backgroundColor = [UIColor clearColor];
        self.friP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.friP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.friP.text = [NSString stringWithFormat:@"%d",self.friPrice];
        [self.mainView addSubview:self.friP];
        
        self.satP = [[UILabel alloc]init];
        self.satP.frame = CGRectMake(110.0f, self.friLabel.frame.origin.y+self.friLabel.frame.size.height, self.mainView.frame.size.width+2, 35.0f);
        self.satP.backgroundColor = [UIColor clearColor];
        self.satP.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
        self.satP.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
        self.satP.text = [NSString stringWithFormat:@"%d",self.satPrice];
        [self.mainView addSubview:self.satP];
            
    }
    
    return self;
}


@end
