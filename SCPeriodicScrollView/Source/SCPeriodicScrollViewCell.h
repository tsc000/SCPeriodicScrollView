//
//  SCPeriodicScrollViewCell.h
//  SCPeriodicScrollView
//
//  Created by tongshichao on 16/11/20.
//  Copyright © 2016年 童世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPeriodicScrollViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) UIImage *placeholderImage;

@end
