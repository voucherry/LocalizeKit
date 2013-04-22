//
//  NSObjectLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "NSObject+LocalizeKit.h"
#import "NSObject+AssociatedDictionary.h"
#import "Macros.h"

@implementation NSObject (LocalizeKit)

- (NSNumber *)i18n {
  NSNumber *val = [self.associatedDictionary objectForKey:@"i18n"];
  if (val==nil) {
    val = @(NO);
    [self setI18n:val];
  }
  return val;
}

- (void)setI18n:(NSNumber *)i18n {
  [self.associatedDictionary setObject:i18n forKey:@"i18n"];
}

- (NSString *)i18nKey {
  return [self.associatedDictionary objectForKey:@"i18nKey"];
}

- (void)setI18nKey:(NSString *)i18nKey {
  return [self.associatedDictionary setObject:i18nKey forKey:@"i18nKey"];
}

- (NSString *)i18nScope {
  NSString *val = [self.associatedDictionary objectForKey:@"i18nScope"];
  if (val==nil) val = @"General";
  return val;
}

- (void)setI18nScope:(NSString *)i18nScope {
  return [self.associatedDictionary setObject:i18nScope forKey:@"i18nScope"];
}

- (BOOL)isLocalizable {
  return self.i18n.boolValue;
}


- (NSString *)translate:(NSString *)what {
  return [self translate:what params:@{}];
}

- (NSString *)translate:(NSString *)what params:(NSDictionary *)params {
  return VL(what, self.i18nScope, params);
}



@end
