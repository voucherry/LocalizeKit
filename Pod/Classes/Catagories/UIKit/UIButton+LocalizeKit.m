//
//  UIButtonLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIButton+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@interface UIButton ()

@end

@implementation UIButton (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  if(!self.lk_isLocalizable || self.lk_i18nKey==nil) return;
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": self.lk_i18nKey};
  [self setTitle:LKLocalizedString(self.lk_i18nKey, scope, params) forState:UIControlStateNormal];
}

- (NSString *)lk_i18nKey {
  if ([super lk_i18nKey]==nil && [self titleForState:UIControlStateNormal]) {
    [self setLk_i18nKey:[self titleForState:UIControlStateNormal]];
  }
  return [super lk_i18nKey];
}

@end
