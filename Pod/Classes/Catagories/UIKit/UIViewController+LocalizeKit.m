//
//  UIViewControllerLocalizeKit.m
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "UIViewController+LocalizeKit.h"
#import "UIView+LocalizeKit.h"
#import "UINavigationItem+LocalizeKit.h"
#import "LocalizeKitMacros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIViewController (LocalizeKit)


- (NSString *)lk_i18nScope {
  NSString *val = [self.lk_associatedDictionary objectForKey:@"i18nScope"];
  if (val==nil)
    val = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
  return val;
}

- (void)lk_localize {
  if([self lk_isLocalizable]) {
    [self.view lk_localizeInScope:self.lk_i18nScope];
    if (self.navigationItem) [self.navigationItem lk_localizeInScope:self.lk_i18nScope];
  }
}
@end
