//
//  MTGradientProgressView.h
//  MyBody
//
//  Created by Milovan Tomasevic on 02/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTGradientProgressView : UIView<CAAnimationDelegate>

- (void)setProgress:(CGFloat)value;

- (void)performAnimation;
@property (nonatomic, readonly, getter=isAnimating) BOOL animating;
@property (nonatomic, readwrite, assign) CGFloat progress;

- (void)startAnimating;
- (void)stopAnimating;


@end
