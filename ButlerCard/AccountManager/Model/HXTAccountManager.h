//
//  HXTAccountManager.h
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDeposit                  @"Deposit"
#define kSessionID				  @"SessionID"
#define kUserID                   @"UserID"
#define kGroupID                  @"GroupID"
#define kUserName				  @"UserName"
#define kNickName				  @"NickName"
#define kSchemeName               @"SchemeName"
#define kPassword				  @"Password"
#define kPhoneNumber              @"PhoneNumber"
#define kEmailAddr                @"EmailAddr"
#define kSex                      @"Sex"
#define kcurrentArea              @"currentArea"
#define kDefaultHouseingEstate    @"DefaultHouseingEstate"
#define kLogged                   @"Logged"
#define kFirstRun                 @"FirstRun"
#define kEnablePush               @"EnablePush"

@class HXTAccountManager;

@protocol AccountManagerDelegate <NSObject>

@optional

- (void)accountManager:(HXTAccountManager *)accountManager loginDidSucessed:(BOOL)sucessed;
- (void)accountManager:(HXTAccountManager *)accountManager registerAccountDidSucessed:(BOOL)sucessed;

@end

@interface HXTAccountManager : NSObject

@property (assign, nonatomic) id<AccountManagerDelegate> delegate;

@property (assign, nonatomic) double   deposit;
@property (copy,   nonatomic) NSString *sessionID;
@property (assign, nonatomic) NSUInteger userID;
@property (copy,   nonatomic) NSString *groupID;
@property (copy,   nonatomic) NSString *username;
@property (copy,   nonatomic) NSString *nickName;
@property (copy,   nonatomic) NSString *schemeName;
@property (copy,   nonatomic) NSString *password;
@property (copy,   nonatomic) NSString *phoneNumber;
@property (copy,   nonatomic) NSString *emailAddr;
@property (copy,   nonatomic) NSString *sex;
@property (copy,   nonatomic) NSString *currentArea;
@property (copy,   nonatomic) NSString *defaultHouseingEstate;

@property (assign, nonatomic, getter = isLogged) BOOL logged;
@property (assign, nonatomic, getter = isFirstRun) BOOL firstRun;
@property (assign, nonatomic, getter = isEnablePush) BOOL enablePush;

+ (instancetype)sharedInstance;
- (BOOL)writeDataToUserDefault;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)registerAndLoginAccountWithUsername:(NSString *)username password:(NSString *)password;

#define kLoginStartNotification   @"LoginStartNotification"
#define kLoginSuccessNotification @"LoginSuccessNotification"
#define kLoginFailedNotification  @"LoginFailedNotification"

#define kRegisteredAndLoginStartNotification   @"RegisteredAndLoginStart"
#define kRegisteredAndLoginSuccessNotification @"RegisteredAndLoginSuccess"
#define kRegisteredAndLoginFailedNotification  @"RegisteredAndLoginFailed"

@end
