//
//  ZJYTableViewCell.h
//
//  Created by ZhuJiyang on 7/21/15.
//  Copyright (c) 2015 ZhuJiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Custom style */
typedef NS_ENUM(NSInteger, ZJYTableViewCellStyle) {
    ZJYTableViewCellStyleNone,       // HeaderLine, footerLine/separatorLine only, nothing else
    
    ZJYTableViewCellStyleDefault,	// Simple cell with text label, optional remind text label and optional accessory image view
    
};

typedef NS_ENUM(NSInteger, ZJYTableViewCellAccessoryType) {
    ZJYTableViewCellAccessoryNone,                   // don't show any accessory view
    ZJYTableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
};

@interface ZJYTableViewCell : UITableViewCell

/* For lines */
/// Has headerLine or not. Default is nil.
@property (nonatomic) BOOL isFirstCell;
/// Has footerLine or not. Default is nil.
@property (nonatomic) BOOL isLastCell;


/* For title label */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *fontOfTitle;
@property (nonatomic) CGFloat leftMarginOfTitle;
@property (nonatomic, strong) UIColor *colorOfTitle;

/* For remind label */
@property (nonatomic, strong) NSString *remindText;
@property (nonatomic, strong) UIFont *fontOfRemindText;
@property (nonatomic) CGFloat rightMarginOfRemindLabel;
@property (nonatomic, strong) UIColor *colorOfRemindText;

/* For accessory image view */
@property (nonatomic) ZJYTableViewCellAccessoryType accessoryTypeZJY;
@property (nonatomic) CGFloat rightMarginOfAccessory;

/// init with custom style
- (instancetype)initWithZJYStyle:(ZJYTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
