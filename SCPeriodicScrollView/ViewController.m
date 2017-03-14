//
//  ViewController.m
//  SCPeriodicScrollView
//
//  Created by tsc on 16/11/17.
//  Copyright © 2016年 DMS. All rights reserved.
//

#import "ViewController.h"
#import "SCPeriodicScrollView.h"
#import "CustomViewController.h"


@interface ViewController ()
<
    SCPeriodicScrollViewDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *controllerArray;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewWord;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewImageAndWord;

@property (nonatomic, strong) SCPeriodicScrollView *scrollViewCustomPagecontrol;

@property (nonatomic, strong) NSArray* imagesArray;

@property (nonatomic, strong) NSArray* textArray;

@property (nonatomic, strong) NSArray* wordArray;

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, assign) BOOL changed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"图片轮播", @"自定义pageControl位置", @"文字轮播"];
    
    self.controllerArray = @[@"ImageViewController", @"CustomDotYViewController", @"TitleViewController"];
    
    self.title = @"轮播图";
    
    self.navigationController.navigationBar.translucent = false;
    
    [self tableView];

}



#pragma mark - SCPeriodicScrollViewDelegate

- (void)periodicScrollView:(SCPeriodicScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {

    NSLog(@"%ld",index);
}

#pragma mark --UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"tips"];
    
    return cell;
}

#pragma mark --UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Class class = NSClassFromString(self.controllerArray[indexPath.row]);
    
    UIViewController *viewController = [[class alloc] init] ;
    
    viewController.title = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:true];
}

#pragma mark -- lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];

        self.tableView = tableView;
        
        tableView.dataSource = self;
        
        tableView.delegate = self;
        
        tableView.rowHeight = 50;
        
        tableView.showsVerticalScrollIndicator = NO;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
        
        [self.view addSubview:tableView];
    }
    return _tableView;
}


@end
