//
//  MMSvcscheduleViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 21/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 150.0
#import "MMSvcscheduleViewController.h"
#import "MMSvcsubcategoryViewController.h"
#import "MMReportViewController.h"


@interface MMSvcscheduleViewController ()
{
    NSMutableArray *FinalDatesOfMonth;
    V8HorizontalPickerView *pickerView1;
    V8HorizontalPickerView *pickerView2;
}


@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSArray *disabledDates;

//@property(nonatomic, strong) NSMutableArray *DateArray;

@end

@implementation MMSvcscheduleViewController

@synthesize Cat_id,SubCat_id,svcstring;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    
    
    
    // Release any retained subviews of the main view.
    //    _pickerView = nil;
    //    _pickerView1 = nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"MMSvcscheduleViewController");
    
    FinalDatesOfMonth =[[NSMutableArray alloc]init];
    NSLog(@"here in the didload--%@",_ArrayOfMonthDates);
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    //menu button............
    
    Menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Menubtn setFrame:CGRectMake(0.0f, 30.0f, 66/2,40/2)];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateHighlighted];
    [Menubtn addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Menubtn];
    
    
    UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 43.0f, 40.0f)];
    [menuview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:menuview];
    
    UITapGestureRecognizer *menutap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menu:)];
    [menuview addGestureRecognizer:menutap];
    menuview.userInteractionEnabled = YES;
    
    //HeaderLabel.......................
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,150.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"REPORT"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //outage button.................
    
    outagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outagebtn setFrame:CGRectMake(100.0f, 77.0f, 45.5f, 41.5f)];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateNormal];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateHighlighted];
    [outagebtn addTarget:self action:@selector(outage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outagebtn];
    
    //svccall button.................
    
    svccallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [svccallbtn setFrame:CGRectMake(170.0f,77.0f, 53.0f, 43.0f)];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateNormal];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateHighlighted];
    //[svccallbtn addTarget:self action:@selector(Svccall:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:svccallbtn];
    
    
    selectedView = [[UIImageView alloc]initWithFrame:CGRectMake(138.5f, 180.0f, 63.0f, 57.0f)];
    [selectedView setImage:[UIImage imageNamed:@"selectedviewimg"]];
    [MainView addSubview:selectedView];
    
    ///////////////////////=================================///////////////////////////////===========================//////
    
    
    //date label..........................
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc]init];
    [dateFormatterNew setDateFormat:@"dd-MMMM-yyyy"];
    NSString *dateString = [dateFormatterNew stringFromDate:currDate];
    
    NSArray* foo = [dateString componentsSeparatedByString: @"-"];
    
    month1 = [foo objectAtIndex:1];
    year1 = [foo objectAtIndex: 2];
    
    
    
    
    
    
    Monthlbl = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, 130.0f, 320.0f, 30.0f)];
    [Monthlbl setTextColor:[UIColor whiteColor]];
    [Monthlbl setBackgroundColor:[UIColor clearColor]];
    [Monthlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15]];
    [Monthlbl setTextAlignment:NSTextAlignmentCenter];
    [MainView addSubview:Monthlbl];
    [Monthlbl setText:[foo objectAtIndex:1]];
    
    
    
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 30, 30)];
    
    [datescroll addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //////////////////////////=============================//////////////////////////////////==========================//////////
    
    
    //Time label //.............................
    
    btnArrayNew = [[NSMutableArray alloc]init];
    CalendarButtonArray = [[NSMutableArray alloc]init];
    
    
    UILabel *Timelbl = [[UILabel alloc]initWithFrame:CGRectMake(6.0f, 260.0f, 320.0f, 20.0f)];
    [Timelbl setText:@"Time"];
    [Timelbl setTextAlignment:NSTextAlignmentCenter];
    [Timelbl setTextColor:[UIColor whiteColor]];
    [Timelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:14.0f]];
    [MainView addSubview:Timelbl];
    
    
    UIView *scrollview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 290.0f, 320.0f, 57.0f)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:scrollview];
    
    
    timescroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
    timescroll.userInteractionEnabled=YES;
    timescroll.scrollEnabled=YES;
    timescroll.showsHorizontalScrollIndicator=YES;
    timescroll.contentSize=CGSizeMake(648,6.0f );
    [scrollview addSubview:timescroll];
    
    _titleArray = [NSMutableArray arrayWithObjects:@"12-2", @"2-4", @"4-6", @"6-8", @"8-10",@"10-12",@"12-2",@"2-4",@"4-6",@"6-8",@"8-10",@"10-12", nil];
    
    _timeformatarray = [[NSMutableArray alloc]init];
    
    _timeformatarray = [NSMutableArray arrayWithObjects:@"AM",@"AM",@"AM",@"AM",@"AM",@"AM",@"PM",@"PM",@"PM",@"PM",@"PM",@"PM", nil];
    
    CGFloat margin = 10.0f;
    CGFloat width = (MainView.bounds.size.width - (margin * 2.0f));
    CGFloat pickerHeight = 57.0f;
    CGFloat x = margin;
    CGFloat y = 300.0f;
    CGRect tmpFrame = CGRectMake(x, y-4, width, pickerHeight);
    
    //	CGFloat width = 200.0f;
    //	CGFloat x = (self.view.frame.size.width - width) / 2.0f;
    //	CGRect tmpFrame = CGRectMake(x, 150.0f, width, 40.0f);
    
    pickerView1 = [[V8HorizontalPickerView alloc] initWithFrame:tmpFrame];
    [pickerView1 setTag:1];
    pickerView1.backgroundColor   = [UIColor clearColor];
    pickerView1.selectedTextColor = [UIColor whiteColor];
    pickerView1.textColor   = [UIColor grayColor];
    pickerView1.delegate    = self;
    pickerView1.dataSource  = self;
    
    
    
    pickerView1.elementFont = [UIFont boldSystemFontOfSize:14.0f];
    pickerView1.selectionPoint = CGPointMake(160, 0);
    
    
    
    // add carat or other view to indicate selected element
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedviewimg"]];
    pickerView1.selectionIndicatorView = indicator;
    [MainView addSubview:pickerView1];
    [pickerView1 scrollToElement:0 animated:NO];
    
    
    pickerView2 = [[V8HorizontalPickerView alloc] initWithFrame:CGRectMake(0.0f,180.0f, 320.0f, 57.0f)];
    [pickerView2 setTag:2];
    pickerView2.backgroundColor   = [UIColor clearColor];
    pickerView2.selectedTextColor = [UIColor whiteColor];
    pickerView2.textColor   = [UIColor grayColor];
    pickerView2.delegate    = self;
    pickerView2.dataSource  = self;
    
    
    pickerView2.elementFont = [UIFont boldSystemFontOfSize:14.0f];
    pickerView2.selectionPoint = CGPointMake(160, 0);
    
    
    UIImageView *indicator1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backg.png"]];
    pickerView2.selectionIndicatorView = indicator1;
    [MainView addSubview:pickerView2];
    [pickerView2 scrollToElement:0 animated:NO];
    
    
    ////////////////////////////====================================////////////////////////////////////
    //comment label...............
    UILabel *Commentlbl = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 370, 320.0f, 30.0f)];
    [Commentlbl setText:@"Comments"];
    [Commentlbl setTextAlignment:NSTextAlignmentCenter];
    [Commentlbl setTextColor:[UIColor whiteColor]];
    [Commentlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:14.0f]];
    [MainView addSubview:Commentlbl];
    
    UIView *UsBackView4 = [[UIView alloc] initWithFrame:CGRectMake(-2.0f, 400.0f, 324.0f, 130/2)];
    //    UsBackView4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Addressfield"]];
    [UsBackView4 setBackgroundColor:[UIColor colorWithRed:(168.0f/255.0f) green:(185.0f/255.0f) blue:(203.0f/255.0f) alpha:0.5f]];
    UsBackView4.layer.borderWidth = 1.0f;
    UsBackView4.layer.borderColor = [[UIColor colorWithRed:(198.0f/255.0f) green:(210.0f/255.0f) blue:(221.0f/255.0f) alpha:0.5f]CGColor];
    [MainView addSubview:UsBackView4];
    
    CoemtText = [[UITextView alloc]initWithFrame:CGRectMake(10.0f,3.0f,300.0f,60.0f)];
    CoemtText.textColor = [UIColor whiteColor];
    CoemtText.font = [UIFont fontWithName:GLOBALTEXTFONT size:20.0f];
    CoemtText.backgroundColor = [UIColor clearColor];
    CoemtText.scrollEnabled = YES;
    CoemtText.pagingEnabled = YES;
    CoemtText.editable = YES;
    CoemtText.delegate = self;
    CoemtText.textAlignment = NSTextAlignmentLeft;
    [UsBackView4 addSubview:CoemtText];
    
    //===========Details view.............
    
    if ([svcstring isEqualToString:@"linelocate"]) {
        
        
        UIImageView *lineimg = [[UIImageView alloc]initWithFrame:CGRectMake(143.0f, 470.0f, 35.0f, 34.0f)];
        [lineimg setImage:[UIImage imageNamed:@"linelocateimg"]];
        [MainView addSubview:lineimg];
        
        UILabel *linelabl = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 505.0f, 100.0f, 20.0f)];
        [linelabl setText:@"Line Locate"];
        [linelabl setTextAlignment:NSTextAlignmentCenter];
        [linelabl setTextColor:[UIColor whiteColor]];
        [linelabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [MainView addSubview:linelabl];
        
        
    }else if ([svcstring isEqualToString:@"audit"]){
        
        UIImageView *auditimg = [[UIImageView alloc]initWithFrame:CGRectMake(146.0f, 470.0f,27.5f, 34.0f)];
        [auditimg setImage:[UIImage imageNamed:@"auditimg"]];
        [MainView addSubview:auditimg];
        
        UILabel *auditlabl = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 505.0f, 100.0f, 20.0f)];
        [auditlabl setText:@"Audit"];
        [auditlabl setTextAlignment:NSTextAlignmentCenter];
        [auditlabl setTextColor:[UIColor whiteColor]];
        [auditlabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [MainView addSubview:auditlabl];
        
    }else if ([svcstring isEqualToString:@"other"]){
        
        UIImageView *otherimg = [[UIImageView alloc]initWithFrame:CGRectMake(146.0f, 470.0f,27.5f, 34.0f)];
        [otherimg setImage:[UIImage imageNamed:@"otherimage"]];
        [MainView addSubview:otherimg];
        
        UILabel *otherlabl = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 505.0f, 100.0f, 20.0f)];
        [otherlabl setText:@"Other"];
        [otherlabl setTextAlignment:NSTextAlignmentCenter];
        [otherlabl setTextColor:[UIColor whiteColor]];
        [otherlabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [MainView addSubview:otherlabl];
        
    }else{
        
        UIImageView *treetrimimg = [[UIImageView alloc]initWithFrame:CGRectMake(146.0f, 470.0f,27.5f, 34.0f)];
        [treetrimimg setImage:[UIImage imageNamed:@"Treetrimimg"]];
        [MainView addSubview:treetrimimg];
        
        UILabel *treetrimlabl = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 505.0f, 100.0f, 20.0f)];
        [treetrimlabl setText:@"Tree Trim"];
        [treetrimlabl setTextAlignment:NSTextAlignmentCenter];
        [treetrimlabl setTextColor:[UIColor whiteColor]];
        [treetrimlabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [MainView addSubview:treetrimlabl];
        
    }
    
    //backbutton.........................
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 530.0f, 54/2, 33)];
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
    
    //schedule.........................
    
    schedulebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [schedulebtn setFrame:CGRectMake(270.0f, 528.0f, 22, 36)];
    [schedulebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [schedulebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [schedulebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:schedulebtn];
    
    // Do any additional setup after loading the view.
}


-(void)CalendarButtonPressed:(UIButton *)sender {
    
    //    NSLog(@"pressed sender tag is %d", sender.tag-1);
    
    for (int B = 0; B < CalendarButtonArray.count; B++) {
        
        if(B == sender.tag-1) {
            
            [self selectedOneCalender:CalendarButtonArray selectedindex:B];
        }
    }
    
}


-(void)selectedOneCalender:(NSArray *)buttonarray selectedindex:(int)index{
    
    for(int i=0;i<[buttonarray count];i++){
        
        UIButton *button=(UIButton *)[buttonarray objectAtIndex:i];
        
        if(i==index){
            
            [button setBackgroundImage:[UIImage imageNamed:@"selectedviewimg"] forState:UIControlStateNormal];
            
            datestring = [NSString stringWithFormat:@"%@/%@/%@",button.titleLabel.text,month1,year1];
            
            NSLog(@".........date.....%@",datestring);
        }
        
        else{
            
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            
        }
    }
}





-(void)viewDidAppear:(BOOL)animated {
    //"2014-10-20 18:30:00 +0000",
    [super viewDidAppear:YES];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    NSLog(@"final------%@",FinalDatesOfMonth);
    
}


//menu function........
-(void)menu:(UIButton *)sender{
    
    
    if(MainView.frame.origin.x > 100.0f) {
        
        [UIView animateWithDuration:0.3
         
                         animations:^{
                             
                             [MainView setFrame:[[UIScreen mainScreen] bounds]];
                             
                         }
         
                         completion:^(BOOL finished){
                             
                             menuOpened = NO;
                             
                             [self.view bringSubviewToFront:MainView];
                             
                         }];
        
        
        
    } else {
        
        [UIView animateWithDuration:0.3
         
                         animations:^{
                             
                             [MainView setFrame:CGRectMake(280.0f, 0, MainView.frame.size.width, MainView.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             menuOpened = YES;
                             
                             [self.view bringSubviewToFront:MainView];
                             
                         }];
        
    }
    
}

-(void)back:(UIButton *)sender{
    
    MMSvcsubcategoryViewController *viewmodel = [[MMSvcsubcategoryViewController alloc]init];
    [self.navigationController pushViewController:viewmodel animated:NO];
    
}


//textview keyboard return function.....
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    CoemtText.textColor = [UIColor whiteColor];
    return YES;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if ([CoemtText.text isEqualToString:@""]) {
        
        
    }
    else{
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [CoemtText resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    
    // register for keyboard notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated

{
    // unregister for keyboard notifications while not visible.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification  object:nil];
    
}

-(void)keyboardWillShow {
    
    [self setViewMovedUp:YES];
    
    
}
-(void)keyboardWillHide {
    
    [self setViewMovedUp:NO];
    
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = MainView.frame;
    
    
    
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    MainView.frame = rect;
    
    [UIView commitAnimations];
    
}

-(void)Save:(UIButton *)sender{
    
    if ([datestring length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        
        
    }
    else if ([timestring length] == 0){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        
    }
    else if ([CoemtText.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        
    }
    else if ([CoemtText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    else{
        
        NSString *SvcStr = [[NSString alloc]init];
        
        SvcStr = [NSString stringWithFormat:@"%@/SVC_details.php?cat_id=%@&sub_catid=%@&date=%@&time=%@&comments=%@&user_id=%@",DOMAIN_APP_URL,Cat_id,SubCat_id,datestring,timestring,[CoemtText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
        
        NSLog(@"url........%@",SvcStr);
        
        NSError *error=nil;
        
        
        NSData *SvcData=[NSData dataWithContentsOfURL:[NSURL URLWithString:SvcStr]options:NSDataReadingUncached error:&error];
        NSString *svcstring = [[NSString alloc] initWithData:SvcData encoding:NSUTF8StringEncoding];
        
        if ([svcstring isEqualToString:@"success"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Report saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            
        }
        
        
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
    
}
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    NSLog(@"ppicker tag hereer>>>>>>>---%ld",(long)picker.tag);
    if (picker.tag == 1) {
        NSLog(@"here in  the nunber of element in the picker 1111111111");
        return [_titleArray count];
    }
    else {
        NSLog(@"here in  the nunber of element in the picker 22222222");
        return [_ArrayOfMonthDates count];
        
    }
    
}
- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
    // NSLog(@"ppicker tag hereer  in width section---%ld",(long)picker.tag);
    if (picker.tag == 1) {
        
        CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        if (index<12) {
            NSString *text = [_titleArray objectAtIndex:index];
            CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                               constrainedToSize:constrainedSize
                                   lineBreakMode:UILineBreakModeCharacterWrap];
            return textSize.width + 40.0f;
        }
        
        
        
    }
    else{
        
        CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSString *text = [_ArrayOfMonthDates objectAtIndex:index];
        
        CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                           constrainedToSize:constrainedSize
                               lineBreakMode:UILineBreakModeCharacterWrap];
        return textSize.width + 40.0f;
    }
    
    // 20px padding on each side
    return 0.0f;
}
- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index {
    // NSLog(@"ppicker tag hereer-did select at index--%ld",(long)picker.tag);
    if (picker.tag == 1) {
        NSLog(@"....%@",[_titleArray objectAtIndex:index]);
        
        //        _infoLabel.text = [NSString stringWithFormat:@"Selected index %@", [_titleArray objectAtIndex:index]];
    }
    else{
        
        //        _infoLabel1.text = [NSString stringWithFormat:@"Selected index %@", [_timeformatarray objectAtIndex:index]];
        
        NSLog(@"....%@",[_ArrayOfMonthDates objectAtIndex:index]);
        
    }
    
}

- (UIView *)horizontalPickerView:(V8HorizontalPickerView *)picker viewForElementAtIndex:(NSInteger)index;
{
    //NSLog(@"ppicker tag hereer- view for element at index--%d",picker.tag);
    if (picker.tag == 1) {
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        v.backgroundColor = [UIColor clearColor];
        CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSString *text = @"am";
        
        CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                           constrainedToSize:constrainedSize
                               lineBreakMode:UILineBreakModeCharacterWrap];
        
        UILabel* l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 40, 24)];
        l1.font = [UIFont systemFontOfSize:22]; // choose desired size
        l1.textColor = [UIColor whiteColor];
        l1.textAlignment = NSTextAlignmentCenter;
        if (index<12) {
            l1.text = [_titleArray objectAtIndex:index];
        }
        
        [v addSubview: l1];
        
        UILabel* l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, textSize.width + 40, 16)];
        l2.font = [UIFont systemFontOfSize:14]; // choose desired size
        l2.textColor = [UIColor whiteColor];
        l2.textAlignment = NSTextAlignmentCenter;
        if (index<12) {
            
            l2.text= [_timeformatarray objectAtIndex:index];
        }
        
        [v addSubview: l2];
        return v;
    }
    else{
        
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        v.backgroundColor = [UIColor clearColor];
        CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSString *text = @"am";
        
        CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                           constrainedToSize:constrainedSize
                               lineBreakMode:UILineBreakModeCharacterWrap];
        
        UILabel* l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 40, 24)];
        l1.font = [UIFont systemFontOfSize:22]; // choose desired size
        l1.textColor = [UIColor whiteColor];
        l1.textAlignment = NSTextAlignmentCenter;
        l1.text = [[[NSString stringWithFormat:@"%@",[_ArrayOfMonthDates objectAtIndex:index]] componentsSeparatedByString:@"-"] objectAtIndex:0];
        [v addSubview: l1];
        
        UILabel* l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, textSize.width + 40, 16)];
        l2.font = [UIFont systemFontOfSize:14]; // choose desired size;
        l2.textColor = [UIColor whiteColor];
        l2.textAlignment = NSTextAlignmentCenter;
        l2.text= [[[NSString stringWithFormat:@"%@",[_ArrayOfMonthDates objectAtIndex:index]] componentsSeparatedByString:@"-"] objectAtIndex:1];
        [v addSubview: l2];
        return v;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)outage:(UIButton *)sender
{
    MMReportViewController *list = [[MMReportViewController alloc]init];
    [self.navigationController pushViewController:list animated:NO];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
