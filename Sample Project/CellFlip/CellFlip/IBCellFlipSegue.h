//
//  IBCellFlipSegue.h
//  CellFlip
//
//  Created by Itamar Biton on 1/25/13.
//  Copyright (c) 2013 IBlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface IBCellFlipSegue : UIStoryboardSegue

@property (strong, nonatomic) UITableViewCell *selectedCell;
@property (strong, nonatomic) CALayer *cellAnimatedLayer;
@property (strong, nonatomic) CALayer *destAnimatiedLayer;

- (UIWindow *)sourceViewWindow;
- (UIViewController *)destinationViewController;
- (UIViewController *)sourceViewController;
- (CALayer *)destinationLayer;
- (CALayer *)sourceLayer;
- (CALayer *)selectedCellLayer;
- (BOOL)isStatusBarVisible;
- (BOOL)isInNavigationController;

@end
