//
//  MTGradientProgressView.m
//  MyBody
//
//  Created by Milovan Tomasevic on 02/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "MTGradientProgressView.h"


@interface MTGradientProgressView()

@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation MTGradientProgressView


+ (Class)layerClass {
    return [CAGradientLayer class];
}

//// Use a horizontal gradient
//CAGradientLayer *layer = (id)[self layer];
//[layer setStartPoint:CGPointMake(0.0, 0.5)];
//[layer setEndPoint:CGPointMake(1.0, 0.5)];
//
//// Create colors using hues in +5 increments
//NSMutableArray *colors = [NSMutableArray array];
//for (NSInteger hue = 0; hue <= 360; hue += 5) {
//
//    UIColor *color;
//    color = [UIColor colorWithHue:1.0 * hue / 360.0
//                       saturation:1.0
//                       brightness:1.0
//                            alpha:1.0];
//    [colors addObject:(id)[color CGColor]];
//}
//
//[layer setColors:[NSArray arrayWithArray:colors]];

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        _maskLayer = [CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [_maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [self.layer setMask:_maskLayer];
        
        // Use a horizontal gradient
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create colors using hues in +5 increments
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 5) {
            
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * hue / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        [layer setColors:[NSArray arrayWithArray:colors]];
    }
    
    return self;
}

- (void)performAnimation {
    // Move the last color in the array to the front
    // shifting all the other colors.
    CAGradientLayer *layer = (id)[self layer];
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject] ;
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    
    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
    
    
    // Update the colors on the model layer
    [layer setColors:shiftedColors];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)setProgress:(CGFloat)value {
    if (_progress != value) {
        // Progress values go from 0.0 to 1.0
        _progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    // Resize our mask layer based on the current progress
    CGRect maskRect = [_maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * _progress;
    [_maskLayer setFrame:maskRect];
}


- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    if ([self isAnimating]) {
        
        [self performAnimation];
    }
}

- (void)startAnimating {
    
    if (![self isAnimating]) {
        
        _animating = YES;
        
        [self performAnimation];
    }
}

- (void)stopAnimating {
    
    if ([self isAnimating]) {
        
        _animating = NO;
    }
}


@end
