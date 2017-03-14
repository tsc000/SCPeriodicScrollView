//
//  SCPeriodicScrollView.h
//  SCPeriodicScrollView
//
//  Created by tsc on 16/11/17.
//  Copyright © 2016年 童世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPeriodicScrollViewWordADCell.h"

typedef enum {
    
    SCPageControlHorizontalAlignmentLeft = 0,
    SCPageControlHorizontalAlignmentCenter,
    SCPageControlHorizontalAlignmentRight
    
} SCPageControlHorizontalAlignment;

@class SCPeriodicScrollView;

@protocol SCPeriodicScrollViewDelegate <NSObject>

@optional

- (void)periodicScrollView:(SCPeriodicScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface SCPeriodicScrollView : UIView

@property (nonatomic, weak) id<SCPeriodicScrollViewDelegate> delegate;

#pragma mark - UIPageControl相关

@property (nonatomic, assign) BOOL pageControlHidden;

@property (nonatomic, weak) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, weak) UIColor *pageIndicatorTintColor;

///pageControlOrigin 和 pageControlHorizontalAlignment 最后设置的有效
//事先分配好的分页控件的位置，左 中 右
@property (nonatomic, assign) SCPageControlHorizontalAlignment pageControlHorizontalAlignment;

//下面两个是根据需要调整分页控件的位置
@property (nonatomic, assign) CGPoint pageControlOrigin;

@property (nonatomic, readonly, assign) CGFloat pageControlWidth;

#pragma mark - 显示文字相关

@property (nonatomic, assign) BOOL textHidden;

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, strong) NSArray *textArray;

//下面四个属性只对纯文本有效
@property (nonatomic, weak) UIColor *textColor;

@property (nonatomic, weak) UIFont *textFont;

//textX 和 textHorizontalAlignment 最后设置的有效
@property (nonatomic, assign) CGFloat textX;

@property (nonatomic, assign) SCTextHorizontalAlignment textHorizontalAlignment;

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/**初始化图片的类方法*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray placeholderImage:(UIImage *)placeholderImage Delegate:(id<SCPeriodicScrollViewDelegate>) delegate;

/**初始化图片和文字的类方法*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray placeholderImage:(UIImage *)placeholderImage textArray:(NSArray *)textArray Delegate:(id<SCPeriodicScrollViewDelegate>) delegate;

/**只有文字,设置此功能，图片等不再会显示*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame textArray:(NSArray *)textArray Delegate:(id<SCPeriodicScrollViewDelegate>) delegate;

+ (void)clearPeriodicScrollViewCache;

@end
