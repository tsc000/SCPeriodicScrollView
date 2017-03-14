//
//  SCPeriodicScrollViewWordADCell.m
//  SCPeriodicScrollView
//
//  Created by tsc on 16/11/23.
//  Copyright © 2016年 DMS. All rights reserved.
//

#import "SCPeriodicScrollViewWordADCell.h"

#define HorizontalMargin (16.0)

@interface SCPeriodicScrollViewWordADCell ()

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) UIView *wordContainer;

@end

@implementation SCPeriodicScrollViewWordADCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    [self setupWordContainer];

    [self textLabel];
    
    self.textHorizontalAlignment = SCTextHorizontalAlignmentCenter;
}

- (void)setupWordContainer {
    
    UIView *wordContainer = [[UIView alloc] initWithFrame:CGRectZero];
    
    wordContainer.userInteractionEnabled = false;
    
    wordContainer.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:wordContainer];
    
    _wordContainer = wordContainer;
}

- (void)setText:(NSString *)text {

    _text = text;
    
    self.textLabel.text = _text;
    
    self.textLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)setTextColor:(UIColor *)textColor {

    _textColor = textColor;
    
    self.textLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {

    _textFont = textFont;
    
    self.textLabel.font = textFont;
}

- (void)setTextX:(CGFloat)textX {

    _textX = textX;
    
    CGRect frame = self.textLabel.frame;
    
    frame.origin.x = _textX;
    
    self.textLabel.frame = frame;
}

- (void)setTextHorizontalAlignment:(SCTextHorizontalAlignment)textHorizontalAlignment {

    _textHorizontalAlignment = textHorizontalAlignment;
    
    switch (_textHorizontalAlignment) {
        case SCTextHorizontalAlignmentLeft:
            
            self.textLabel.frame = CGRectMake(HorizontalMargin, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
            
            self.textLabel.textAlignment = NSTextAlignmentLeft;
            
            break;
            
        case SCTextHorizontalAlignmentCenter: {
            
            self.textLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
            
            self.textLabel.center = self.contentView.center;
            
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            
            break;
        }
 
        case SCTextHorizontalAlignmentRight:
            
            self.textLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width - HorizontalMargin, self.contentView.frame.size.height);
            
            self.textLabel.textAlignment = NSTextAlignmentRight;
            
            break;
    }
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.wordContainer.frame = self.contentView.frame;
    
    _order?[self setTextHorizontalAlignment:self.textHorizontalAlignment]:[self setTextX:self.textX];
}

#pragma mark - Lazy Load

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        UILabel *textLabel = [[UILabel alloc] init];
        
        textLabel.userInteractionEnabled = false;
        
        textLabel.textColor = [UIColor blackColor];
        
        textLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:textLabel];
        
        _textLabel = textLabel;
    }
    return _textLabel;
}

@end
