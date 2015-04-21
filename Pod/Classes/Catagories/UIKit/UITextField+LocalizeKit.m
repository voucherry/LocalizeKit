//
//  UITextFieldLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UITextField+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UITextField (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  if(!self.lk_isLocalizable) return;
  if (self.placeholder!=nil && self.placeholder.length>0) {
    NSString *key = (self.lk_i18nKey ?: self.placeholder);
    scope = (scope ?: self.lk_i18nScope);
    NSDictionary *params = @{@"default" : self.placeholder};
    self.placeholder = LKLocalizedString(key, scope, params);
  }
}


@end