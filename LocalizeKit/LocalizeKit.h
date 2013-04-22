//
//  LocalizeKit.h
//  LocalizeKit
//
//  Created by Cristian Bica on 4/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//


#ifndef LOCALIZE_KIT_DEBUG
#ifdef TARGET_IPHONE_SIMULATOR
#define LOCALIZE_KIT_DEBUG YES
#else
#define LOCALIZE_KIT_DEBUG NO
#endif

#ifndef LOCALIZE_KIT_DEVMODE
#define LOCALIZE_KIT_DEVMODE NO
#endif

#define LOCALIZE_KIT_VERSION @"0.5.0"

#import <Foundation/Foundation.h>
#import "Macros.h"
#import "I18n.h"
#import "NSObject+LocalizeKit.h"
#import "UIBarButtonItem+LocalizeKit.h"
#import "UIButton+LocalizeKit.h"
#import "UILabel+LocalizeKit.h"
#import "UINavigationBar+LocalizeKit.h"
#import "UINavigationItem+LocalizeKit.h"
#import "UISearchBar+LocalizeKit.h"
#import "UITextField+LocalizeKit.h"
#import "UITextView+LocalizeKit.h"
#import "UIToolbar+LocalizeKit.h"
#import "UIView+LocalizeKit.h"
#import "UIViewController+LocalizeKit.h"
