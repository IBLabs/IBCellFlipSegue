//
//  MainMenuCell.m
//  CellFlip
//
//  Created by Itamar Biton on 2/18/13.
//  Copyright (c) 2013 IBlabs. All rights reserved.
//

#import "MainMenuCell.h"

@implementation MainMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* backgroundGradientColor = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.91 alpha: 1];
    UIColor* backgroundGradientColor2 = [UIColor colorWithRed: 0.782 green: 0.782 blue: 0.782 alpha: 1];
    UIColor* backgroundGradientColor3 = [UIColor colorWithRed: 0.543 green: 0.543 blue: 0.543 alpha: 1];
    UIColor* backgroundGradientColor4 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Gradient Declarations
    NSArray* backgroundGradientColors = [NSArray arrayWithObjects:
                                         (id)backgroundGradientColor4.CGColor,
                                         (id)backgroundGradientColor.CGColor,
                                         (id)backgroundGradientColor2.CGColor,
                                         (id)backgroundGradientColor3.CGColor, nil];
    CGFloat backgroundGradientLocations[] = {0, 0.02, 0.98, 1};
    CGGradientRef backgroundGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)backgroundGradientColors, backgroundGradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 88)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, backgroundGradient, CGPointMake(160, -0), CGPointMake(160, 88), 0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(backgroundGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
