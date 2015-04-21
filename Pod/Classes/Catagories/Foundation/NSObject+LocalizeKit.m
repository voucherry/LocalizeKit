//
//  NSObjectLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "NSObject+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import <objc/runtime.h>

static char const * const LocalizeKitAssociatedDictionaryKey = "LocalizeKitAssociatedDictionaryKey";

@implementation NSObject (LocalizeKit)

-(NSMutableDictionary *)lk_associatedDictionary {
  NSMutableDictionary *dict = objc_getAssociatedObject(self, LocalizeKitAssociatedDictionaryKey);
  if (!dict) {
    dict = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, LocalizeKitAssociatedDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return dict;
}


- (BOOL)lk_i18n {
  NSNumber *val = [self.lk_associatedDictionary objectForKey:@"i18n"];
  if (val==nil) {
    val = @(NO);
    [self setLk_i18n:val];
  }
  return val.boolValue;
}

- (void)setLk_i18n:(BOOL)i18n {
  [self.lk_associatedDictionary setObject:@(i18n) forKey:@"i18n"];
}

- (NSString *)lk_i18nKey {
  return [self.lk_associatedDictionary objectForKey:@"i18nKey"];
}

- (void)setLk_i18nKey:(NSString *)i18nKey {
  return [self.lk_associatedDictionary setObject:i18nKey forKey:@"i18nKey"];
}

- (NSString *)lk_i18nScope {
  NSString *val = [self.lk_associatedDictionary objectForKey:@"i18nScope"];
  if (val==nil) val = @"General";
  return val;
}

- (void)setLk_i18nScope:(NSString *)i18nScope {
  return [self.lk_associatedDictionary setObject:i18nScope forKey:@"i18nScope"];
}

- (BOOL)lk_isLocalizable {
  return self.lk_i18n;
}


- (NSString *)lk_translate:(NSString *)what {
  return [self lk_translate:what params:@{}];
}

- (NSString *)lk_translate:(NSString *)what params:(NSDictionary *)params {
  return [LocalizeKit translate:what scope:self.lk_i18nScope params:params];
}



@end
