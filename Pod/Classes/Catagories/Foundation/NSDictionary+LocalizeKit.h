//
//  NSDictionary+LocalizeKit.h
//  Pods
//
//  Created by Cristian Bica on 20/04/15.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LocalizeKit)

- (NSMutableDictionary *)lk_deepMutableCopy;
+ (NSDictionary *)lk_dictionaryByMerging: (NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSDictionary *)lk_dictionaryByMergingWith: (NSDictionary *)dict;

@end
