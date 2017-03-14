//
//  SCPeriodicScrollViewCell.m
//  SCPeriodicScrollView
//
//  Created by tongshichao on 16/11/20.
//  Copyright © 2016年 童世超. All rights reserved.
//

#import "SCPeriodicScrollViewCell.h"
#import "UIImageView+WebCache.h"

#define PageControlHeight (37.0)
#define HorizontalMargin (16.0)

@interface SCPeriodicScrollViewCell ()
{
    UIImageView *_imageView;
}

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) UIView *textContainer;

@end

@implementation SCPeriodicScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupImageView];
    
    [self setupNoteContainer];
}

- (void)setupNoteContainer {
    
    UIView *textContainer = [[UIView alloc] init];
    
    textContainer.backgroundColor = [UIColor blackColor];
    
    textContainer.alpha = 0.6;
    
    [self.contentView addSubview:textContainer];
    
    _textContainer = textContainer;
    
    [self textLabel];
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    _imageView = imageView;

    [self.contentView addSubview:imageView];
}

- (BOOL)legalURL:(NSString *)URLString {
    
    if(!URLString) return false;
    
    NSString *urlRegex = @"^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+)\\.)+([A-Za-z]+)[/\?\\:]?.*$";
    
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    
    return [urlTest evaluateWithObject:URLString];
    
}

#pragma mark - set方法

-(void)setImage:(NSString *)image {

    _image = image;
    
    if ([image isKindOfClass:[UIImage class]]) {
        _imageView.image = (UIImage *)image;
    }
    else if ([self legalURL:image]) {
        
        NSURL *url = [NSURL URLWithString:image];

        [_imageView sd_setImageWithURL:url placeholderImage:self.placeholderImage];
    }
    else
        _imageView.image = [UIImage imageNamed:_image];
    
    if (!self.text) {
        self.textContainer.hidden = true;
    }
}

- (void)setText:(NSString *)text {

    _text = text;
    
    self.textLabel.text = text;
    
    self.textContainer.hidden = false;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _imageView.frame = self.contentView.frame;
    
    _textContainer.frame = CGRectMake(0, self.contentView.frame.size.height - PageControlHeight, self.contentView.frame.size.width, PageControlHeight);

    _textLabel.frame = CGRectMake(HorizontalMargin, 0, _textContainer.frame.size.width - HorizontalMargin, _textContainer.frame.size.height);

}

#pragma mark - Lazy Load

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        UILabel *textLabel = [[UILabel alloc] init];
        
        textLabel.textColor = [UIColor whiteColor];
    
        textLabel.font = [UIFont systemFontOfSize:15];

        [_textContainer addSubview:textLabel];
        
        _textLabel = textLabel;
    }
    return _textLabel;
}
@end
