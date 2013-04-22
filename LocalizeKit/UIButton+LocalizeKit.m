//
//  UIButtonLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIButton+LocalizeKit.h"
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@interface UIButton ()

@end

@implementation UIButton (LocalizeKit)

- (void)localizeInScope:(NSString *)scope {
  if(!self.isLocalizable) return;
  NSString *key = NOTNIL(self.i18nKey, [self titleForState:UIControlStateNormal]);
  [self setTitle:VL(key, NOTNIL(scope, self.i18nScope), @{@"default" : NOTNIL([self titleForState:UIControlStateNormal], key)})
        forState:UIControlStateNormal];
}

@end
