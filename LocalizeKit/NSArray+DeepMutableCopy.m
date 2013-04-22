//
//  NSArray+DeepMutableCopy.m
//  LocalizeKit
//
//  Created by Cristian Bica on 4/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "NSArray+DeepMutableCopy.h"

@implementation NSArray (DeepMutableCopy)

- (NSMutableArray *)deepMutableCopy {
	return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}

@end
