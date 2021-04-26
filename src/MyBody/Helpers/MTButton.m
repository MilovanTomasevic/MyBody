//
//  MTButton.m
//  MTcams
//
//  Created by Milovan Tomasevic on 09/10/2017.
//  Copyright © 2017 administrator. All rights reserved.
// 

#import "MTButton.h"

@implementation MTButton

+ (UIButton *)createCustomBackButton:(BOOL)inverted
{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    if(inverted) {
        [button setImage:[UIImage imageNamed:(@"back_arrow_black")] forState:UIControlStateNormal];
        [button setTitleColor:[[THEME_MANAGER getNeutralTextColor] colorWithAlphaComponent:1] forState:UIControlStateHighlighted];
        [button setTitleColor:[[THEME_MANAGER  getNeutralTextColor] colorWithAlphaComponent:1] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:(@"back_arrow")] forState:UIControlStateNormal];
        [button setTitleColor:[[THEME_MANAGER getTextColor] colorWithAlphaComponent:1] forState:UIControlStateHighlighted];
        [button setTitleColor:[[THEME_MANAGER  getTextColor] colorWithAlphaComponent:1] forState:UIControlStateNormal];
    }
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, kRightInsentBackArrow)];
    [button setTitle:NSLocalizedString(@"back_button", nil) forState:UIControlStateNormal];
    [button.titleLabel setFont:[THEME_MANAGER fontWithStyleName:OCFontStyleMedium size:kFontSizeDefIPhone]];
    CGSize stringsize = [NSLocalizedString(@"back_button", nil) sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSFontAttributeName, nil]];
    [button setFrame:CGRectMake(0,0,stringsize.width+kMarginDefault, kUIButtonDefHeight)];
    return button;
}

+ (UIButton *)createDialogButton:(NSString*)btnText{
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton setTitle:btnText forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitleColor:[THEME_MANAGER  getNeutralTextColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [THEME_MANAGER fontWithStyleName:OCFontStyleLight size:kFontSizeMedium];
    cancelButton.layer.borderWidth = kBorderDefWidth;
    cancelButton.layer.borderColor = [THEME_MANAGER getNeutralStrokeColor].CGColor;
    cancelButton.layer.cornerRadius = kButtonDefCornerRadius;
    cancelButton.layer.masksToBounds =YES;
    CGSize stringsize1 = [cancelButton.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:cancelButton.titleLabel.font, NSFontAttributeName, nil]];
    cancelButton.frame = CGRectMake(0, 0, stringsize1.width+kMarginDefault, kUIButtonDialogDefHeight);
    return cancelButton;
}

+ (UIButton *)createRollerFixButton:(NSString*)imgName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTintColor:[UIColor whiteColor]];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    button.layer.cornerRadius = kButtonDefCornerRadius;
    button.layer.borderColor = [THEME_MANAGER  getStrokeColor].CGColor;
    button.layer.borderWidth = kBorderDefWidth;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)createNavBarButton:(NSString*)btnText{
    UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:btnText forState:UIControlStateNormal];
    [button2 setTitleColor: [UIColor orangeColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[[THEME_MANAGER  getTextColor] colorWithAlphaComponent:kAlphaComponent] forState:UIControlStateHighlighted];
    CGSize stringsize = [button2.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:button2.titleLabel.font, NSFontAttributeName, nil]];
    [button2 setFrame:CGRectMake(0, 0, stringsize.width+kMarginDefault, kUIButtonNavBarDefHeight)];
    //button2.titleLabel.font = [THEME_MANAGER  fontWithStyleName:FontStyleLight size:kFontSizeDefIPhone];
    button2.layer.borderWidth = kBorderDefWidth;
    button2.layer.borderColor = [UIColor grayColor].CGColor;
    button2.layer.cornerRadius = kButtonDefCornerRadius;
    button2.layer.masksToBounds = YES;
    return button2;
}



