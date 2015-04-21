//
//  NSArray+LocalizeKit.m
//  Pods
//
//  Created by Cristian Bica on 20/04/15.
//
//

#import "NSArray+LocalizeKit.h"

@implementation NSArray (LocalizeKit)

- (NSMutableArray *)lk_deepMutableCopy {
  return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}

@end
