//
//  SCPeriodicScrollViewWordADCell.h
//  SCPeriodicScrollView
//
//  Created by tsc on 16/11/23.
//  Copyright © 2016年 DMS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    SCTextHorizontalAlignmentLeft = 1,
    SCTextHorizontalAlignmentCenter,
    SCTextHorizontalAlignmentRight
    
} SCTextHorizontalAlignment;

@interface SCPeriodicScrollViewWordADCell : UICollectionViewCell

@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) UIColor *textColor;

@property (nonatomic, weak) UIFont *textFont;

@property (nonatomic, assign) CGFloat textX;

@property (nonatomic, assign) NSInteger order;

@property (nonatomic, assign) SCTextHorizontalAlignment textHorizontalAlignment;

@end
