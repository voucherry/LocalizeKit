//
//  Macros.h
//  LocalizeKit
//
//  Created by Cristian Bica on 4/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#include "LocalizeKit.h"

#ifndef LocalizeKit_Macros_h
#define LocalizeKit_Macros_h

/*
 VL(key[, scope][, params_dictionary])
 */

#define LKLocalizedString(k, s, p) \
[LocalizeKit translate:(k) scope:(s) params:(p)]

#define LKL(...) [LocalizeKit translatea:@[__VA_ARGS__]]

#ifndef LKSINGLETON
#define LKSINGLETON(classname)                          \
+(classname *)instance {                                \
static dispatch_once_t pred;                            \
__strong static classname * shared##classname = nil;    \
dispatch_once( &pred, ^{                                \
shared##classname = [[self alloc] init]; });            \
return shared##classname;                               \
}
#endif


#endif
