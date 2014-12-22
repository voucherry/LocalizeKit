//
//  JSON.m
//  LocalizeKit
//
//  Created by Cristian Bica on 10/11/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "JSON.h"

@implementation NSDictionary (vJSON)

- (NSString *)JSONRepresentation
{
  return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self
                                                                        options:0
                                                                          error:NULL]
                               encoding:NSUTF8StringEncoding];
}

@end

@implementation NSArray (vJSON)

- (NSString *)JSONRepresentation {
  return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self
                                                                        options:0
                                                                          error:NULL]
                               encoding:NSUTF8StringEncoding];
}

@end



@implementation NSString (vJSON)

- (id)JSONValue
{
  return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                         options:0
                                           error:NULL];
}

@end
