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
#define VL(...) [LocalizeKit translatea:@[__VA_ARGS__]]
#define VLCherries(count) [LocalizeKit translate:@"Cherry Coins" params:@{@"count" : count}]

#ifndef NOTNIL
#define NOTNIL(a,b) (a!=nil ? a : b)
#endif

#ifndef NOTNIL3
#define NOTNIL3(a,b,c) NOTNIL(NOTNIL(a,b),c)
#endif


#endif
