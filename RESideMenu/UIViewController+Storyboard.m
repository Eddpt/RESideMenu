//
//  UIViewController+Storyboard.m
//  RESideMenuStoryboardsExample
//
//  Created by Edgar Antunes on 02/03/2015.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

/**
 *  Syntax is 'storyboard_name[:ViewController_name]'. eg 'Authentication', 'Authentication:Terms'
 *
 *  @param storyboardPath A string with the path for the storyboard+view controller
 *
 *  @return an instance of a UIViewController, if available; nil, otherwise.
 */
+ (instancetype)viewControllerForStoryBoardPath:(NSString *)storyboardPath
{
  storyboardPath = [storyboardPath stringByReplacingOccurrencesOfString:@":" withString:@"/"];
  
  NSArray *components = storyboardPath.pathComponents;
  NSString *storyboardName = components[0];
  NSString *viewControllerName = (components.count == 2) ? components[1] : nil;
  
  UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
  return (viewControllerName ? [sb instantiateViewControllerWithIdentifier:viewControllerName] : [sb instantiateInitialViewController]);
}

+ (instancetype)viewControllerForNibName:(NSString *)nibName
{
  return [[UIViewController alloc] initWithNibName:nibName bundle:nil];
}

@end
