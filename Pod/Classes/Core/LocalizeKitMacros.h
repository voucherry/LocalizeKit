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

#define LKLocalizedString(key, scope, params) \
[LocalizeKit translate:(key) scope:(scope) params:(params)]

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

//#ifndef NOTNIL
//#define NOTNIL(a,b) (a!=nil ? a : b)
//#endif
//
//#ifndef NOTNIL3
//#define NOTNIL3(a,b,c) NOTNIL(NOTNIL(a,b),c)
//#endif


#endif
