//
//  LKViewController.h
//  LocalizeKit
//
//  Created by Cristian Bica on 04/20/2015.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *topNaviItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *topLeftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *topRightButton;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UILabel *aLabelWithKey;
@property (weak, nonatomic) IBOutlet UILabel *aNestedLabel;
@property (weak, nonatomic) IBOutlet UIButton *aNestedButton;
@property (weak, nonatomic) IBOutlet UITextField *aTextField;
@property (weak, nonatomic) IBOutlet UILabel *unlocalisableLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftToolbarButton;
@property (weak, nonatomic) IBOutlet UIButton *centerToolbarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightToolbarButton;

@end
