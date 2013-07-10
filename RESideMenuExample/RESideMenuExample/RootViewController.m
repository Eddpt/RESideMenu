//
//  RootViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 6/26/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "DemoViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController{
    NSMutableArray * addedItems;
    NSMutableArray * menuItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    addedItems = [NSMutableArray array];
    menuItems = [NSMutableArray array];
    [self initMenus];
    
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

-(void)swipeHandler:(UIPanGestureRecognizer *)sender
{    
    [_sideMenu showFromPanGesture:sender];
}


- (void) initMenus
{
    
    // Simple menus
    RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"Home" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        
        DemoViewController *viewController = [[DemoViewController alloc] init];
        viewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [menu setRootViewController:navigationController];
    }];
    RESideMenuItem *exploreItem = [[RESideMenuItem alloc] initWithTitle:@"Explore" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        
        SecondViewController *secondViewController = [[SecondViewController alloc] init];
        secondViewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        [menu setRootViewController:navigationController];
    }];
    
    // Dynamic addable menus
    RESideMenuItem *addNewItem = [[RESideMenuItem alloc] initFieldWithPlaceholder:@"+ Add menu" doneAction:^(RESideMenu *menu, RESideMenuItem *item) {
        
        __block RESideMenuItem *addedItem = [[RESideMenuItem alloc] initWithTitle:menu.lastFieldInput image:[UIImage imageNamed:@"minus"] highlightedImage:nil imageAction:^(RESideMenu *menu, RESideMenuItem *item) {
            
            NSMutableArray * items = menu.items.mutableCopy;
            [items removeObject:addedItem];
            [addedItems removeObject:addedItem];
            [menu reloadWithItems:items];
            
        } action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"Item %@", item);
            [menu hide];
        }];
        
        NSMutableArray * items = menu.items.mutableCopy;
        [items insertObject:addedItem atIndex:2];
        [addedItems addObject:addedItem];
        [menu reloadWithItems:items];
        
    }];
    
    
    RESideMenuItem *itemWithSubItems = [[RESideMenuItem alloc] initWithTitle:@"Others+" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
    }];
    NSMutableArray * otherItems = addedItems;
    [otherItems insertObject:addNewItem atIndex:0];
    itemWithSubItems.subItems = otherItems;
    
    
    // Simple menu with alert
    RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:@"Log out" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to log out?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log Out", nil];
        [alertView show];
    }];
    
    [menuItems addObjectsFromArray:@[homeItem, exploreItem,itemWithSubItems, logOutItem]];
    
    _sideMenu = [[RESideMenu alloc] initWithItems:menuItems];
    _sideMenu.horizontalOffset = 40;
    _sideMenu.itemHeight = 40;
    _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
    _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
}

#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    [_sideMenu show];
}

@end
