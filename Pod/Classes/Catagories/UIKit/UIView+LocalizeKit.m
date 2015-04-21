//
//  UIViewLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIView+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIView (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
    [subview lk_localizeInScope:(scope ?: self.lk_i18nScope)];
  }];
}

@end
