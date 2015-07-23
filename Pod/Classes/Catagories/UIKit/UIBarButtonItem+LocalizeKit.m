//
//  UIBarButtonItemLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIBarButtonItem+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIBarButtonItem (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  if(!self.lk_isLocalizable || self.lk_i18nKey==nil) return;
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": self.lk_i18nKey};
  self.title = LKLocalizedString(self.lk_i18nKey, scope, params);
}

- (NSString *)lk_i18nKey {
  if ([super lk_i18nKey]==nil && self.title) {
    [self setLk_i18nKey:self.title];
  }
  return [super lk_i18nKey];
}

@end
