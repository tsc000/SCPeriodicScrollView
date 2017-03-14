//
//  ImageViewController.m
//  SCPeriodicScrollView
//
//  Created by tsc on 17/1/13.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "ImageViewController.h"
#import "SCPeriodicScrollView.h"

@interface ImageViewController () <SCPeriodicScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, strong) SCPeriodicScrollView *vScrollViewImage;

@property (nonatomic, strong) NSArray* imagesArray;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupScrollViewContainer];
    
    [self vScrollViewWithImage];
    
    [self setupButtons];
}

- (void)setupScrollViewContainer {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"333.jpeg"];
    
    [self.view addSubview:imageView];
    
    self.scrollViewContainer = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    self.scrollViewContainer.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.scrollViewContainer];
    
}

- (void)setupButtons {
    
    NSArray *tempArray = @[@"水平滚动", @"竖直滚动"];
    
    CGFloat width = (self.view.frame.size.width - 20 *2 - 20)/2;
    
    for (NSInteger i = 0;  i < 2 ; i ++) {
        
        UIButton *btn = [self buttonWithTitle:tempArray[i] NormalIMG:nil Tag:1000 + i];
        
        btn.backgroundColor = [UIColor redColor];

        btn.frame = CGRectMake(20 + (width + 20) * i,  200 + 50, width, 40);
        
        [self.scrollViewContainer addSubview:btn];

    }
}

//创建按钮
- (UIButton *)buttonWithTitle:(NSString *)title  NormalIMG:(NSString *)normal Tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = tag;
    
    return btn;
}

//切换状态按钮
- (void)buttonDidClick:(UIButton *)sender {
    
    if (sender.tag == 1001) {
        self.vScrollViewImage.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    else
        self.vScrollViewImage.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)vScrollViewWithImage {
    
    self.imagesArray = @[@"http://bpic.588ku.com/poster_pic/00/00/12/01566d34b5c3b9a.jpg!qianku1198",
                         @"http://bpic.588ku.com/back_pic/00/05/11/585625e9992cfcc.JPG",
                         @"http://bpic.588ku.com/back_pic/00/02/20/835614932ecdba8.jpg",
                         @"http://zhsq2dev.loganwy.com/upload/adminbanner/3DE26E65-5E9A-8CD7-A8CF-813A173FE3E9/20161126/A4453E53-CDED-A7E9-43A4-059237DE551F.jpg"
                         ];

    self.vScrollViewImage = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imagesArray:nil placeholderImage:[UIImage imageNamed:@"placeHolder.jpeg"] Delegate:self];
    
    self.vScrollViewImage.imagesArray = self.imagesArray;
    
    self.vScrollViewImage.pageControlHorizontalAlignment = SCPageControlHorizontalAlignmentCenter;
    
    self.vScrollViewImage.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.scrollViewContainer addSubview:self.vScrollViewImage];
}

- (void)periodicScrollView:(SCPeriodicScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
}

@end
