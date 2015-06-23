#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,retain)  NSMutableArray *ImageThumUrlArray;

@property (retain, nonatomic) FBSession *session;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *menuNavController;
@property(nonatomic,readwrite) NSMutableArray *CircleArray;
@property(nonatomic,readwrite) NSMutableDictionary *individualCircleDataDict;





@property(nonatomic,retain) NSMutableArray *CenterArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral1PointsXDataArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral1PointsYDataArray;

@property (strong, nonatomic) NSMutableArray *CirclePeripheral2PointsXDataArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral2PointsYDataArray;

@property (strong, nonatomic) NSMutableArray *CirclePeripheral3PointsXDataArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral3PointsYDataArray;

@property (strong, nonatomic) NSMutableArray *CirclePeripheral4PointsXDataArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral4PointsYDataArray;


@property (strong, nonatomic) NSMutableArray *CirclePeripheral5PointsXDataArray;
@property (strong, nonatomic) NSMutableArray *CirclePeripheral5PointsYDataArray;



@end