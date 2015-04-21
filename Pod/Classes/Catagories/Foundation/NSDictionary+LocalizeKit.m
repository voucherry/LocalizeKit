//
//  NSDictionary+LocalizeKit.m
//  Pods
//
//  Created by Cristian Bica on 20/04/15.
//
//

#import "NSDictionary+LocalizeKit.h"

@implementation NSDictionary (LocalizeKit)

- (NSMutableDictionary *)lk_deepMutableCopy {
  return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
}

+ (NSDictionary *)lk_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dict1];
  [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
    if (dict1[key]==nil) {
      result[key] = obj;
    } else {
      if ([dict1[key] isKindOfClass:[NSDictionary class]] && [obj isKindOfClass:[NSDictionary class]]) {
        result[key] = [NSDictionary lk_dictionaryByMerging:dict1[key] with:obj];
      } else {
        result[key] = obj;
      }
    }
  }];
  return (NSDictionary *)result;
}

- (NSDictionary *)lk_dictionaryByMergingWith:(NSDictionary *)dict {
  return [[self class] lk_dictionaryByMerging:self with:dict];
}

@end
