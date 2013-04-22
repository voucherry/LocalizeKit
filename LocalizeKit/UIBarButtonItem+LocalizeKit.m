//
//  UIBarButtonItemLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIBarButtonItem+LocalizeKit.h"
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIBarButtonItem (LocalizeKit)

- (void)localizeInScope:(NSString *)scope {
  if(!self.isLocalizable) return;
  self.title = VL(NOTNIL(self.i18nKey, self.title), NOTNIL(scope, self.i18nScope), @{@"default": self.title});
}

@end
