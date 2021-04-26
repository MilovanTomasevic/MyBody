//
//  MTComboBox.m
//  MyBody
//
//  Created by Milovan Tomasevic on 31/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "MTComboBox.h"


@implementation MTComboBox{
    UIViewController* _parentVC;
    UIAlertController* _alert;
    MTEComboBoxTypes _type;
    MTComboBoxStyle _style;
    UIImageView *_arrowView;
    NSMutableArray*/*<NSString>*/ _items;
    int _selectedIndex;
    NSString* _titleForBadIndex;
    id _target;
    SEL _action;
}

-(id)initWithFrame:(CGRect)frame type:(MTEComboBoxTypes)type style:(MTComboBoxStyle)style andParentVC:(UIViewController *)parentVC
{
    self = [self initWithFrame:frame andType:type andParentVC:parentVC ];
    if(self){
        _parentVC = parentVC;
        _selectedIndex = kBadIndex;
        _type = type;
        _style = style;
        [self customize:style];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andType:(MTEComboBoxTypes)type andParentVC:(UIViewController*)parentVC{
    self = [super initWithFrame:frame];
    if(self){
        _parentVC = parentVC;
        _selectedIndex = kBadIndex;
        _type = type;
        
        _arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-15, frame.size.height/2-3, 12, 6)];
        [self addSubview:_arrowView];
        _titleLabel =  [[MarqueeLabel alloc] initWithFrame:CGRectMake(kMarginDefault/2, 0 , frame.size.width - kMarginDefault - _arrowView.frame.size.width, frame.size.height)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel.styleName = MTFontStyleRegular;
        [self addSubview:_titleLabel];
        _style = MTComboBoxStyleLight;
        [self customize:MTComboBoxStyleLight];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //override components frames
    [_arrowView setFrame:CGRectMake(frame.size.width-15, frame.size.height/2-3, 12, 6)];
    [_titleLabel setFrame:CGRectMake(kMarginDefault/2, 0,frame.size.width - kMarginDefault - _arrowView.frame.size.width , frame.size.height)];
}

#pragma mark - Public setters & getters

-(void)setTitleForBadIndexItem:(NSString*)title{
    _titleForBadIndex = title;
    if(_type == MTE_CBTItemsWithAutoTitleChange && _selectedIndex==kBadIndex){
        [self setTitle:_titleForBadIndex];
    }
}

-(void)setTargetForSelectedItemChanged:(id)target action:(SEL)action{
    if(_type != MTE_CBTSimpleButtonWithArrow){
        _target = target;
        _action = action;
    }
}

-(void)setItems:(NSArray*)items{
    _items = [[NSMutableArray alloc] initWithArray:items];
    _selectedIndex = kBadIndex;
}

-(void)addItem:(NSString*)item{
    if(!_items){
        _items = [[NSMutableArray alloc] init];
    }
    [_items addObject:item];
}

-(void)removeAllItems{
    _items = nil;
    _selectedIndex = kBadIndex;
}

-(NSArray*)getItems{
    return [[NSArray alloc] initWithArray:_items];
}

-(NSString*)getSelectedItem{
    return _selectedIndex==kBadIndex?nil:_items[_selectedIndex];
}

-(int)getSelectedIndex{
    return _selectedIndex;
}

-(void)setSelectedIndex:(int)newIndex{
    if( (newIndex >= kBadIndex) && (newIndex < (int)_items.count)  ){
        _selectedIndex = newIndex;
        if(_type == OLE_CBTItemsWithAutoTitleChange){
            if(_selectedIndex==kBadIndex){
                [self setTitle:_titleForBadIndex];
            }else{
                [self setTitle:(NSString*)_items[_selectedIndex]];
            }
        }
    }else{
        _selectedIndex = kBadIndex;
        LogE(@"setSelectedIndex call with indexOutOfBounds! newIndex %d, count %d, selected item reverted to nil!", newIndex, (int)_items.count);
    }
}

#pragma mark - Change selected state, display & hide item list

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self setSelected:!self.isSelected];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        [self setBackgroundColor:[THEME_MANAGER getAccentColor]];
        if(_type != OLE_CBTSimpleButtonWithArrow){
            [self displayItemList];
        }
    }else{
        if (_style == MTComboBoxStyleLight){
            [self setBackgroundColor:[UIColor whiteColor]];
        }else {
            [self setBackgroundColor:[THEME_MANAGER getSecondaryColor]];
        }
    }
    [self setTitleTextColor];
}

