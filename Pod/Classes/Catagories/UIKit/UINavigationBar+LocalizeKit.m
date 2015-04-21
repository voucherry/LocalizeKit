//
//  UINavigationBar+LocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/27/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UINavigationBar+LocalizeKit.h"
#import "NSObject+LocalizeKit.h"
#import "UINavigationItem+LocalizeKit.h"
#import "LocalizeKitMacros.h"

@implementation UINavigationBar (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope {
  [self.items enumerateObjectsUsingBlock:^(UINavigationItem *subview, NSUInteger idx, BOOL *stop) {
    [subview lk_localizeInScope:(scope ?: self.lk_i18nScope)];
  }];

}
@end
