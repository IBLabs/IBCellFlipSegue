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

#define kTransitionDuration     0.5

#import "IBCellFlipSegue.h"

@implementation IBCellFlipSegue

- (void)perform
{
    // Half flip the cell.
    [self animateFlipAndReizeOnCell:self.selectedCell.layer];
}

- (void)animateFlipAndReizeOnCell:(CALayer *)cellLayer
{
    /*----------------------------
     Animating the cell
     ----------------------------*/
    
    // Create a layer from the selected cell's layer.
    CALayer *animatedCellLayer = [self layerToAnimateFromLayer:self.selectedCellLayer];
    animatedCellLayer.position = [self selectedCellPosition];
    animatedCellLayer.zPosition = 500.0f;
    
    // Add the cell's animated layer to the window.
    /*
    if ([self isInNavigationController]) {
        [self.sourceViewController.view.layer addSublayer:animatedCellLayer];
    }
    
    else {
     */
        [self.sourceViewWindow.layer addSublayer:animatedCellLayer];
    /*
    }
     */
    
    // Hide the cell so the animation will look realistic.
    self.selectedCell.hidden = YES;
    
    
    // Create the necessary parameters.
    CGPoint destPosition = CGPointMake(160, 250);
    CGSize destSize = CGSizeMake(320, 460);
    FlipType cellFlipType = FlipTypeFlip;
    FlipDirection flipDirection = (animatedCellLayer.position.y > 230) ? FlipDirectionBackwards : FlipDirectionForward;
    
    // Create the required animations.
    CABasicAnimation *cellResizeAnimation = [self createResizeAnimationFromSize:animatedCellLayer.bounds.size
                                                                         toSize:destSize
                                                                   withDuration:kTransitionDuration];
    CABasicAnimation *cellRepositionAnimation = [self createRepositionAnimationFromPoint:animatedCellLayer.position
                                                                                 toPoint:destPosition
                                                                            withDuration:kTransitionDuration];
    
    // Combine the resize and reposition animations into 1 animation group.
    CAAnimationGroup *cellAnimations = [[CAAnimationGroup alloc] init];
    cellAnimations.animations = @[cellResizeAnimation, cellRepositionAnimation];
    cellAnimations.duration = kTransitionDuration;
    cellAnimations.removedOnCompletion = NO;
    cellAnimations.fillMode = kCAFillModeForwards;
    
    // Create the cell's flip animation.
    CABasicAnimation *cellFlipAnimation = [self createFlipAnimationWithFlipType:cellFlipType
                                                                      direction:flipDirection
                                                                    andDuration:(kTransitionDuration / 2)];
    cellFlipAnimation.removedOnCompletion = NO;
    cellFlipAnimation.fillMode = kCAFillModeForwards;
    
    // Add the animations to the cell.
    [animatedCellLayer addAnimation:cellAnimations forKey:@"reConstructAnimations"];
    [animatedCellLayer addAnimation:cellFlipAnimation forKey:@"flipAnimation"];
    
    self.cellAnimatedLayer = animatedCellLayer;
    
    /*----------------------------
     Animating the destination layer
     ----------------------------*/
    
    // Size and position the destination layer as the cell.
    CALayer *destAnimatedLayer = [self layerToAnimateFromLayer:self.destinationLayer];
    destAnimatedLayer.position = [self selectedCellPosition];
    destAnimatedLayer.bounds = self.selectedCell.layer.bounds;
    destAnimatedLayer.zPosition = 500.0f;
    
    /*
    // Add the destination layer to the window.
    if ([self isInNavigationController]) {
        [self.sourceViewController.view.layer addSublayer:destAnimatedLayer];
    }
    
    else {
     */
        [self.sourceViewWindow.layer addSublayer:destAnimatedLayer];
    /*
    }
     */
    
    // Transform the destination layer so it would lay down.
    CATransform3D skewedIdentityTransform = [self skewedIdentitiyTransformWithZDistance:1000];
    CATransform3D destLayerTrasnform = CATransform3DRotate(skewedIdentityTransform, M_PI_2, 1, 0, 0);
    destAnimatedLayer.transform = destLayerTrasnform;
    
    // Create the necessary parameters.
    CGPoint layerDestPosition = destPosition;
    CGSize layerDestSize = destSize;
    FlipType layerFlipType = FlipTypeUnflip;
    
    // Create the required animations.
    CABasicAnimation *layerResizeAnimation = [self createResizeAnimationFromSize:destAnimatedLayer.bounds.size
                                                                          toSize:layerDestSize
                                                                    withDuration:kTransitionDuration];
    CABasicAnimation *layerRepositionAnimation = [self createRepositionAnimationFromPoint:destAnimatedLayer.position
                                                                                  toPoint:layerDestPosition
                                                                             withDuration:kTransitionDuration];
    
    // Combine the resize and reposition animations into 1 animation group.
    CAAnimationGroup *layerAnimations = [[CAAnimationGroup alloc] init];
    layerAnimations.animations = @[layerResizeAnimation, layerRepositionAnimation];
    layerAnimations.duration = kTransitionDuration;
    layerAnimations.removedOnCompletion = NO;
    layerAnimations.fillMode = kCAFillModeForwards;
    
    // Create the layer's flip animation.
    CABasicAnimation *layerFlipAnimation = [self createFlipAnimationWithFlipType:layerFlipType
                                                                       direction:flipDirection
                                                                     andDuration:(kTransitionDuration / 2)];
    layerFlipAnimation.removedOnCompletion = NO;
    layerFlipAnimation.fillMode = kCAFillModeForwards;
    layerFlipAnimation.delegate = self;
    
    // Add the animations to the destination layer.
    [destAnimatedLayer addAnimation:layerAnimations forKey:@"reConstructAnimations"];
    [destAnimatedLayer addAnimation:layerFlipAnimation forKey:@"flipAnimation"];
    
    self.destAnimatiedLayer = destAnimatedLayer;
}

