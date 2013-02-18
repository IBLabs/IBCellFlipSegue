//
//  IBCellFlipSegue.h
//  CellFlip
//
//  Created by Itamar Biton on 1/25/13.
//  Copyright (c) 2013 IBlabs. All rights reserved.
//

typedef enum {
    FlipDirectionForward = 1,
    FlipDirectionBackwards = -1
} FlipDirection;

typedef enum {
    FlipTypeFlip,
    FlipTypeUnflip
} FlipType;

typedef enum {
    FlipAxisHorizontal,
    FlipAxisVertical,
    FlipAxisDiagonal
} FlipAxis;

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface IBCellFlipSegue : UIStoryboardSegue

@property (strong, nonatomic) UITableViewCell *selectedCell;
@property (strong, nonatomic) CALayer *cellAnimatedLayer;
@property (strong, nonatomic) CALayer *destAnimatiedLayer;
@property (assign, nonatomic) FlipAxis flipAxis;

- (UIWindow *)sourceViewWindow;
- (UIViewController *)destinationViewController;
- (UIViewController *)sourceViewController;
- (CALayer *)destinationLayer;
- (CALayer *)sourceLayer;
- (CALayer *)selectedCellLayer;
- (BOOL)isStatusBarVisible;
- (BOOL)isInNavigationController;

@end
