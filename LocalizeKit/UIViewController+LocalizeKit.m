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
#import "NSObject+AssociatedDictionary.h"
#import "Macros.h"
#import "NSObject+LocalizeKit.h"

@implementation UIViewController (LocalizeKit)


- (NSString *)i18nScope {
  NSString *val = [self.associatedDictionary objectForKey:@"i18nScope"];
  if (val==nil)
    val = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
  return val;
}

- (void)localize {
  if([self isLocalizable]) {
    [self.view localizeInScope:self.i18nScope];
    if (self.navigationItem) [self.navigationItem localizeInScope:self.i18nScope];
  }
}
@end
