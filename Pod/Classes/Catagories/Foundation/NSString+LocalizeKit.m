//
//  NSString+LocalizeKit.m
//  Pods
//
//  Created by Cristian Bica on 20/04/15.
//
//

#import "NSString+LocalizeKit.h"

@implementation NSString (LocalizeKit)

- (id)lk_JSONValue {
  return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                         options:0
                                           error:NULL];
}

@end
