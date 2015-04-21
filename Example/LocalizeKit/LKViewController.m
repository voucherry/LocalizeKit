//
//  LKViewController.m
//  LocalizeKit
//
//  Created by Cristian Bica on 04/20/2015.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

#import "LKViewController.h"
#import <LocalizeKit/LocalizeKit.h>

@interface LKViewController ()

@end

@implementation LKViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self lk_localize];
  [LocalizeKit translate:@"String"];
  [LocalizeKit translate:@"String1" scope:@"Scope1"];
  [LocalizeKit translate:@"String2" scope:@"Scope1" params:@{@"word" : @"lorem"}];
  [LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(0)}];
  [LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(1)}];
  [LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(5)}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
