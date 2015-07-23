//
//  LocalizeKitTests.m
//  LocalizeKitTests
//
//  Created by Cristian Bica on 04/20/2015.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

#import <LocalizeKit/LocalizeKit.h>
#import "LKViewController.h"

SpecBegin(InitialSpecs)

beforeAll(^{
  [LocalizeKit config:^(LocalizeKit *lk) {
    lk.debugLevel = LKDebugLevelDebug;
    lk.dataFileName = @"AppData.plist";
    lk.locale = @"en";
  }];
});

describe(@"setting locale", ^{
  it(@"return the correct locale", ^{
    [LocalizeKit instance].locale = @"en_US";
    expect([LocalizeKit instance].locale).to.equal(@"en_US");
  });

  it(@"sets the current locale using aliases 1", ^{
    [LocalizeKit instance].locale = @"en";
    expect([LocalizeKit instance].locale).to.equal(@"en_US");
  });

  it(@"sets the current locale using aliases 2", ^{
    [LocalizeKit instance].locale = @"en_GB";
    expect([LocalizeKit instance].locale).to.equal(@"en_US");
  });
});

describe(@"manual translations", ^{
  it(@"should translate in general scope", ^{
    expect([LocalizeKit translate:@"String"]).to.equal(@"Lorem");
  });

  it(@"should translate in specific scope", ^{
    expect([LocalizeKit translate:@"String1" scope:@"Scope1"]).to.equal(@"Lorem ipsum");
  });

  it(@"should translate in specific scope with params", ^{
    expect([LocalizeKit translate:@"String2" scope:@"Scope1" params:@{@"word" : @"lorem"}]).to.equal(@"Lorem ipsum lorem");
  });

  it(@"should translate in specific scope with pluralizations zero", ^{
    expect([LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(0)}]).to.equal(@"Lorem no ipsum");
  });

  it(@"should translate in specific scope with pluralizations one", ^{
    expect([LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(1)}]).to.equal(@"Lorem one ipsum");
  });

  it(@"should translate in specific scope with pluralizations other", ^{
    expect([LocalizeKit translate:@"String3" scope:@"Scope2" params:@{@"ipsums_count" : @(5)}]).to.equal(@"Lorem 5 ipsums");
  });
});

describe(@"View Controllers", ^{
  __block UINavigationController *navi;
  __block LKViewController *vc;
  
  beforeAll(^{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    navi = [mainStoryboard instantiateInitialViewController];
    vc = (LKViewController *)[navi topViewController];
    [vc lk_localize];
  });
  
  it(@"should have a view", ^{
    UIView *view = vc.view;
    expect(view).toNot.beNil();
  });

  it(@"should not translate unlocalizable elements", ^{
    expect(vc.unlocalisableLabel.text).toNot.equal(@"Unlocalisable String");
    expect(vc.unlocalisableLabel.text).to.equal(@"Do not localize this");
  });
  
  it(@"should translate labels", ^{
    expect(vc.aLabel.text).to.equal(@"A Localised Label");
  });
  
  it(@"should translate button", ^{
    expect([vc.aButton titleForState:UIControlStateNormal]).to.equal(@"A Localised Button");
  });

  it(@"should translate labels with custom key", ^{
    expect(vc.aLabelWithKey.text).to.equal(@"A Localised Label With Key");
  });

  it(@"should translate nested labels", ^{
    expect(vc.aNestedLabel.text).to.equal(@"A Localised label in nested view");
  });

  it(@"should translate nested button", ^{
    expect([vc.aNestedButton titleForState:UIControlStateNormal]).to.equal(@"A Localised button in nested view");
  });

  it(@"should translate textfields", ^{
    expect(vc.aTextField.placeholder).to.equal(@"A Localised placeholder");
  });

  it(@"should translate navigation left buttons", ^{
    expect(vc.topLeftButton.title).to.equal(@"Localised Left Button");
  });

  it(@"should translate navigation right buttons", ^{
    expect(vc.topRightButton.title).to.equal(@"Localised Right Button");
  });
  
  it(@"should translate navigation title", ^{
    expect(vc.topNaviItem.title).to.equal(@"Localised Title");
  });

  it(@"should translate toolbar buttons #1", ^{
    expect(vc.leftToolbarButton.title).to.equal(@"Localised Left toolbar button");
  });

  it(@"should translate toolbar buttons #2", ^{
    expect(vc.rightToolbarButton.title).to.equal(@"Localised Right toolbar button");
  });

  it(@"should translate toolbar subviews", ^{
    expect([vc.centerToolbarButton titleForState:UIControlStateNormal]).to.equal(@"Localised Center toolbar button");
  });
  
  it(@"shoud return the same result even if runned multiple times", ^{
    expect(vc.anotherLabel.text).to.equal(@"ChainLink2");
    [vc lk_localize];
    expect(vc.anotherLabel.text).to.equal(@"ChainLink2");
  });

});


SpecEnd
