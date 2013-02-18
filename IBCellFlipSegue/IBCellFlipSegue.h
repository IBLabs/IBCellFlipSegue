//
//  IBCellFlipSegue.h
//  CellFlip
//
//  Created by Itamar Biton on 1/25/13.
//  Copyright (c) 2013 IBlabs. All rights reserved.
//
//  Copyright 2013 Itamar Biton
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
