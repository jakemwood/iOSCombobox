//
//  JMWCombobox.m
//  iOSCombobox
//
//  Created by Jake Wood on 4/14/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.
//

#import "JMWCombobox.h"

#define BORDER_WIDTH 1.5f
#define BORDER_OFFSET (BORDER_WIDTH / 2)
#define ARROW_BOX_WIDTH 32.0f
#define ARROW_WIDTH 14.0f
#define ARROW_HEIGHT 11.0f

#define FONT_NAME @"Helvetica"
#define FONT_SIZE 16.0f
#define TEXT_LEFT 5.0f
#define TEXT_TOP 6.0f

#define ANIMATION_LENGTH 0.25

#define PICKER_VIEW_HEIGHT 216.0f // This is fixed by Apple, and Stack Overflow reports some bugs can be introduced if it's changed.

@implementation JMWCombobox

- (void)initialize
{
    CGFloat pickerY = [[UIScreen mainScreen] bounds].size.height - PICKER_VIEW_HEIGHT;
    // NOTE: The 20 is subtracted because of the top bar that has the clock.
    // If you're using this in a modal view, you may need to come up with a workaround.
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, pickerY, screenWidth, PICKER_VIEW_HEIGHT)];
    [self.pickerView setShowsSelectionIndicator:YES];
    [self.pickerView setDataSource:self];
    [self.pickerView setDelegate:self];
    [self.pickerView selectRow:[self.values indexOfObject:[self currentValue]] inComponent:0 animated:NO];
    
    self.inputView = self.pickerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self initialize];
        active = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initialize];
        active = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    // =============================
    // Setup our gradients
    // =============================
    CGFloat colors [] = {
        1.0, 1.0, 1.0, 1.0,
        0.82, 0.82, 0.82, 1.0
    };
    CGFloat grayColors[] = {
        0.58, 0.58, 0.58, 1.0,
        0.33, 0.33, 0.33, 1.0
    };
    CGFloat blueColors[] = {
        (2 / 3 / 10), 0.18, 0.53, 1.0,
        0.47, 0.54, 0.74, 1.0
    };
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGGradientRef arrow_gray_gradient = CGGradientCreateWithColorComponents(baseSpace, grayColors, NULL, 2);
    CGGradientRef arrow_blue_gradient = CGGradientCreateWithColorComponents(baseSpace, blueColors, NULL, 2);
    
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    // ============================
    // Background gradient
    // ============================
    CGRect newRect = CGRectMake(rect.origin.x + BORDER_OFFSET,
                                rect.origin.y + BORDER_OFFSET,
                                rect.size.width - BORDER_WIDTH,
                                rect.size.height - BORDER_WIDTH);
    CGPathRef background = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0f].CGPath;
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, background);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
    
    // ===========================
    // Background behind arrow
    // ===========================
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, background);
    CGContextClip(ctx);
    CGContextClipToRect(ctx, CGRectMake(rect.size.width - ARROW_BOX_WIDTH,
                                        BORDER_OFFSET,
                                        ARROW_BOX_WIDTH - BORDER_OFFSET,
                                        rect.size.height - BORDER_WIDTH));
    if (active) {
        CGContextDrawLinearGradient(ctx, arrow_blue_gradient, startPoint, endPoint, 0);
    }
    else {
        CGContextDrawLinearGradient(ctx, arrow_gray_gradient, startPoint, endPoint, 0);
    }
    CGContextRestoreGState(ctx);
    
    // ===========================
    // Border around the combobox
    // ===========================
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx, BORDER_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextAddPath(ctx, background);
    if (active) {
        CGContextSetRGBStrokeColor(ctx, (2 / 3 / 10), 0.18f, 0.53f, 1.0f);
    }
    else {
        CGContextSetRGBStrokeColor(ctx, 0.3f, 0.3f, 0.3f, 1.0f);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    CGContextRestoreGState(ctx);
    
    // ============================
    // Line separating arrow / text
    // ============================
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx, BORDER_WIDTH);
    if (active) {
        CGContextSetRGBStrokeColor(ctx, (2 / 3 / 10), 0.18f, 0.53f, 1.0f);
    }
    else {
        CGContextSetRGBStrokeColor(ctx, 0.3f, 0.3f, 0.3f, 1.0f);
    }
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx,
                         rect.size.width - ARROW_BOX_WIDTH,
                         BORDER_WIDTH);
    CGContextAddLineToPoint(ctx,
                            rect.size.width - ARROW_BOX_WIDTH,
                            rect.size.height - BORDER_WIDTH);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
    
    // ============================
    // Draw the arrow
    // ============================
    CGContextSaveGState(ctx);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // the height of the triangle should be probably be about 40% of the height
    // of the overall rectangle, based on the Safari dropdown
    CGFloat centerX = rect.size.width - (ARROW_BOX_WIDTH / 2) - BORDER_OFFSET;
    CGFloat centerY = rect.size.height / 2 + BORDER_OFFSET;
    CGFloat arrowY = centerY - (ARROW_HEIGHT / 2);
    
    CGPathMoveToPoint(path, NULL, centerX - (ARROW_WIDTH / 2), arrowY);
    CGPathAddLineToPoint(path, NULL, centerX + (ARROW_WIDTH / 2), arrowY);
    CGPathAddLineToPoint(path, NULL, centerX, arrowY + ARROW_HEIGHT);
    CGPathCloseSubpath(path);
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0.5f), 1.0f, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    CGContextRestoreGState(ctx);
    
    // ==============================
    // Draw the text
    // ==============================
    if (self.currentValue == nil && [self.values count] > 0)
    {
        [self setCurrentValue:[[self values] objectAtIndex:0]];
    }
    [self.currentValue drawInRect:CGRectMake(TEXT_LEFT, TEXT_TOP,
                                             rect.size.width - ARROW_BOX_WIDTH - TEXT_LEFT,
                                             rect.size.height - BORDER_WIDTH)
                         withFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
    
    CGGradientRelease(gradient), gradient = NULL;
    CGGradientRelease(arrow_blue_gradient), arrow_blue_gradient = NULL;
    CGGradientRelease(arrow_gray_gradient), arrow_gray_gradient = NULL;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    [self becomeFirstResponder];
    return NO;
}

