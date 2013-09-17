//
//  LocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "LocalizeKit.h"
#import "Singleton.h"
#import "RegexKitLite.h"
#import "JSONKit.h"
#import "NSDictionary+DeepMutableCopy.h"
#import "NSArray+DeepMutableCopy.h"
#import "LocalizeKitMacros.h"
#import "NSDictionary+Merge.h"

NSString * const LocalizeKitShouldReloadDataNotification = @"LocalizeKitShouldReloadDataNotification";

@interface LocalizeKit ()

- (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params;
- (void)storeTranslation:(NSString *)translation forKey:(NSString *)key inScope:(NSString *)scope;
- (NSMutableDictionary *)loadLocales;

@end

@implementation LocalizeKit
SINGLETON(LocalizeKit)

+(void)setup:(void (^)(LocalizeKitConfig *config))block {
  block([LocalizeKitConfig instance]);
  [[self instance] setData:nil];
  [[self instance] data];
  static dispatch_once_t pred;
  dispatch_once( &pred, ^{
    [[NSNotificationCenter defaultCenter] addObserverForName:LocalizeKitShouldReloadDataNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                    [[self instance] setData:nil];
                                                  }];
  });
}

+ (NSString *)translate:(NSString *)key {
  return [[self instance] translate:key scope:nil params:nil];
}

+ (NSString *)translate:(NSString *)key scope:(NSString *)scope {
  return [[self instance] translate:key scope:scope params:nil];
}

+ (NSString *)translate:(NSString *)key params:(NSDictionary *)params {
  return [[self instance] translate:key scope:nil params:params];
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

- (LocalizeKitConfig *)config {
  return [LocalizeKitConfig instance];
}

- (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params {
  if (scope==nil) scope = @"General";
  if (params==nil) params = @{};
  NSMutableString *r = [NSMutableString stringWithCapacity:100];
  if (self.data[scope]!=nil && self.data[scope][key]!=nil) {
    [r appendString:self.data[scope][key]];
  } else {
    [r appendString:NOTNIL(params[@"default"], key)];
    if (self.config.devMode) {
      [self storeTranslation:[r copy] forKey:key inScope:scope];
    }
  }
  
  NSString *uninterpolatedResult = [NSString stringWithString:r];
  
  //replace cldr interpolations
  //ex: pluralization %<{"count": { "zero": "Nada", "one": "One Cherry Coin", "other": "%{count} Cherry Coins" } }>
  [r replaceOccurrencesOfRegex:@"%<(.*?)>"
                    usingBlock:^NSString *(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                      if (captureCount==2) {
                        //process the interpolation data
                        NSDictionary *dict = [capturedStrings[1] objectFromJSONString];
                        NSString *pluralKey = [[dict allKeys] objectAtIndex:0];
                        NSDictionary *pluralData = dict[pluralKey];
                        
                        //return the string if the translation params doesn't include the plural key
                        if (params[pluralKey]==nil)
                          return capturedStrings[0];
                        
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
                    }];

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
  
  if (self.config.devMode) {
    @try {
      NSMutableDictionary *interpolations = [NSMutableDictionary dictionaryWithDictionary:params];
      [interpolations removeObjectForKey:@"default"];
      NSString *filePath = self.config.devWritesToFile;
      NSDictionary *interpolationsToSave = (interpolations.count> 0 ? @{scope : @{ key : interpolations } } : @{});
      [[NOTNIL([NSDictionary dictionaryWithContentsOfFile:filePath], @{})
        dictionaryByMergingWith:@{
        self.usedLocaleIdentifier : self.data,
        [self.usedLocaleIdentifier stringByAppendingString:@"-interpolations"] : interpolationsToSave
        }]
       writeToFile:filePath
       atomically:NO];
    }
    @catch (NSException *exception) {
      if (self.config.debug)
        NSLog(@"%@", exception);
    }

    if(self.config.debug)
      NSLog(@"Translating... \nKEY: %@\nSCOPE: %@\nPARAMS: %@\nUNINTERPOLATED RESULT: %@\nRESULT: %@\n", key, scope, params, uninterpolatedResult, r);
  }
  return r;
}

- (NSDictionary *)data {
  if(_data) return _data;
  _data = [self loadLocales];
  return _data;
}

- (void)storeTranslation:(NSString *)translation forKey:(NSString *)key inScope:(NSString *)scope {
  if (self.data[scope]==nil)
    self.data[scope]= [NSMutableDictionary dictionaryWithCapacity:1];
  self.data[scope][key]= translation;
}

- (NSMutableDictionary *)loadLocales {
  NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"localize-kit"];
  NSString *currentLocale = [[NSLocale currentLocale] localeIdentifier];
  if (data==nil) { //TODO: or DEV model
    [[NSUserDefaults standardUserDefaults]
     registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                  pathForResource:self.config.dataFileName
                                                                  ofType:@"plist"]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"localize-kit"];
  }
  if (data[currentLocale]!=nil) {
    self.usedLocaleIdentifier = currentLocale;
    return [(NSDictionary *)data[currentLocale] deepMutableCopy];
  }
  if (data[@"Aliases"][currentLocale]!=nil && data[data[@"Aliases"][currentLocale]]!=nil) {
    self.usedLocaleIdentifier = data[@"Aliases"][currentLocale];
    return [(NSDictionary *)data[data[@"Aliases"][currentLocale]] deepMutableCopy];
  }
  self.usedLocaleIdentifier = data[@"Default"];
  return [(NSDictionary *)data[data[@"Default"]] deepMutableCopy];
}

@end
