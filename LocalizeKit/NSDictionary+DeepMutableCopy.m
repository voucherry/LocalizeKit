//
//  NSDictionary+DeepMutableCopy.m
//  LocalizeKit
//
//  Created by Cristian Bica on 4/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "NSDictionary+DeepMutableCopy.h"

@implementation NSDictionary (DeepMutableCopy)


- (NSMutableDictionary *)deepMutableCopy {
	return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
}

@end
