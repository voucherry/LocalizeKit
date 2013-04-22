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
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIToolbar (LocalizeKit)

- (void)localizeInScope:(NSString *)scope {
  //NSLog(@"Localizing view: %@", self);
  [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
    //NSLog(@"Localizing subview: %@", subview);
    [subview localizeInScope:NOTNIL(scope, self.i18nScope)];
  }];

  [self.items enumerateObjectsUsingBlock:^(UIBarButtonItem *item, NSUInteger idx, BOOL *stop) {
    [item localizeInScope:NOTNIL(scope, self.i18nScope)];
  }];
}

@end
