//
//  NSObject+LocalizeKit.h
//  LocalizeKit
//
//  Created by Cristian Bica on 2/21/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

IB_DESIGNABLE
@interface NSObject (LocalizeKit)

@property (nonatomic, readonly) NSMutableDictionary *lk_associatedDictionary;
@property (nonatomic) IBInspectable BOOL lk_i18n;
@property (nonatomic, weak) IBInspectable NSString *lk_i18nKey;
@property (nonatomic, weak) IBInspectable NSString *lk_i18nScope;

- (BOOL)lk_isLocalizable;
- (NSString *)lk_translate:(NSString *)what;
- (NSString *)lk_translate:(NSString *)what params:(NSDictionary *)params;

@end
