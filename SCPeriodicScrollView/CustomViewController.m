//
//  CustomViewController.m
//  SCPeriodicScrollView
//
//  Created by tsc on 16/12/1.
//  Copyright © 2016年 DMS. All rights reserved.
//

#import "CustomViewController.h"
#import "SCPeriodicScrollView.h"

@interface CustomViewController ()
<
SCPeriodicScrollViewDelegate
>

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewWord;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewWordV;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewImage;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewImageAndWord;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewCustomPagecontrol;

@property (nonatomic, strong) NSArray* imagesArray;

@property (nonatomic, strong) NSArray* textArray;

@property (nonatomic, strong) NSArray* wordArray;

@property (nonatomic, strong) UIScrollView *scrollViewContainer;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollViewContainer];
    
    [self scrollViewWithImage];
    
    [self scrollViewWithImageAndWord];
    //
    [self scrollViewWithCustomPageControlAlignment];
    
    [self scrollViewWithWord];
    
    [self scrollViewWithWordVertical];

}

- (void)setupScrollViewContainer {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"333.jpeg"];
    
    [self.view addSubview:imageView];
    
    self.scrollViewContainer = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    self.scrollViewContainer.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    
    [self.view addSubview:self.scrollViewContainer];
    
}

- (void)scrollViewWithWord {
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];
    self.imagesArray = @[@"http://img04.tooopen.com/images/20130617/tooopen_21382885.jpg",
                         @"http://img06.tooopen.com/images/20160723/tooopen_sy_171446527429.jpg",
                         @"http://img02.tooopen.com/images/20151217/tooopen_sy_151831581886.jpg",
                         ];
    
    self.scrollViewWord = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 720, self.view.frame.size.width, 40) textArray:nil Delegate:self];
    
    self.scrollViewWord.imagesArray = self.imagesArray;
    
    self.scrollViewWord.textArray = self.textArray;
    
    self.scrollViewWord.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.scrollViewWord.textHorizontalAlignment = SCTextHorizontalAlignmentCenter;
    
    self.scrollViewWord.textFont = [UIFont systemFontOfSize:18];
    
    self.scrollViewWord.textColor = [UIColor whiteColor];
    
    self.scrollViewWord.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    self.scrollViewWord.alpha = 0.5;
    
    [self.scrollViewContainer addSubview:self.scrollViewWord];
    
    UILabel *test = [[UILabel alloc] init];
    
    test.backgroundColor = [UIColor redColor];
    test.text = @"2222";
    
    [test sizeToFit];
    //    [self.scrollViewWord addSubview:test];
}

- (void)scrollViewWithWordVertical {
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];
    
    self.imagesArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    self.scrollViewWordV = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 800, self.view.frame.size.width, 40) textArray:self.textArray Delegate:self];
    
    self.scrollViewWordV.imagesArray = self.imagesArray;
    
    self.scrollViewWordV.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.scrollViewWordV.interval = 2.0;
    
    [self.scrollViewContainer addSubview:self.scrollViewWordV];
}

- (void)scrollViewWithCustomPageControlAlignment {
    
    self.imagesArray = @[
                         @"http://img.woyaogexing.com/2016/11/18/b799e2ac29fa75da!600x600.jpg",
                         @"http://img.woyaogexing.com/2016/11/18/d1258f8d911deae7!600x600.jpg",
                         @"http://img.woyaogexing.com/2016/11/10/e8f9c85e4622aa40!600x600.jpg",
                         @"http://img.woyaogexing.com/2016/09/26/453db521eb5273ac!600x600.jpg",
                         @"http://img.woyaogexing.com/2016/09/26/1a187eaa1f29d059!600x600.jpg",
                         @"http://img.woyaogexing.com/2016/09/26/20c6c0ca73b32aa5!600x600.jpg",
                         ];
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];
    
    self.scrollViewCustomPagecontrol = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 480, self.view.frame.size.width, 200) imagesArray:nil placeholderImage:nil Delegate:self];
    
    self.scrollViewCustomPagecontrol.imagesArray = self.imagesArray;
    
    self.scrollViewCustomPagecontrol.textArray = self.textArray;
    
    self.scrollViewCustomPagecontrol.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.scrollViewCustomPagecontrol.pageControlOrigin = CGPointMake((self.view.frame.size.width - self.scrollViewCustomPagecontrol.pageControlWidth)/2.0, 200-40-30);
    
    [self.scrollViewContainer addSubview:self.scrollViewCustomPagecontrol];
}

- (void)scrollViewWithImageAndWord {
    
    self.imagesArray = @[
                         @"11",
                         @"22",
                         @"33",
                         @"44",
                         @"55"
                         ];
    
    self.textArray = @[@"这是一个轮播图",@"这是一个轮播图",@"欢迎交流",@"交流QQ:767616124"];
    
    self.scrollViewImageAndWord = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 200) imagesArray:nil placeholderImage:nil  Delegate:self];
    
    self.scrollViewImageAndWord.imagesArray = self.imagesArray;
    
    self.scrollViewImageAndWord.textArray = self.textArray;
    
    self.scrollViewImageAndWord.pageControlHorizontalAlignment = SCPageControlHorizontalAlignmentRight;
    
    self.scrollViewImageAndWord.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.scrollViewContainer addSubview:self.scrollViewImageAndWord];
}

- (void)scrollViewWithImage {
    
    self.imagesArray = @[@"http://bpic.588ku.com/poster_pic/00/00/12/01566d34b5c3b9a.jpg!qianku1198",
                         @"http://bpic.588ku.com/back_pic/00/05/11/585625e9992cfcc.JPG",
                         @"http://bpic.588ku.com/back_pic/00/02/20/835614932ecdba8.jpg",
                         @"http://zhsq2dev.loganwy.com/upload/adminbanner/3DE26E65-5E9A-8CD7-A8CF-813A173FE3E9/20161126/A4453E53-CDED-A7E9-43A4-059237DE551F.jpg"
                         ];
    
    //    self.imagesArray = @[@"http://bpic.588ku.com/poster_pic/00/00/12/01566d34b5c3b9a.jpg!qianku1198"
    //                         ];
    self.scrollViewImage = [SCPeriodicScrollView periodicScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imagesArray:nil placeholderImage:[UIImage imageNamed:@"placeHolder.jpeg"] Delegate:self];
    
    self.scrollViewImage.imagesArray = self.imagesArray;
    
    self.scrollViewImage.pageControlHorizontalAlignment = SCPageControlHorizontalAlignmentCenter;
    
    self.scrollViewImage.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.scrollViewContainer addSubview:self.scrollViewImage];
}

#pragma mark - SCPeriodicScrollViewDelegate

- (void)periodicScrollView:(SCPeriodicScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
