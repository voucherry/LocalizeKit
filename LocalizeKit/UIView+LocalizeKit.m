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

- (void)localizeInScope:(NSString *)scope {
  //NSLog(@"Localizing view: %@", self);
  [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
    //NSLog(@"Localizing subview: %@", subview);
    [subview localizeInScope:NOTNIL(scope, self.i18nScope)];
  }];
}

@end