+ (UIButton *)createGWSceneButton:(int)yPos frameWidth:(int)frameWidth withName:(NSString*)gwName{
    UIButton* gatewayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gatewayButton.frame = CGRectMake(0, yPos, frameWidth+2, kUIButtonUnosrtedIPhoneHeight);
    gatewayButton.layer.borderWidth = kBorderDefWidth;
    gatewayButton.layer.masksToBounds = YES;
    gatewayButton.layer.borderColor = [THEME_MANAGER getNeutralStrokeColor].CGColor;
    [gatewayButton setTitle:gwName forState:UIControlStateNormal];
    gatewayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [gatewayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kMarginDefault*3/2, 0, 0)];
    gatewayButton.adjustsImageWhenHighlighted = NO;
    
    [gatewayButton.titleLabel setFont:[THEME_MANAGER fontWithStyleName:OCFontStyleLight size:kFontSizeDefIPhone]];
    [gatewayButton setTitleColor:[THEME_MANAGER getNeutralTextColor] forState:UIControlStateNormal];
    gatewayButton.backgroundColor = [THEME_MANAGER getNeutralListItemColor];
    
    UIImage *img = [UIImage imageNamed:@"gateway_filters_blue"];
    img = [MTSupport filledImageFrom:img withColor:[THEME_MANAGER getNeutralStrokeColor]];
    [gatewayButton setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    // active
    img = [MTSupport filledImageFrom:img withColor:[THEME_MANAGER getStrokeColor]];
    [gatewayButton setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [gatewayButton setTitleColor:[THEME_MANAGER getNeutralTextColor] forState:UIControlStateNormal];
    [gatewayButton setTitleColor:[THEME_MANAGER getNeutralTextColor] forState:UIControlStateHighlighted];
    [gatewayButton setImageEdgeInsets:UIEdgeInsetsMake(kMarginDefault/2, kMarginDefault/2, kMarginDefault/2, 0)];
    return gatewayButton;
}

+ (UIButton *)createGWButton:(int)frameWidth withName:(NSString*)gwName{
    UIButton* gatewayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gatewayButton.frame = CGRectMake(0, 0, frameWidth+2, kUIButtonUnosrtedIPhoneHeight);
    gatewayButton.layer.borderWidth = kBorderDefWidth;
    gatewayButton.layer.masksToBounds = YES;
    gatewayButton.layer.borderColor = [THEME_MANAGER getStrokeColor].CGColor;
    [gatewayButton setTitle:gwName forState:UIControlStateNormal];
    gatewayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [gatewayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kMarginDefault*3/2, 0, 0)];
    gatewayButton.adjustsImageWhenHighlighted = NO;
    
    UIImage *tabBGColor = [[MTSupport imageWithColor:[THEME_MANAGER getAccentColor] andSize:CGSizeMake(1, 1)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBGColor = [MTSupport imageWithGradient:tabBGColor changeAlpha:NO];
    [gatewayButton setBackgroundImage:tabBGColor forState:UIControlStateHighlighted];
    [gatewayButton.titleLabel setFont:[THEME_MANAGER fontWithStyleName:OCFontStyleLight size:kFontSizeDefIPhone]];
    [gatewayButton setTitleColor:[THEME_MANAGER getTextColor] forState:UIControlStateNormal];
    [gatewayButton setImage:[[UIImage imageNamed:@"gateway_filters"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [gatewayButton setImageEdgeInsets:UIEdgeInsetsMake(kMarginDefault/2, kMarginDefault/2, kMarginDefault/2, 0)];
    // custom colour for btn
    gatewayButton.backgroundColor = [THEME_MANAGER getListItemColor];
    UIImage *tmpImg = [MTSupport filledImageFrom:[UIImage imageNamed:@"gateway_filters"] withColor:[THEME_MANAGER getTextColor]];
    [gatewayButton setImage:tmpImg  forState:UIControlStateNormal];
    [gatewayButton setTitleColor:[THEME_MANAGER getTextColor] forState:UIControlStateNormal];
    
    return gatewayButton;
}

+ (UIButton *)createUnsortedDevBtn:(int)numOfUnsorted withFrame:(CGRect)frame{
    UIButton* unsortedDevicesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unsortedDevicesButton.backgroundColor = [THEME_MANAGER getUnsortedButtonColor];
    unsortedDevicesButton.titleEdgeInsets = UIEdgeInsetsMake(0, kMarginDefault/2, 0, 0);
    unsortedDevicesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [unsortedDevicesButton setTitle:NSLocalizedString(@"unsorted_button", nil) forState:UIControlStateNormal];
    [unsortedDevicesButton setTitle:NSLocalizedString(@"unsorted_button", nil) forState:UIControlStateHighlighted];
    [unsortedDevicesButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [unsortedDevicesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    unsortedDevicesButton.titleLabel.font = [THEME_MANAGER fontWithStyleName:OCFontStyleLight size:THEME_MANAGER.fontSizeDefault];
    unsortedDevicesButton.frame = frame;
    int labNumberWidth = kLabelNumOfUnsortDevWidth;
    int arrowWidth = 0;
    if(!IS_IPAD){
        labNumberWidth = kLabelNumOfUnsortDevWidthiPad;
        arrowWidth = kUIButtonArrowImgWidth;
        UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-arrowWidth-kMarginDefault/2, frame.size.height/2-arrowWidth/2, arrowWidth, arrowWidth)];
        arrowImage.image = [UIImage imageNamed:@"right_arrow"];
        arrowImage.alpha = kArrowImageAlpha;
        arrowImage.contentMode = UIViewContentModeCenter;
        [unsortedDevicesButton addSubview:arrowImage];
    }
    UILabel *numberOfUnsortedDevices = [[UILabel alloc]initWithFrame:CGRectMake(unsortedDevicesButton.frame.size.width-labNumberWidth-kMarginDefault/2, 0, labNumberWidth-arrowWidth-kMarginDefault/2, unsortedDevicesButton.frame.size.height)];
    numberOfUnsortedDevices.text = STR_FROM_INT(numOfUnsorted);
    numberOfUnsortedDevices.textColor = [UIColor whiteColor];
    numberOfUnsortedDevices.font = [THEME_MANAGER fontWithStyleName:OCFontStyleLight size:THEME_MANAGER.fontSizeDefault];
    numberOfUnsortedDevices.textAlignment = NSTextAlignmentRight;
    [unsortedDevicesButton addSubview:numberOfUnsortedDevices];
    return unsortedDevicesButton;
}


+ (UIButton *)createFilterBtn:(NSString*)title{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[MTSupport filledImageFrom:[UIImage imageNamed:@"down_arrow"] withColor:[THEME_MANAGER getTextColor]] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[THEME_MANAGER fontWithStyleName:OCFontStyleMedium size:kFontSizeDefIPhone]];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:kAlphaComponent] forState:UIControlStateHighlighted];
    CGSize stringsize = [button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font, NSFontAttributeName, nil]];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, stringsize.width+kMarginDefault/2, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -kMarginDefault/2, 0, 0)];
    [button setFrame:CGRectMake(0, 0, stringsize.width+2*kMarginDefault, kUIButtonDefHeight)];
    [button setTitleColor:[THEME_MANAGER getTextColor] forState: UIControlStateNormal];
    return button;
}

