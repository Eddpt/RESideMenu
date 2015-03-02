//
//  UIViewController+Storyboard.h
//  RESideMenuStoryboardsExample
//
//  Created by Edgar Antunes on 02/03/2015.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Storyboard)

+ (instancetype)viewControllerForStoryBoardPath:(NSString *)storyboardPath;
+ (instancetype)viewControllerForNibName:(NSString *)nibName;

@end
