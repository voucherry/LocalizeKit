//
//  UILabelLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UILabel+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UILabel (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  if(!self.lk_isLocalizable) return;
  NSString *key = (self.lk_i18nKey ?: self.text);
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": (self.text?:@"")};
  self.text = LKLocalizedString(key, scope, params);
}

@end
