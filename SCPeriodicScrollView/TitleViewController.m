//
//  TitleViewController.m
//  SCPeriodicScrollView
//
//  Created by tsc on 17/1/13.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "TitleViewController.h"
#import "SCPeriodicScrollView.h"

@interface TitleViewController ()<SCPeriodicScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, strong) SCPeriodicScrollView *vScrollViewWord;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewWordV;

@property (nonatomic, strong) NSArray* textArray;

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupScrollViewContainer];
    
    [self hScrollViewWithWord];
    
    [self scrollViewWithWordVertical];
}

- (void)setupScrollViewContainer {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"333.jpeg"];
    
    [self.view addSubview:imageView];
    
    self.scrollViewContainer = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    self.scrollViewContainer.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.scrollViewContainer];
    
}


- (void)hScrollViewWithWord {
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];
    
    self.vScrollViewWord = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) textArray:self.textArray Delegate:self];
    
    self.vScrollViewWord.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.vScrollViewWord.textHorizontalAlignment = SCTextHorizontalAlignmentCenter;
    
    self.vScrollViewWord.textFont = [UIFont systemFontOfSize:18];
    
    self.vScrollViewWord.textColor = [UIColor whiteColor];
    
    self.vScrollViewWord.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    self.vScrollViewWord.alpha = 0.5;
    
    [self.scrollViewContainer addSubview:self.vScrollViewWord];

}


- (void)scrollViewWithWordVertical {
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];

    self.scrollViewWordV = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 40) textArray:self.textArray Delegate:self];
    
    self.scrollViewWordV.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.scrollViewWordV.interval = 2.0;
    
    [self.scrollViewContainer addSubview:self.scrollViewWordV];
}

- (void)periodicScrollView:(SCPeriodicScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
}
@end
