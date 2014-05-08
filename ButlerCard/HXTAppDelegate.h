//
//  HXTAppDelegate.h
//  ButlerCard
//
//  Created by johnny tang on 2/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GexinSdk.h"

typedef enum {
    SdkStatusStoped,
    SdkStatusStarting,
    SdkStatusStarted
} SdkStatus;

@interface HXTAppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate>
{
    @private
    UINavigationController *_naviController;
    NSString *_deviceToken;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *gesturePasswordNaviViewController;
//@property (strong, nonatomic) UIViewController *loginViewController;

//引入CoreData框架
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//个推 属性
@property (strong, nonatomic) GexinSdk *gexinPusher;

@property (retain, nonatomic) NSString *appKey;
@property (retain, nonatomic) NSString *appSecret;
@property (retain, nonatomic) NSString *appID;
@property (retain, nonatomic) NSString *clientId;
@property (assign, nonatomic) SdkStatus sdkStatus;

@property (assign, nonatomic) int lastPayloadIndex;
@property (retain, nonatomic) NSString *payloadId;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//个推方法
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
- (void)stopSdk;

- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError **)error;
- (NSString *)sendMessage:(NSData *)body error:(NSError **)error;

- (void)testSdkFunction;
- (void)testSendMessage;

@end
