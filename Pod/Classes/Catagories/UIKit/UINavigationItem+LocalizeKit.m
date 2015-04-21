//
//  UINavigationItemLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UINavigationItem+LocalizeKit.h"
#import "UIBarButtonItem+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UINavigationItem (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  if(self.lk_isLocalizable && self.titleView==nil) {
    scope = (scope ?: self.lk_i18nScope);
    NSDictionary *params = @{@"default": (self.title?:@"")};
    self.title = LKLocalizedString(@"View Title", scope, params);
  }
  [self.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *btn, NSUInteger idx, BOOL *stop) {
    [btn lk_localizeInScope:scope];
  }];
  [self.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *btn, NSUInteger idx, BOOL *stop) {
    [btn lk_localizeInScope:scope];
  }];
}

@end
