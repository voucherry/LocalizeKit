//
//  JSON.h
//  LocalizeKit
//
//  Created by Cristian Bica on 10/11/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (vJSON)

- (NSString *)JSONRepresentation;

@end

@interface NSArray (vJSON)

- (NSString *)JSONRepresentation;

@end

@interface NSString (vJSON)

- (id)JSONValue;

@end