- (void) showPickerView
{
    // Show our picker view!
    CGFloat pickerY = [[UIScreen mainScreen] bounds].size.height - PICKER_VIEW_HEIGHT;
    // NOTE: The 20 is subtracted because of the top bar that has the clock.
    // If you're using this in a modal view, you may need to come up with a workaround.
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, pickerY + PICKER_VIEW_HEIGHT, screenWidth, PICKER_VIEW_HEIGHT)];
    [self.pickerView setShowsSelectionIndicator:YES];
    [self.pickerView setDataSource:self];
    [self.pickerView setDelegate:self];
    [self.pickerView selectRow:[self.values indexOfObject:[self currentValue]] inComponent:0 animated:NO];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerView];
    
    [UIView beginAnimations:@"ShowPicker" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishAnimation:finished:context:)];
    [UIView setAnimationDuration:ANIMATION_LENGTH];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -PICKER_VIEW_HEIGHT);
    self.pickerView.transform = transform;
    [UIView commitAnimations];
    
    [[self inputAccessoryView] setFrame:CGRectMake(0.0f, pickerY - [[self inputAccessoryView] frame].size.height,
                                                  [[self inputAccessoryView] frame].size.width,
                                                   [[self inputAccessoryView] frame].size.height)];
    [[self inputAccessoryView] setNeedsDisplay];
    [[UIApplication sharedApplication].keyWindow addSubview:[self inputAccessoryView]];
}

- (void) hidePickerView
{
    // Hide our picker view!
    [self.pickerView resignFirstResponder];
    
    [UIView beginAnimations:@"HidePicker" context:nil];
    [UIView setAnimationDuration:ANIMATION_LENGTH];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishAnimation:finished:context:)];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, PICKER_VIEW_HEIGHT);
    self.pickerView.transform = transform;
    [UIView commitAnimations];
}

- (void) finishAnimation:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    NSLog(@"Animation finished: %@", animationID);
    /*if (finished)
    {
        [self.pickerView removeFromSuperview];
    }*/
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.values count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setCurrentValue:[self.values objectAtIndex:row]];
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canResignFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    
    active = YES;
    [self setNeedsDisplay];
    
    return YES;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    
    active = NO;
    [self setNeedsDisplay];
    
    return YES;
}
@end