#pragma mark - Utility Methods

- (CGPoint)selectedCellPosition
{
    // Convert the cell's position to the window's coordinate system.
    CGPoint convertedPoint = CGPointZero;
    
    /*
    if ([self isInNavigationController]) {
        convertedPoint = [self.sourceViewController.view.layer convertPoint:self.selectedCell.layer.position
                                                                  fromLayer:self.selectedCell.layer.superlayer];
    }
    
    else {
     */
        convertedPoint = [self.sourceViewWindow.layer convertPoint:self.selectedCell.layer.position
                                                         fromLayer:self.selectedCell.layer.superlayer];
    /*
    }
     */
    
    return convertedPoint;
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    // Take a snapshot of the cell.
    UIGraphicsBeginImageContext(layer.bounds.size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *layerSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return layerSnapshot;
}

#pragma mark - View Management Methods

- (UIWindow *)sourceViewWindow
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIWindow *sourceViewWindow = sourceViewController.view.window;
    
    return sourceViewWindow;
}

- (UIViewController *)sourceViewController
{
    return [super sourceViewController];
}

- (UIViewController *)destinationViewController
{
    return [super destinationViewController];
}

- (BOOL)isStatusBarVisible
{
    return [[UIApplication sharedApplication] isStatusBarHidden];
}

- (BOOL)isInNavigationController
{
    return (self.sourceViewController.navigationController != nil);
}

#pragma mark - Layer Management Methods

- (CALayer *)layerToAnimateFromLayer:(CALayer *)layer
{
    // Create & configure a layer based on the received layer.
    CALayer *animatedLayer = [[CALayer alloc] init];
    animatedLayer.contents = (id)[[self imageFromLayer:layer] CGImage];
    animatedLayer.bounds = layer.bounds;
    animatedLayer.zPosition = 500.0f;
    
    return animatedLayer;
}

- (CALayer *)selectedCellLayer
{
    return self.selectedCell.layer;
}

- (CALayer *)destinationLayer
{
    return self.destinationViewController.view.layer;
}

- (CALayer *)sourceLayer
{
    return self.sourceViewController.view.layer;
}

#pragma mark - Animation Create Methods

- (CATransform3D)skewedIdentitiyTransformWithZDistance:(CGFloat)zDistance
{
    CATransform3D skewedIdentityTransform = CATransform3DIdentity;
    skewedIdentityTransform.m34 = 1.0f / -zDistance;
    
    return skewedIdentityTransform;
}

