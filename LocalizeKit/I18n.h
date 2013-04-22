//
//  i18n.h
//  LocalizeKit
//
//  Created by Cristian Bica on 2/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface I18n : NSObject

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSString *usedLocaleIdentifier;

+ (void)setup;

+ (NSString *)translate:(NSString *)key;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope;
+ (NSString *)translate:(NSString *)key scope:(NSString *)scope params:(NSDictionary *)params;
+ (NSString *)translate:(NSString *)key params:(NSDictionary *)params;
+ (NSString *)translatea:(NSArray *)arguments;

@end


