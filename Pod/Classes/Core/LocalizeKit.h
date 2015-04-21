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

typedef NS_ENUM(NSUInteger, LKDebugLevel) {
  LKDebugLevelDevelopment, //logs translations, writes translations data to /Users/CURRENT_USER/Desktop/LocalizeKit-BUNDLE_IDENTIFIER
  LKDebugLevelDebug,       //only logs translations
  LKDebugLevelProduction   //no logging, no writting translations file
};

@interface LocalizeKit : NSObject

@property (nonatomic, strong) NSString * dataFileName;

@property (nonatomic) LKDebugLevel debugLevel;

@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSArray *availableLocales;

+(void)config:(void (^)(LocalizeKit *lk))block;
+(instancetype)instance;

+ (NSString *)translate:(NSString *)key;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params;
+ (NSString *)translatea:(NSArray *)arguments;

- (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params;

@end


