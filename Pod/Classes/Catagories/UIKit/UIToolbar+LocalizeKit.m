//
//  UIToolbar+LocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/24/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIToolbar+LocalizeKit.h"
#import "UIView+LocalizeKit.h"
#import "UIBarButtonItem+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIToolbar (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
    [subview lk_localizeInScope:(scope ?: self.lk_i18nScope)];
  }];
  [self.items enumerateObjectsUsingBlock:^(UIBarButtonItem *item, NSUInteger idx, BOOL *stop) {
    [item lk_localizeInScope:(scope ?: self.lk_i18nScope)];
  }];
}

@end
