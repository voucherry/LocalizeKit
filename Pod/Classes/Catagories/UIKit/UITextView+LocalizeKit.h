//
//  UITextView+LocalizeKit.h
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LocalizeKit)

- (void)lk_localizeInScope:(NSString *)scope;

@end
