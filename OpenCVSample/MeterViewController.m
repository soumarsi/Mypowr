//
//  MeterViewController.m
//  OpenCVSample
//
//  Created by Soumarsi_kundu on 17/11/14.
//
//

#import "MeterViewController.h"
#import "MMUsageBudgetViewController.h"

@interface MeterViewController (){
    
    UIView *MainView;
    UIButton *Backbtn,*Savebtn,*SaveMeterImage;
    int count;
}

@end

@implementation MeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 0;
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,320.0f,568.0f)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Meterbackground"]]];
    [self.view addSubview:MainView];
    
    
    UILabel *MeterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 30.0f, 320.0f, 30.0f)];
    [MeterLabel setBackgroundColor:[UIColor clearColor]];
    [MeterLabel setText:@"METER"];
    [MeterLabel setTextAlignment:NSTextAlignmentCenter];
    [MeterLabel setTextColor:[UIColor whiteColor]];
    [MeterLabel setFont:[UIFont fontWithName:@"HelveticaLTStd-Bold 2.otf" size:12]];
    [MeterLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [MainView addSubview:MeterLabel];
    
    NSLog(@"_redhhw%@",_readingVal);
    
    int y = 130.0f;
    
    for(int j = 0;j < _readingVal.count ;j++){
        
        allval = [(NSArray*)_readingVal componentsJoinedByString:@""];
        
        if(j==0){
            
            UILabel *numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0f, y, 50.0f, 50.0f)];
            [numberlabel setText:[NSString stringWithFormat:@"%@",[_readingVal objectAtIndex:j]]];
            [numberlabel setTextColor:[UIColor whiteColor]];
            [numberlabel setTextAlignment:NSTextAlignmentCenter];
            [MainView addSubview:numberlabel];
            
        }else{
            
            UILabel *numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0f, y, 50.0f, 50.0f)];
            [numberlabel setText:[NSString stringWithFormat:@"%@",[_readingVal objectAtIndex:j]]];
            [numberlabel setTextColor:[UIColor whiteColor]];
            [numberlabel setTextAlignment:NSTextAlignmentCenter];
            [MainView addSubview:numberlabel];
            
        }
        
        y = y + 87;
        
    }
    
    int x = 100;
    int j = 130.0f;
    for (int i = 0; i < 5; i++) {
        
        UIView *meterview = [[UIView alloc]initWithFrame:CGRectMake(100.0f, x, 67, 67)];
        //        [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Meterimage"]]];
        meterview.tag = i;
        [MainView addSubview:meterview];
        
        //        UIGraphicsBeginImageContext(meterview.frame.size);
        //        [[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]] drawInRect:meterview.bounds];
        //        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        //        meterview.backgroundColor = [UIColor colorWithPatternImage:image];
        
        
        switch ([[_readingVal objectAtIndex:i] intValue]) {
                
            case 0:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 1:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 2:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 3:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 4:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 5:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 6:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 7:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 8:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            case 9:
                [meterview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"meter%d", [[_readingVal objectAtIndex:i] intValue]]]]];
                break;
                
            default:
                break;
        }
        UITapGestureRecognizer *MeterTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MeterTap:)];
        [meterview addGestureRecognizer:MeterTap];
        [meterview setUserInteractionEnabled:YES];
        /*
         UIImageView *clockimage = [[UIImageView alloc]initWithFrame:CGRectMake(130.0f, j, 12, 34)];
         [clockimage setImage:[UIImage imageNamed:@"meterhandleimg"]];
         [MainView addSubview:clockimage];
         */
        
        
        x = x+87;
        j = j+87;
        
    }
    
    
    
    
    
    //bottom bar............
    
    UIView *UsBackView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 525.0f, 320, 85/2)];
    UsBackView9.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView9];
    
    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 529.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    //save.........................
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 529.0f, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Savebtn];
    
    MeterPopView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [MeterPopView setBackgroundColor:[UIColor blackColor]];
    [MeterPopView setAlpha:0.8];
    [MainView addSubview:MeterPopView];
    [MeterPopView setHidden:YES];
    
    MeterCrossButton  = [[UIButton alloc]initWithFrame:CGRectMake(55, 450, 44, 44)];
    [MeterCrossButton setBackgroundImage:[UIImage imageNamed:@"MeterCrossimage"] forState:UIControlStateNormal];
    [MeterCrossButton addTarget:self action:@selector(MeterCrossTap:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:MeterCrossButton];
    [MeterCrossButton setHidden:YES];
    
    
    MeterPlusButton  = [[UIButton alloc]initWithFrame:CGRectMake(220, 450, 44, 44)];
    [MeterPlusButton setBackgroundImage:[UIImage imageNamed:@"MeterPlusimagebutton"] forState:UIControlStateNormal];
    [MeterPlusButton addTarget:self action:@selector(MeterPlusButton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:MeterPlusButton];
    [MeterPlusButton setHidden:YES];
    
    MeterImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 150, 256, 256)];
    [MainView addSubview:MeterImage];
    [MeterImage setHidden:YES];
    
    SaveMeterImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [SaveMeterImage setFrame:CGRectMake(152.0f,480, 22, 36)];
    [SaveMeterImage setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [SaveMeterImage setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [SaveMeterImage addTarget:self action:@selector(SaveMeter:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:SaveMeterImage];
    [SaveMeterImage setHidden:YES];
    
    // Do any additional setup after loading the view.
}

-(void)SaveMeter:(UIButton *)sender
{
    
    [_readingVal replaceObjectAtIndex:sender.tag withObject:[NSString stringWithFormat:@"%d",count]];
    
    MeterViewController *view = [[MeterViewController alloc]init];
    view.readingVal = _readingVal;
    [self.navigationController pushViewController:view animated:NO];
    
}
-(void)MeterTap:(UITapGestureRecognizer *)sender
{
    switch (sender.view.tag)
    {
        case 0:
            
            [MeterPopView setHidden:NO];
            [MeterCrossButton setHidden:NO];
            [MeterPlusButton setHidden:NO];
            [MeterImage setHidden:NO];
            [SaveMeterImage setHidden:NO];
            MeterPlusButton.tag = sender.view.tag;
            SaveMeterImage.tag = sender.view.tag;
            count = [[_readingVal objectAtIndex:sender.view.tag] intValue];
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            
            break;
        case 1:
            [MeterPopView setHidden:NO];
            [MeterCrossButton setHidden:NO];
            [MeterPlusButton setHidden:NO];
            [MeterImage setHidden:NO];
            MeterPlusButton.tag = sender.view.tag;
            [SaveMeterImage setHidden:NO];
            SaveMeterImage.tag = sender.view.tag;
            count = [[_readingVal objectAtIndex:sender.view.tag] intValue];
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
            
        case 2:
            [MeterPopView setHidden:NO];
            [MeterCrossButton setHidden:NO];
            [MeterPlusButton setHidden:NO];
            [MeterImage setHidden:NO];
            MeterPlusButton.tag = sender.view.tag;
            [SaveMeterImage setHidden:NO];
            SaveMeterImage.tag = sender.view.tag;
            count = [[_readingVal objectAtIndex:sender.view.tag] intValue];
            switch (count)
        {
            case 0:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
            
        case 3:
            
            [MeterPopView setHidden:NO];
            [MeterCrossButton setHidden:NO];
            [MeterPlusButton setHidden:NO];
            [MeterImage setHidden:NO];
            [SaveMeterImage setHidden:NO];
            SaveMeterImage.tag = sender.view.tag;
            MeterPlusButton.tag = sender.view.tag;
            count = [[_readingVal objectAtIndex:sender.view.tag] intValue];
            switch (count)
        {
            case 0:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
            
        case 4:
            [MeterPopView setHidden:NO];
            [MeterCrossButton setHidden:NO];
            [MeterPlusButton setHidden:NO];
            [MeterImage setHidden:NO];
            [SaveMeterImage setHidden:NO];
            SaveMeterImage.tag = sender.view.tag;
            MeterPlusButton.tag = sender.view.tag;
            count = [[_readingVal objectAtIndex:sender.view.tag] intValue];
            switch (count)
        {
            case 0:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
            
        default:
            break;
    }
}
-(void)MeterPlusButton:(UIButton *)sender
{
    
    switch (sender.tag)
    {
        case 0:
            
            // count = l+count;
            count ++;
            
            if (count> 9)
            {
                count = 0;
            }
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
        case 1:
            //            count = count;
            count ++;
            if (count> 9)
            {
                count = 0;
            }
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
        case 2:
            count ++;
            if (count> 9)
            {
                count = 0;
            }
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            
            break;
        case 3:
            
            count ++;
            if (count> 9)
            {
                count = 0;
            }
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
        case 4:
            
            count ++;
            if (count> 9)
            {
                count = 0;
            }
            
            switch (count)
        {
            case 0:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage10"]];
                break;
            case 1:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage1"]];
                break;
            case 2:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage2"]];
                break;
            case 3:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage3"]];
                break;
            case 4:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage4"]];
                break;
            case 5:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage5"]];
                break;
            case 6:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage6"]];
                break;
            case 7:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage7"]];
                break;
            case 8:
                
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage8"]];
                break;
            case 9:
                [MeterImage setImage:[UIImage imageNamed:@"MeterClockImage9"]];
                break;
            default:
                break;
        }
            
            break;
        default:
            break;
    }
    
}
-(void)MeterCrossTap:(UIButton *)sender
{
    [MeterPopView setHidden:YES];
    [MeterCrossButton setHidden:YES];
    [MeterPlusButton setHidden:YES];
    [MeterImage setHidden:YES];
    [SaveMeterImage setHidden:YES];
    count = 0;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    
    
}

//back button functanality............

-(void)back:(UIButton *)sender{
    
    MMUsageBudgetViewController *budgt = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:budgt animated:NO];
}

//save button functanality............

-(void)Save:(UIButton *)sender{
    
    
    NSDate *currentdate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *currenttime = [dateFormatter stringFromDate:currentdate];
    
    
    NSLog(@"allvalue... :%@",allval);
    
    
    NSString *setbudget = [[NSString alloc]init];
    
    setbudget = [NSString stringWithFormat:@"%@/meter_reading.php?userid=%@&meter_reading=%@&date=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],allval,[currenttime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"setbudget... :%@",setbudget);
    
    NSError *error=nil;
    
    
    NSData *BudgetData=[NSData dataWithContentsOfURL:[NSURL URLWithString:setbudget]options:NSDataReadingUncached error:&error];
    NSDictionary *result_new=[NSJSONSerialization JSONObjectWithData:BudgetData options:kNilOptions error:&error];
    
    
    NSDictionary *newdict = [result_new objectForKey:@"budgetetails"];
    
    float budgtstr = [[newdict objectForKey:@"budget_exceed"]floatValue];
    
    NSString *budgettime = [newdict objectForKey:@"time"];
    
    
    if ([[result_new objectForKey:@"auth"]isEqualToString:@"success"]) {
        
        if ([[newdict objectForKey:@"budget_status"] isEqualToString:@"NO"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please set your budget" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            
        }
        else{
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",budgettime] forKey:@"budgettime"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",budgtstr] forKey:@"budgetexceed"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
            [self.navigationController pushViewController:model animated:NO];
            
            
            
        }
        
        
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
