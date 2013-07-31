//
//  LocalizeKitConfig.m
//  LocalizeKit
//
//  Created by Cristian Bica on 5/20/13.
//  Copyright (c) 2013 Voucherry LLC. All rights reserved.
//

#import "LocalizeKitConfig.h"
#import "Singleton.h"

@implementation LocalizeKitConfig
SINGLETON(LocalizeKitConfig)

- (id)init {
  self = [super init];
  if (self) {
    self.devMode = NO;
    self.debug = NO;
    self.dataFileName = @"LocalizeKit";
  }
  return self;
}

- (void)setDataFileName:(NSString *)dataFileName {
  _dataFileName = [dataFileName stringByReplacingOccurrencesOfString:@".plist" withString:@""];
}

@end
