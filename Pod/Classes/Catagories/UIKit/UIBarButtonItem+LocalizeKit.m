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
  if(!self.lk_isLocalizable) return;
  if(self.lk_i18nKey==nil && self.title) self.lk_i18nKey = self.title;
  if (self.lk_i18nKey==nil) return;
  scope = (scope ?: self.lk_i18nScope);
  NSDictionary *params = @{@"default": self.lk_i18nKey};
  self.title = LKLocalizedString(self.lk_i18nKey, scope, params);
}

@end
