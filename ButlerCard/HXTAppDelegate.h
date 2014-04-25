//
//  HXTAppDelegate.h
//  ButlerCard
//
//  Created by johnny tang on 2/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//引入CoreData框架
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
