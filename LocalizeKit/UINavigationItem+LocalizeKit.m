//
//  UINavigationItemLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UINavigationItem+LocalizeKit.h"
#import "UIBarButtonItem+LocalizeKit.h"
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@implementation UINavigationItem (LocalizeKit)

- (void)localizeInScope:(NSString *)scope {
  if(self.isLocalizable)
    self.title = VL(@"Page Title", NOTNIL(scope, self.i18nScope), @{@"default": NOTNIL(self.title, @"")});
  [self.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *btn, NSUInteger idx, BOOL *stop) {
    [btn localizeInScope:scope];
  }];
  [self.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *btn, NSUInteger idx, BOOL *stop) {
    [btn localizeInScope:scope];
  }];
}

@end
