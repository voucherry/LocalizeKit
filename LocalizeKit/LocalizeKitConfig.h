//
//  LocalizeKitConfig.h
//  LocalizeKit
//
//  Created by Cristian Bica on 5/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizeKitConfig : NSObject

@property (nonatomic, strong) NSString * dataFileName;
@property (nonatomic) BOOL devMode;
@property (nonatomic) BOOL debug;
@property (nonatomic, strong) NSString * devWritesToFile;

+ (LocalizeKitConfig *)instance;

@end
