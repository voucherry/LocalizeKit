//
//  LocalizeKit.h
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"
#import "UIBarButtonItem+LocalizeKit.h"
#import "UIButton+LocalizeKit.h"
#import "UILabel+LocalizeKit.h"
#import "UINavigationBar+LocalizeKit.h"
#import "UINavigationItem+LocalizeKit.h"
#import "UISearchBar+LocalizeKit.h"
#import "UITextField+LocalizeKit.h"
#import "UITextView+LocalizeKit.h"
#import "UIToolbar+LocalizeKit.h"
#import "UIView+LocalizeKit.h"
#import "UIViewController+LocalizeKit.h"
#import "LocalizeKitConfig.h"

extern NSString * const LocalizeKitShouldReloadDataNotification;


@interface LocalizeKit : NSObject

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSString *usedLocaleIdentifier;
@property (nonatomic, readonly) LocalizeKitConfig *config;

+(void)setup:(void (^)(LocalizeKitConfig *config))block;

+ (NSString *)translate:(NSString *)key;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params;
+ (NSString *)translate:(NSString *)key params:(NSDictionary *)params;
+ (NSString *)translatea:(NSArray *)arguments;

@end


