//
//  MMDaysAndPrice.h
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 24/06/15.
//
//

#import <UIKit/UIKit.h>

@interface MMDaysAndPrice : UIView

@property (retain, nonatomic) UIView *mainView;
@property (retain, nonatomic) UILabel *sunLabel;
@property (retain, nonatomic) UILabel *monLabel;
@property (retain, nonatomic) UILabel *tueLabel;
@property (retain, nonatomic) UILabel *wedLabel;
@property (retain, nonatomic) UILabel *thuLabel;
@property (retain, nonatomic) UILabel *friLabel;
@property (retain, nonatomic) UILabel *satLabel;
@property (retain, nonatomic) UILabel *dollarLabel;

@property (retain,nonatomic) NSMutableArray *viewLabel;

@property (nonatomic) int sunPrice;
@property (nonatomic) int monPrice;
@property (nonatomic) int tuePrice;
@property (nonatomic) int wedPrice;
@property (nonatomic) int thuPrice;
@property (nonatomic) int friPrice;
@property (nonatomic) int satPrice;

@property (retain, nonatomic) UILabel *sunP;
@property (retain, nonatomic) UILabel *monP;
@property (retain, nonatomic) UILabel *tueP;
@property (retain, nonatomic) UILabel *wedP;
@property (retain, nonatomic) UILabel *thuP;
@property (retain, nonatomic) UILabel *friP;
@property (retain, nonatomic) UILabel *satP;

@end
