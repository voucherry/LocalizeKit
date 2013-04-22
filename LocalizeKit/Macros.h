//
//  Macros.h
//  LocalizeKit
//
//  Created by Cristian Bica on 4/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#include "I18n.h"

#ifndef LocalizeKit_Macros_h
#define LocalizeKit_Macros_h

/*
 VL(key[, scope][, params_dictionary])
 */
#define VL(...) [I18n translatea:@[__VA_ARGS__]]
#define VLCherries(count) [I18n translate:@"Cherry Coins" params:@{@"count" : count}]

#ifndef NONIL
#define NOTNIL(a,b) (a!=nil ? a : b)
#endif

#ifndef NONIL3
#define NOTNIL3(a,b,c) NOTNIL(NOTNIL(a,b),c)
#endif


#endif
