//
//  MTComboBox.h
//  MyBody
//
//  Created by Milovan Tomasevic on 31/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

typedef NS_ENUM(NSInteger, MTEComboBoxTypes) {
    MTE_CBTSimpleButtonWithArrow,
    MTE_CBTItemsWithoutTitleChange,
    MTE_CBTItemsWithAutoTitleChange
};

typedef NS_ENUM(NSInteger, MTComboBoxStyle) {
    MTComboBoxStyleLight,
    MTComboBoxStyleDark
};
@interface MTComboBox : UIControl

/*!
 @brief Use this init to properly init OCComboBox. Default ComboBox style is OLComponentStyleLight
 @param frame - frame
 @param type - one of OLEComboBoxTypes
 @param parentVC - parent view controller use to display items list(alert controller), this can be nil for type OLE_CBTSimpleButtonWithArrow
 */
-(id)initWithFrame:(CGRect)frame andType:(MTEComboBoxTypes)type andParentVC:(UIViewController*)parentVC;


/*!
 @brief Use this init to properly init OCComboBox.
 @param frame - frame
 @param type - one of OLEComboBoxTypes
 @param style - one of OLComboBoxStyle. represent combo box style
 @param parentVC - parent view controller use to display items list(alert controller), this can be nil for type OLE_CBTSimpleButtonWithArrow
 */
-(id)initWithFrame:(CGRect)frame type:(MTEComboBoxTypes)type style:(MTComboBoxStyle)style andParentVC:(UIViewController*)parentVC;


/*!
 @brief Use this to set selector which will be fired when user select one item from list
 @discussion Selector wil not be fired for cancel(out of control touch for IPad), this do nothing for
 combo box type OLE_CBTSimpleButtonWithArrow
 @param target - view controller(object) which will handle action
 @param action - method in targets class which will be called
 */
-(void)setTargetForSelectedItemChanged:(id)target action:(SEL)action;

/*!
 @brief Set title of button when no item is selected (kBadIndex), this is used only for type OLE_CBTItemsWithAutoTitleChange
 @param title - Text to be display when selectedIndex == kBadIndex
 */
-(void)setTitleForBadIndexItem:(NSString*)title;

/*!
 @brief Replace items list with new one
 @discussion you do not need to delete old list, and selected index will be set to kBadIndex after this operation
 @param items - NSArray* of strings which represent items list
 */
-(void)setItems:(NSArray*)items;

/*!
 @brief Add one new item to list, if list not exists it will create one
 @param item - NSString representing item title
 */
-(void)addItem:(NSString*)item;

/*!
 @brief remove all items and set selectedIndex to kBadIndex
 //param item - NSString representing item title
 */
-(void)removeAllItems;

/*!
 @brief Return copy of items array
 @return NSArray or nil
 */
-(NSArray*)getItems;

/*!
 @brief Return last selected item
 @return NSString or nil
 */
-(NSString*)getSelectedItem;

/*!
 @brief Return last selected index
 @return int, kBadIndex or one in range [0 - (items.count-1)]
 */
-(int)getSelectedIndex;

/*!
 @brief Set selected index to given value, NOTE: do not fire selector
 @param newIndex new index to be set, if it is OutOfIndexBounds, index will be set to kBadIndex
 */
-(void)setSelectedIndex:(int)newIndex;


-(void)setTitle:(NSString *)titleText;

@property(nonatomic,strong) MarqueeLabel *titleLabel;

@end