+ (UIButton *)createHelpButtonForAdvancedScenes{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"help_button", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:kAlphaComponent] forState:UIControlStateHighlighted];
    CGSize stringsize = [button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font, NSFontAttributeName, nil]];
    [button setFrame:CGRectMake(0,0,stringsize.width + kMarginDefault, kUIButtonNavBarDefHeight)];
    button.titleLabel.font = [THEME_MANAGER fontWithStyleName:OCFontStyleLight size:kFontSizeDefIPhone];
    button.layer.borderWidth = kBorderDefWidth;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.cornerRadius = kButtonDefCornerRadius;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[THEME_MANAGER getTextColor] forState: UIControlStateNormal];
    button.layer.borderColor = [THEME_MANAGER getNeutralStrokeColor].CGColor;
    
    return button;
}

+(UIButton*)customizeButtonWithArrow:(NSString*)title withFrame:(CGRect)frame{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button.layer setBorderWidth:2];
    [button.layer setBorderColor:[UIColor orangeColor].CGColor];
    [button.layer setCornerRadius:7];
    [button.layer setMasksToBounds:YES];
    [button setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateSelected];
    [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    [button setFrame:frame];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.frame.size.width-20, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];

    return button;
}

+(UIButton*) customizeBarButtonWithImageName:(NSString*)imageName{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0,0,kUIButtonNavBarDefHeight, kUIButtonNavBarDefHeight)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}


 
//+(UIButton*) customizeBarButtonWithImageName:(NSString*)imageName{
//     UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
//     [button setFrame:CGRectMake(0,0,kUIButtonNavBarDefHeight, kUIButtonNavBarDefHeight)];
//     [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//     return button;
//}
//     
//-(void)customizeField:(UITextField*)field withView:(UIView*)view andPlaceholder:(NSString*)placeholder{
// 
// field.borderStyle = UITextBorderStyleRoundedRect;
// field.font = [UIFont systemFontOfSize:15];
// field.placeholder = placeholder;
// field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
// field.autocorrectionType = UITextAutocorrectionTypeNo;
// field.keyboardType = UIKeyboardTypeDefault;
// field.returnKeyType = UIReturnKeyDone;
// field.clearButtonMode = UITextFieldViewModeWhileEditing;
// field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
// field.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
// /*
//  if([field.text isEqualToString:@""]){
//  field.backgroundColor = [UIColor whiteColor];
//  }else{
//  field.backgroundColor = [UIColor grayColor];
//  }*/
// [field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
// 
// field.delegate = self;
// [view addSubview:field];
//}

@end
