//
//  ZJYTableViewCell.m
//
//  Created by ZhuJiyang on 7/21/15.
//  Copyright (c) 2015 ZhuJiyang. All rights reserved.
//

#import "ZJYTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const CGFloat heightOfHeaderLine = 1.0;
static const CGFloat heightOfFooterLine = 1.0;
static const CGFloat heightOfSeparatorLine = 1.0;
static const int colorOfHeaderLine = 0xcccccc;
static const int colorOfFooterLine = 0xcccccc;
static const int colorOfSeparatorLine = 0xc8c7cc;

@interface ZJYTableViewCell ()

@property (nonatomic) ZJYTableViewCellStyle cellStyle;

/* lines */
@property (nonatomic, strong) UIView *headerLine;
@property (nonatomic, strong) UIView *footerLine;
@property (nonatomic, strong) UIView *separatorLine;

/* title */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSLayoutConstraint *leftConstraintForTitleLabel;

/* remindLabel */
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraintForRemindLabel;

/* accessory */
@property (nonatomic, strong) UIImageView *accessoryImageView;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraintForAccessoryImageView;



@end

@implementation ZJYTableViewCell

- (instancetype)initWithZJYStyle:(ZJYTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.cellStyle = style;
        [self initDefaultValues];
        [self initFrame];
    }
    
    return self;
}

- (void)initDefaultValues {
    _leftMarginOfTitle = 19*[[UIScreen mainScreen] scale];
    _rightMarginOfRemindLabel = 30*[[UIScreen mainScreen] scale];
    _rightMarginOfAccessory = 19*[[UIScreen mainScreen] scale];
    
    if (!_fontOfTitle) {
        _fontOfTitle = [UIFont systemFontOfSize:14.0*[[UIScreen mainScreen] scale]];
    }
    
    if (!_fontOfRemindText) {
        _fontOfRemindText = [UIFont systemFontOfSize:14.0*[[UIScreen mainScreen] scale]];
    }
    
    _accessoryTypeZJY = ZJYTableViewCellAccessoryNone;
}

- (void)initFrame {
    if (!self.cellStyle) {
        self.cellStyle = ZJYTableViewCellStyleNone;
    }
    
    /* General */
    [self initSeparatorLine];
    
    switch (self.cellStyle) {
        case ZJYTableViewCellStyleNone:
            
            break;
        case ZJYTableViewCellStyleDefault:
            [self initTitleLabel];
            [self initRemindLabel];
            //[self drawAccessoryView];
            break;
        default:
            
            break;
    }
}

- (void)drawHeaderLine {
    if (self.headerLine) {
        return;
    }
    // init
    UIView *headerLine = [[UIView alloc] init];
    headerLine.backgroundColor = UIColorFromRGB(colorOfHeaderLine);
    headerLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:headerLine];
    self.headerLine = headerLine;
    
    // auto layout
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:headerLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:headerLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:headerLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:headerLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heightOfHeaderLine/[[UIScreen mainScreen] scale]];
    [self.contentView addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
}

- (void)drawFooterLine {
    if (self.separatorLine) {
        self.separatorLine.hidden = YES;
    }
    
    if (self.footerLine) {
        self.footerLine.hidden = NO;
        return;
    }
    
    // init
    UIView *footerLine = [[UIView alloc] init];
    footerLine.backgroundColor = UIColorFromRGB(colorOfFooterLine);
    footerLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:footerLine];
    self.footerLine = footerLine;
    
    // auto layout
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:footerLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:footerLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:footerLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:footerLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heightOfFooterLine /[[UIScreen mainScreen] scale]];
    [self.contentView addConstraints:@[leftConstraint, rightConstraint, bottomConstraint, heightConstraint]];
}

/**
 * 初始化时调用
 */
- (void)initSeparatorLine {
    if (self.footerLine) {
        self.footerLine.hidden = YES;
    }
    
    if (self.separatorLine) {
        self.separatorLine.hidden = NO;
        return;
    }
    
    // init
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = UIColorFromRGB(colorOfSeparatorLine);
    separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:separatorLine];
    self.separatorLine = separatorLine;
    
    // auto layout
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10*[[UIScreen mainScreen] scale]];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10*[[UIScreen mainScreen] scale]];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heightOfSeparatorLine /[[UIScreen mainScreen] scale]];
    [self.contentView addConstraints:@[leftConstraint, rightConstraint, bottomConstraint, heightConstraint]];
}

#pragma mark - General Methods
- (void)refreshView {
    [self setNeedsLayout];
    //[self layoutIfNeeded];
}

