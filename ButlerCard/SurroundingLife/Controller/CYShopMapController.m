//
//  CYShopMapController.m
//  ButlerCard
//
//  Created by niko on 14-4-28.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYShopMapController.h"
#import "CYCustomAnnotation.h"
#import "Shop.h"

@interface CYShopMapController ()

@end

@implementation CYShopMapController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self queryFromDB];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (HXTAppDelegate *)[[UIApplication sharedApplication] delegate];

    
//    _shopMap = [[MKMapView alloc] initWithFrame:[self.view bounds]];
    //显示地图
    _shopMap.showsUserLocation = YES;
    _shopMap.mapType = MKMapTypeStandard;
    [self.view addSubview:_shopMap];
    //定位
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([_shopLatitude doubleValue],[_shopLongitude doubleValue]);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_shopMap setRegion:[_shopMap regionThatFits:region] animated:YES];
    //放大头针
    [self createAnnotationWithCoords:coords];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)createAnnotationWithCoords:(CLLocationCoordinate2D) coords
{
    CYCustomAnnotation *annotation = [[CYCustomAnnotation alloc] initWithCoordinate:
                                    coords];
    annotation.title = _shopName;
    annotation.subtitle = _shopAddress;
    [_shopMap addAnnotation:annotation];
}
- (void)queryFromDB
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop"inManagedObjectContext:self.myDelegate.managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(shopID = %@)",[[NSUserDefaults standardUserDefaults]valueForKey:kShopID]];
    [request setPredicate:predicate];
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil)
    {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    NSLog(@"The count of FetchResult:%lu",(unsigned long)[mutableFetchResult count]);
    for(Shop *shop in mutableFetchResult)
    {
        //        NSLog(@"Shop ------>  grade:%@",entry.grade);
        _shopName = shop.name;
        _shopAddress = shop.address;
        _shopLatitude = shop.positionY;
        _shopLongitude = shop.positionX;
    }
}

@end
