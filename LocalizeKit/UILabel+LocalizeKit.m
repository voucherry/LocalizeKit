//
//  UILabelLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UILabel+LocalizeKit.h"
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@implementation UILabel (LocalizeKit)

- (void)localizeInScope:(NSString *)scope {
  if(!self.isLocalizable) return;
  if (self.i18nKey!=nil && self.i18nKey.length>0)
    self.text = VL(self.i18nKey, NOTNIL(scope, self.i18nScope), @{@"default": NOTNIL(self.text, @"")});
  else if (self.text.length>0)
    self.text = VL(self.text, NOTNIL(scope, self.i18nScope));
}

@end
