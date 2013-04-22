//
//  NSObject+LocalizeKit.h
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LocalizeKit)

@property (nonatomic, weak) NSNumber *i18n;
@property (nonatomic, weak) NSString *i18nKey;
@property (nonatomic, weak) NSString *i18nScope;

- (BOOL)isLocalizable;
- (NSString *)translate:(NSString *)what;
- (NSString *)translate:(NSString *)what params:(NSDictionary *)params;

@end