- (CABasicAnimation *)createResizeAnimationFromSize:(CGSize)originSize
                                             toSize:(CGSize)destSize
                                       withDuration:(NSTimeInterval)duration
{
    // Create the origin and destination bounds rectangles.
    CGRect originRect = CGRectMake(0, 0, originSize.width, originSize.height);
    CGRect destRect = CGRectMake(0, 0, destSize.width, destSize.height);
    
    // Create & configure the animation.
    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    resizeAnimation.fromValue = [NSValue valueWithCGRect:originRect];
    resizeAnimation.toValue = [NSValue valueWithCGRect:destRect];
    resizeAnimation.duration = duration;
    resizeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return resizeAnimation;
}

- (CABasicAnimation *)createRepositionAnimationFromPoint:(CGPoint)originPoint
                                                 toPoint:(CGPoint)destPoint
                                            withDuration:(NSTimeInterval)duration
{
    // Create & configure the animation.
    CABasicAnimation *repositionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    repositionAnimation.fromValue = [NSValue valueWithCGPoint:originPoint];
    repositionAnimation.toValue = [NSValue valueWithCGPoint:destPoint];
    repositionAnimation.duration = duration;
    repositionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return repositionAnimation;
}

- (CABasicAnimation *)createFlipAnimationWithFlipType:(FlipType)flipType
                                            direction:(FlipDirection)direction
                                          andDuration:(NSTimeInterval)duration
{
    // Create the origin & destination transforms.
    CATransform3D skewedIdentityTransform = [self skewedIdentitiyTransformWithZDistance:1000.0f];
    
    // If this is an 'unflip' animation, the direction of the flip should be reversed.
    CGFloat flipAngle = (flipType == FlipTypeFlip) ? M_PI_2 * direction * (-1) : M_PI_2 * direction;
    
    // Set the flip axis based on the set axis.
    CATransform3D flippedTransform = CATransform3DIdentity;
    switch (self.flipAxis) {
        case FlipAxisHorizontal:
            flippedTransform = CATransform3DRotate(skewedIdentityTransform,
                                                   flipAngle,
                                                   1, 0, 0);
            break;
            
        case FlipAxisVertical:
            flippedTransform = CATransform3DRotate(skewedIdentityTransform,
                                                   flipAngle,
                                                   0, 1, 0);
            break;
            
        case FlipAxisDiagonal:
            flippedTransform = CATransform3DRotate(skewedIdentityTransform,
                                                   flipAngle,
                                                   1, 1, 0);
            break;
            
        default:
            break;
    }
    
    NSValue *valueIdentityTransform = [NSValue valueWithCATransform3D:skewedIdentityTransform];
    NSValue *valueFlippedTransform = [NSValue valueWithCATransform3D:flippedTransform];
    
    // Create & configure the animation.
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    flipAnimation.duration = duration;
    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // Set the animation 'to' and 'from' values based on the flip type.
    switch (flipType) {
        case FlipTypeFlip:
            flipAnimation.fromValue = valueIdentityTransform;
            flipAnimation.toValue = valueFlippedTransform;
            break;
            
        case FlipTypeUnflip:
            flipAnimation.fromValue = valueFlippedTransform;
            flipAnimation.toValue = valueIdentityTransform;
            
            // If we unflip, set a delay so the flipping layer will finish its animation.
            flipAnimation.beginTime = CACurrentMediaTime() + (kTransitionDuration / 2);
            break;
            
        default:
            break;
    }
    
    return flipAnimation;
}

#pragma mark - Animation Delegate Methods

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (([self.destAnimatiedLayer animationForKey:@"flipAnimation"] == anim) && flag) {
        [self.sourceViewController presentViewController:self.destinationViewController
                                                animated:NO
                                              completion:^{
                                                  // Remove the animation layers.
                                                  [self.cellAnimatedLayer removeFromSuperlayer];
                                                  [self.destAnimatiedLayer removeFromSuperlayer];
                                                  
                                                  // Unhide the selected cell.
                                                  self.selectedCell.hidden = NO;
                                              }];
    }
}

@end
