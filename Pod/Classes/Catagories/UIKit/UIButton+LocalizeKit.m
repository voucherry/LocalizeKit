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
  if(!self.lk_isLocalizable) return;
  NSString *key = (self.lk_i18nKey ?: [self titleForState:UIControlStateNormal]);
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": ([self titleForState:UIControlStateNormal]?:@"")};
  [self setTitle:LKLocalizedString(key, scope, params) forState:UIControlStateNormal];
}

@end