#pragma mark - ZJYTableViewCellStyleDefault
/**
 * 初始化时调用，之后通过 [self refreshView]来更新
 */
- (void)initTitleLabel {
    if (self.titleLabel) {
        return;
    }
    
    // init
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = self.fontOfTitle;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // auto layout
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.leftMarginOfTitle];
    self.leftConstraintForTitleLabel = leftConstraint;
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[leftConstraint, centerYConstraint]];
}

/**
 * 初始化时调用，之后通过 [self refreshView]来更新
 */
- (void)initRemindLabel {
    if (self.remindLabel) {
        return;
    }

    
    // init
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.font = self.fontOfRemindText;
    remindLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:remindLabel];
    self.remindLabel = remindLabel;
    
    // auto layout
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:remindLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-1.0 * self.rightMarginOfRemindLabel];
    self.rightConstraintForRemindLabel = rightConstraint;
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:remindLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[rightConstraint, centerYConstraint]];
}

- (void)drawAccessoryView {
    if (self.accessoryImageView) {
        if (self.accessoryTypeZJY == ZJYTableViewCellAccessoryNone) {
            self.accessoryImageView.hidden = YES;
        }
        return;
    }
    
    // init
    UIImageView *accessoryImageView = [[UIImageView alloc] init];
    accessoryImageView.image = [UIImage imageNamed:@"arrow_next_page"];
    accessoryImageView.contentMode = UIViewContentModeScaleAspectFit;
    accessoryImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:accessoryImageView];
    
    // auto layout
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:accessoryImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant: -1 * self.rightMarginOfAccessory];
    self.rightConstraintForAccessoryImageView = rightConstraint;
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:accessoryImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:accessoryImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:6.5*[[UIScreen mainScreen] scale]];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:accessoryImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10*[[UIScreen mainScreen] scale]];
    [self.contentView addConstraints:@[rightConstraint, centerYConstraint, widthConstraint, heightConstraint]];
    
    [self refreshView];
}


#pragma mark - Setter Methods

#pragma mark -lines
//
- (void)setIsFirstCell:(BOOL)isFirstCell {
    
    _isFirstCell = isFirstCell;
    if (isFirstCell) {
        [self drawHeaderLine];
    }
}

//
- (void)setIsLastCell:(BOOL)isLastCell {
    
    _isLastCell = isLastCell;
    if (isLastCell) {
        [self drawFooterLine];
    }
}

#pragma mark -title label

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setFontOfTitle:(UIFont *)fontOfTitle {
    _fontOfTitle = fontOfTitle;
    _titleLabel.font = fontOfTitle;
}

- (void)setLeftMarginOfTitle:(CGFloat)leftMarginOfTitle {
    _leftMarginOfTitle = leftMarginOfTitle;
    self.leftConstraintForTitleLabel.constant = leftMarginOfTitle;
    [self refreshView];
}

- (void)setColorOfTitle:(UIColor *)colorOfTitle {
    _colorOfTitle = colorOfTitle;
    _titleLabel.textColor = colorOfTitle;
}

#pragma mark -remind label

- (void)setRemindText:(NSString *)remindText {
    _remindText = remindText;
    _remindLabel.text = remindText;
}

- (void)setFontOfRemindText:(UIFont *)fontOfRemindText {
    _fontOfRemindText = fontOfRemindText;
    _remindLabel.font = fontOfRemindText;
}

- (void)setRightMarginOfRemindLabel:(CGFloat)rightMarginOfRemindLabel {
    _rightMarginOfRemindLabel = rightMarginOfRemindLabel;
    self.rightConstraintForRemindLabel.constant = -1 * rightMarginOfRemindLabel;
    [self refreshView];
}

- (void)setColorOfRemindText:(UIColor *)colorOfRemindText {
    _colorOfRemindText = colorOfRemindText;
    _remindLabel.textColor = colorOfRemindText;
}

#pragma mark -accessory view

- (void)setAccessoryTypeZJY:(ZJYTableViewCellAccessoryType)accessoryTypeZJY {
    _accessoryTypeZJY = accessoryTypeZJY;
    [self drawAccessoryView];
}

- (void)setRightMarginOfAccessory:(CGFloat)rightMarginOfAccessory {
    _rightMarginOfAccessory = rightMarginOfAccessory;
    self.rightConstraintForAccessoryImageView.constant = -1 * rightMarginOfAccessory;
    [self refreshView];
}

#pragma mark -
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
