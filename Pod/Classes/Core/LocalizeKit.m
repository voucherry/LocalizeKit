//
//  LocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "LocalizeKit.h"
#import "NSArray+LocalizeKit.h"
#import "NSDictionary+LocalizeKit.h"
#import "NSString+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import <RegExCategories/RegExCategories.h>

@interface LocalizeKit ()

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSMutableDictionary *translations;

- (void)storeTranslation:(NSString *)translation forKey:(NSString *)key inScope:(NSString *)scope;

@end

@implementation LocalizeKit
LKSINGLETON(LocalizeKit)
@synthesize locale=_locale;

- (void)setLocale:(NSString *)locale {
  if (self.data && self.data[@"Localisations"][locale]) {
    _locale = locale;
    _translations = nil;
    return;
  }
  if (self.data && self.data[@"Aliases"] && self.data[@"Aliases"][locale] && ![locale isEqualToString:self.data[@"Aliases"][locale]]) {
    [self setLocale:self.data[@"Aliases"][locale]];
    return;
  }
}

- (NSString *)locale {
  if (_locale==nil) {
    if (self.data) {
      _locale = [[self.data[@"Localisations"] allKeys] firstObject];
    }
  }
  return _locale;
}

+(void)config:(void (^)(LocalizeKit *lk))block {
  block([LocalizeKit instance]);
  [[self instance] setData:nil];
}

+ (NSString *)translate:(NSString *)key {
  return [[self instance] translate:key scope:nil params:nil];
}

+ (NSString *)translate:(NSString *)key scope:(NSString *)scope {
  return [[self instance] translate:key scope:scope params:nil];
}

+ (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params {
  return [[self instance] translate:key scope:scope params:params];
}

+ (NSString *)translatea:(NSArray *)arguments {
  if (arguments==nil || arguments.count==0 || arguments.count>3) {
    return nil;
  }
  NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
  NSString *key;
  NSString *scope;
  NSDictionary *params;

  key = args[0];
  [args removeObjectAtIndex:0];

  if (args.count>0 && [args[0] isKindOfClass:[NSString class]]) {
    scope = args[0];
    [args removeObjectAtIndex:0];
  }

  if (args.count>0 && [args[0] isKindOfClass:[NSDictionary class]]) {
    params = args[0];
    [args removeObjectAtIndex:0];
  }
  return [[self instance] translate:key scope:scope params:params];
}

- (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params {
  if (scope==nil) scope = @"General";
  if (params==nil) params = @{};
  NSMutableString *r = [NSMutableString stringWithCapacity:100];
  if (self.translations[scope]!=nil && self.translations[scope][key]!=nil) {
    [r appendString:self.translations[scope][key]];
  } else {
    [r appendString:(params[@"default"] ?: key)];
    if (self.debugLevel == LKDebugLevelDevelopment) {
      [self storeTranslation:[@"" stringByAppendingString:r] forKey:key inScope:scope];
    }
  }

  NSString *uninterpolatedResult = [NSString stringWithString:r];

  //replace cldr interpolations
  //ex: pluralization %<{"count": { "zero": "Nada", "one": "One Cherry Coin", "other": "%{count} Cherry Coins" } }>
  NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"%<(.*?)>" options:NSRegularExpressionCaseInsensitive error:nil];
