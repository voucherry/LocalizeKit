//
//  Singleton.h
//  LocalizeKit
//
//  Created by Cristian Bica on 8/2/12.
//  Copyright (c) 2012 Voucherry LLC. All rights reserved.
//


#ifndef SINGLETON
#define SINGLETON(classname)                            \
+(classname *)instance {                                \
  static dispatch_once_t pred;                          \
  __strong static classname * shared##classname = nil;  \
  dispatch_once( &pred, ^{                              \
    shared##classname = [[self alloc] init]; });        \
  return shared##classname;                             \
}
#endif
