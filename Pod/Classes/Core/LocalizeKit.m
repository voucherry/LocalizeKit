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
  r = [[r replace:regexp withDetailsBlock:^NSString *(RxMatch *match) {
    if (match.groups.count==2) {
      //process the interpolation data
      NSDictionary *dict = [[(RxMatchGroup *)match.groups.lastObject value] lk_JSONValue];
      NSString *pluralKey = [[dict allKeys] objectAtIndex:0];
      NSDictionary *pluralData = dict[pluralKey];
      
      //return the string if the translation params doesn't include the plural key
      if (params[pluralKey]==nil)
        return [(RxMatchGroup *)match.groups.firstObject value];
      
      //when the cldr interpolated param is a number try to pluralize
      if ([params[pluralKey] isKindOfClass:[NSNumber class]]) {
        if ([params[pluralKey] integerValue]==0 && pluralData[@"zero"]!=nil)
          return pluralData[@"zero"];
        if ([params[pluralKey] integerValue]==1 && pluralData[@"one"]!=nil)
          return dict[pluralKey][@"one"];
        if ([params[pluralKey] integerValue]==2 && pluralData[@"two"]!=nil)
          return dict[pluralKey][@"two"];
        if (pluralData[@"other"]!=nil)
          return dict[pluralKey][@"other"];
      }
      
      //if the parameter is in the parameter
      if (pluralData[params[pluralKey]]!=nil)
        return pluralData[params[pluralKey]];
    }
    return @"";
  }] mutableCopy];

  [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [r replaceOccurrencesOfString:[NSString stringWithFormat:@"%%{%@}", key]
                       withString:[NSString stringWithFormat:@"%@",obj]
                          options:NSCaseInsensitiveSearch
                            range:NSMakeRange(0, [r length])];
    [r replaceOccurrencesOfString:[NSString stringWithFormat:@"{{%@}}", key]
                       withString:[NSString stringWithFormat:@"%@",obj]
                          options:NSCaseInsensitiveSearch
                            range:NSMakeRange(0, [r length])];

  }];
  if ([r isMatch:RX(@"&.*?;")]) {
    r = [[[[NSAttributedString alloc] initWithData:[r dataUsingEncoding:NSUTF8StringEncoding]
                                           options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType}
                                documentAttributes:nil
                                             error:nil] string] mutableCopy];
  }

  if (self.debugLevel==LKDebugLevelDevelopment) {
    @try {
      NSMutableDictionary *interpolations = [NSMutableDictionary dictionaryWithDictionary:params];
      [interpolations removeObjectForKey:@"default"];
      NSString *currentUser = NSUserName();
#if TARGET_IPHONE_SIMULATOR
      if (currentUser.length == 0)
      {
        NSArray *bundlePathComponents = [NSBundle.mainBundle.bundlePath pathComponents];
        
        if (bundlePathComponents.count >= 3
            && [bundlePathComponents[0] isEqualToString:@"/"]
            && [bundlePathComponents[1] isEqualToString:@"Users"])
        {
          currentUser = bundlePathComponents[2];
        }
      }
#endif
      
      NSString *filePath = [NSString stringWithFormat:@"/Users/%@/Desktop/%@-%@.plist",
                            currentUser,
                            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            self.dataFileName
                            ];;
      NSDictionary *interpolationsToSave = (interpolations.count> 0 ? @{scope : @{ key : interpolations } } : @{});
      NSDictionary *dictToWrite = [([NSDictionary dictionaryWithContentsOfFile:filePath] ?: @{})
                                   lk_dictionaryByMergingWith:@{
                                                                self.locale : self.translations,
                                                                [self.locale stringByAppendingString:@"-interpolations"] : interpolationsToSave
                                                                }];
      [dictToWrite
       writeToFile:filePath
       atomically:NO];
    }
    @catch (NSException *exception) {
      if (self.debugLevel==LKDebugLevelDevelopment || self.debugLevel==LKDebugLevelDebug)
        NSLog(@"%@", exception);
    }
  }
  if(self.debugLevel==LKDebugLevelDevelopment || self.debugLevel==LKDebugLevelDebug)
    NSLog(@"Translating... \nKEY: %@\nSCOPE: %@\nPARAMS: %@\nUNINTERPOLATED RESULT: %@\nRESULT: %@\n", key, scope, params, uninterpolatedResult, r);
  return r;
}

- (void)storeTranslation:(NSString *)translation forKey:(NSString *)key inScope:(NSString *)scope {
  if (self.data[scope]==nil)
    self.data[scope]= [NSMutableDictionary dictionaryWithCapacity:1];
  self.data[scope][key]= translation;
}

- (NSDictionary *)data {
  if(_data) return _data;
  _data = [self loadData];
  return _data;
}

- (NSMutableDictionary *)loadData {
  NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalizeKit"];
  if (data==nil) {
    [[NSUserDefaults standardUserDefaults]
     registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                  pathForResource:self.dataFileName
                                                                  ofType:@""]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalizeKit"];
  }
  return [data lk_deepMutableCopy];
}

- (NSMutableDictionary *)translations {
  if(_translations==nil) {
    _translations = self.data[@"Localisations"][self.locale];
  }
  return _translations;
}

@end
