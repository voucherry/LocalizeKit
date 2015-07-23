//
//  UISearchBar+LocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/22/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UISearchBar+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UISearchBar (LocalizeKit)


- (void)lk_localizeInScope:(NSString *)scope {
  if(self.placeholder==nil || self.placeholder.length==0 || !self.lk_isLocalizable || self.lk_i18nKey==nil) return;
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": self.lk_i18nKey};
  self.placeholder = LKLocalizedString(self.lk_i18nKey, scope, params);
}

- (NSString *)lk_i18nKey {
  if ([super lk_i18nKey]==nil && self.placeholder && self.placeholder.length>0) {
    [self setLk_i18nKey:self.placeholder];
  }
  return [super lk_i18nKey];
}


@end