- (void)displayItemList{
    _alert =[UIAlertController
             alertControllerWithTitle:NSLocalizedString(@"action_sheet_title_5", nil)
             message:nil
             preferredStyle:UIAlertControllerStyleActionSheet ];
    
    for (int i=0; i< (int)_items.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:_items[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self onSelectedIndexChanged:i];
        }];
        [_alert addAction:action];
    }
    //this will not be visible on IPad but it will fire on touch outside
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel_button",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        [self onSelectedIndexChanged:kBadIndex];
    }];
    [_alert addAction:cancel];
    if(IS_IPAD){
        _alert.popoverPresentationController.sourceView = self;
        _alert.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    [_parentVC  presentViewController:_alert animated:NO completion:nil];
}

-(void)onSelectedIndexChanged:(int)newIndex{
    [self setSelected:NO];
    if(newIndex != kBadIndex){
        _selectedIndex = newIndex;
        if(_type == OLE_CBTItemsWithAutoTitleChange){
            [self setTitle:(NSString*)_items[_selectedIndex]];
        }
        if(_target && _action){
            [_target performSelector:_action withObject:self afterDelay:0];
        }
    }
    [_alert dismissViewControllerAnimated:YES completion:nil];
    _alert = nil;
}

-(void)setTitle:(NSString *)titleText
{
    _titleLabel.text = titleText;
}

-(void)setTitleTextColor
{
    if (self.isSelected){
        if(_style == OLComboBoxStyleLight){
            [_titleLabel setTextColor:[UIColor whiteColor]];
        }else{
            [_titleLabel setTextColor:[THEME_MANAGER getTextColor]];
        }
    }else {
        if(_style == OLComboBoxStyleLight){
            [_titleLabel setTextColor:[UIColor blackColor]];
        }else {
            [_titleLabel setTextColor:[THEME_MANAGER getTextColor]];
        }
    }
}


#pragma mark  Helpers

-(void)customize:(MTComboBoxStyle)style
{
    [self.layer setCornerRadius:kButtonDefCornerRadius];
    [self.layer setMasksToBounds:YES];
    
    switch (style) {
        case OLComboBoxStyleDark:{
            self.backgroundColor = [THEME_MANAGER getSecondaryColor];
            self.titleLabel.textColor = [THEME_MANAGER getTextColor];
            [self.layer setBorderWidth:kBorderDefWidth];
            self.layer.borderColor = [[THEME_MANAGER getSecondaryColor] CGColor];
            _arrowView.image = [OCCommon filledImageFrom:[UIImage imageNamed:@"down_arrow"] withColor:[THEME_MANAGER getTextColor]];
            break;
        }
        case OLComboBoxStyleLight:{
            [self setBackgroundColor:[UIColor whiteColor]];
            [_titleLabel setTextColor:[UIColor blackColor]];
            [self.layer setBorderWidth:kBorderDefWidth];
            [self.layer setBorderColor:[THEME_MANAGER getNeutralStrokeColor].CGColor];
            _arrowView.image = [OCCommon filledImageFrom:[UIImage imageNamed:@"down_arrow"] withColor:[UIColor blackColor]];
            break;
        }
        default:
            break;
    }
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.userInteractionEnabled = enabled;
    if(!enabled) {
        if (_style == MTComboBoxStyleLight){
            [self setBackgroundColor:[UIColor whiteColor]];
        }else {
            self.backgroundColor = [THEME_MANAGER getBackgroundColor];
        }
    }
    self.layer.borderColor = [THEME_MANAGER getNeutralStrokeColor].CGColor;
    self.layer.borderWidth = kBorderDefWidth/2;
}
@end

