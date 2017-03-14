//
//  SCPeriodicScrollView.m
//  SCPeriodicScrollView
//
//  Created by tsc on 16/11/17.
//  Copyright © 2016年 童世超. All rights reserved.
//

///1 内部设置定时时间interval不会执行set方法,只有在外部设置interval和imagesArray才会触发设置定时器
///2

#import "SCPeriodicScrollView.h"
#import "SCPeriodicScrollViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#define SCPeriodicScrollViewCellID @"SCPeriodicScrollViewCellID"

#define SCPeriodicScrollViewWordADCellID @"SCPeriodicScrollViewWordADCellID"

#define SCPeriodicScrollViewCycleIndex (200)

#define PageControlHeight (37.0)

#define HorizontalMargin (16.0)

typedef enum {
    
    SCPeriodicScrollViewTypeImage = 0,
    SCPeriodicScrollViewTypeWord
    
} SCPeriodicScrollViewType;

@interface SCPeriodicScrollView ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    NSInteger _currentIndex;
    NSInteger _order;
}

@property (nonatomic, assign) SCPeriodicScrollViewType type;

//设置背景色 默认alpha = 1;
@property (nonatomic, assign) CGFloat tempAlpha;
@end

@implementation SCPeriodicScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialization];
    }
    return self;
}

#pragma mark - 初始化
- (void)initialization {

    [self setupUI];

    _order = 1;
    
    _currentIndex = -1;

    self.tempAlpha = 1;
    
    self.backgroundColor = [UIColor whiteColor]; //默认文字颜色
    
    self.textHidden = true; //默认隐藏图片中的文字
    
    _interval = 1.0; //默认定时时间
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; //默认水平滚动
    
    self.pageControlHorizontalAlignment = SCPageControlHorizontalAlignmentCenter; //默认pageControle水平居中
    
    self.textHorizontalAlignment = SCTextHorizontalAlignmentCenter; //默认文字水平居左
}

- (void)setupTimer{

    if (_timer) return;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(roll) userInfo:nil repeats:true];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    _timer = timer;
}

- (void)disableTimer {

    if (!_timer) return;
    
    [_timer invalidate];
    
    _timer = nil;
}

- (void)roll {

    _currentIndex ++;

    NSInteger count = self.type == SCPeriodicScrollViewTypeImage ? self.imagesArray.count : self.textArray.count;
    
    if (_currentIndex == count * SCPeriodicScrollViewCycleIndex) {
        
        _currentIndex = 0;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:false];
    }
    else {
    
        if (count == 0) return;

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:true];
    }
}

- (void)setupUI {

    [self collectionView];
    
    [self setupPageControl];
}

- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - HorizontalMargin, 0, 0)];
    
    //设置默认当前显示点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];

    [self addSubview:pageControl];
    
    _pageControl = pageControl;
}

/**初始化图片的类方法*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray placeholderImage:(UIImage *)placeholderImage Delegate:(id<SCPeriodicScrollViewDelegate>) delegate{

    SCPeriodicScrollView *scrollView = [[self alloc] initWithFrame:frame];
    
    scrollView.placeholderImage = placeholderImage;
    
    scrollView.imagesArray = imagesArray;
    
    scrollView.delegate = delegate;
    
    scrollView.type = SCPeriodicScrollViewTypeImage;
    
    return scrollView;
}

/**初始化图片和文字的类方法*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray placeholderImage:(UIImage *)placeholderImage textArray:(NSArray *)textArray Delegate:(id<SCPeriodicScrollViewDelegate>) delegate {

    SCPeriodicScrollView *scrollView = [[self alloc] initWithFrame:frame];
    
    scrollView.placeholderImage = placeholderImage;
    
    scrollView.imagesArray = imagesArray;
    
    scrollView.delegate = delegate;
    
    scrollView.type = SCPeriodicScrollViewTypeImage;
    
    return scrollView;
}

/**只有文字,设置此功能，图片等不再会显示*/
+ (instancetype)periodicScrollViewWithFrame:(CGRect)frame textArray:(NSArray *)textArray Delegate:(id<SCPeriodicScrollViewDelegate>) delegate {

    SCPeriodicScrollView *scrollView = [[self alloc] initWithFrame:frame];
    
    scrollView.textArray = textArray;
    
    scrollView.delegate = delegate;
    
    scrollView.pageControlHidden = true;
    
    scrollView.type = SCPeriodicScrollViewTypeWord;
    
    return scrollView;
}

+ (void)clearPeriodicScrollViewCache{
    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
}

- (void)layoutSubviews {

    [super layoutSubviews];

    if (self.type == SCPeriodicScrollViewTypeImage) {
        [self setImagesArray:self.imagesArray];
    }
    else {
        [self setTextArray:self.textArray];
    }
}

- (CGFloat)pageControlWidth {

    return _pageControl.frame.size.width;
}

- (BOOL)updateSettingWithData:(NSArray *)dataArray {

    _currentIndex = SCPeriodicScrollViewCycleIndex / 2.0 * dataArray.count;

    if (dataArray.count == 0 || dataArray == nil) {

        if (self.type == SCPeriodicScrollViewTypeImage && self.placeholderImage) {
            _imagesArray = @[self.placeholderImage];
        }
        
    }
    
    //是否有数据都要刷新
    [_collectionView reloadData];
    
    if (dataArray.count == 0 || dataArray == nil || dataArray.count == 1) {
        
        [self disableTimer];
        
        //防止手动滑动启动定时器
        _collectionView.scrollEnabled = false;
        
        _pageControl.hidden = true;
        
        return false;
    }
    
    //更换图片时除去定时器再重新创建
    [self disableTimer];

    [self setupTimer];

    _collectionView.scrollEnabled = true;
    
    _currentIndex = SCPeriodicScrollViewCycleIndex / 2.0 * dataArray.count;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:false];
    
    return true;
}

#pragma mark -
#pragma mark set方法

- (void)setImagesArray:(NSArray *)imagesArray {

    //SCPeriodicScrollViewTypeWord类型不作处理
    if (self.type == SCPeriodicScrollViewTypeWord) return;

    _imagesArray = imagesArray;
    
    if (![self updateSettingWithData:_imagesArray]) return;

    _pageControl.numberOfPages = _imagesArray.count;//总的图片页数
    
    _pageControl.currentPage = 0;
    
    _pageControl.hidden = false;
    
    CGRect frame = _pageControl.frame;
    
    frame.size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    
    _pageControl.frame = frame;
    
    if (self.pageControlOrigin.y) return;
    
    //更改图片数量时要随时更改分页控件的位置
    [self setPageControlHorizontalAlignment:self.pageControlHorizontalAlignment];
}

- (void)setTextArray:(NSArray *)textArray {

    _textArray = textArray;
    
    self.textHidden = false;
    
    if (self.type == SCPeriodicScrollViewTypeImage) {
        
        if (_textArray.count == _imagesArray.count) return;
        
        //如果_textArray比imagesArray多，不做处理
        if (_textArray.count < _imagesArray.count) {
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:_textArray];
            
            for (NSInteger i = 0; i < _imagesArray.count - _textArray.count; i++) {
                
                [array addObject:@""];
            }
            _textArray = [NSArray arrayWithArray:array];

        }
    }
    else if(self.type == SCPeriodicScrollViewTypeWord) {
        
        [self updateSettingWithData:_textArray];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {

    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;

}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {

    _pageIndicatorTintColor = pageIndicatorTintColor;

    _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;

}

- (void)setPageControlOrigin:(CGPoint)pageControlOrigin {

    _pageControlOrigin = pageControlOrigin;
    
    CGRect frame = _pageControl.frame;
    
    frame.origin = _pageControlOrigin;
    
    _pageControl.frame = frame;
}

- (void)setPageControlHorizontalAlignment:(SCPageControlHorizontalAlignment)pageControlHorizontalAlignment {

    _pageControlHorizontalAlignment = pageControlHorizontalAlignment;
    
    switch (_pageControlHorizontalAlignment) {
            
        case SCPageControlHorizontalAlignmentLeft: {
        
            CGRect frame = _pageControl.frame;
            
            frame.origin.y = self.frame.size.height - PageControlHeight;
            
            frame.origin.x = HorizontalMargin;

            _pageControl.frame = frame;
            
            break;
        }
        case SCPageControlHorizontalAlignmentCenter: {
        
            CGPoint center = _pageControl.center;
            
            center.x = self.center.x;
            
            _pageControl.center = center;
            
            CGRect frame = _pageControl.frame;
            
            frame.origin.y = self.frame.size.height - PageControlHeight;
            
            _pageControl.frame = frame;
            
            break;
        }
        case SCPageControlHorizontalAlignmentRight: {
            
            CGRect frame = _pageControl.frame;
            
            frame.origin.y = self.frame.size.height - PageControlHeight;
            
            frame.origin.x = self.frame.size.width - HorizontalMargin - _pageControl.frame.size.width;
            
            _pageControl.frame = frame;
            
            break;
        }
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {

    _scrollDirection = scrollDirection;
    
    _flowLayout.scrollDirection = _scrollDirection;
}

- (void)setPageControlHidden:(BOOL)pageControlHidden {

    _pageControlHidden = pageControlHidden;
    
    _pageControl.hidden = _pageControlHidden;
}

- (void)setInterval:(CGFloat)interval {

    _interval = interval;
    
    [self disableTimer];
    
//    [self setupTimer];
}

- (void)setAlpha:(CGFloat)alpha {

    self.tempAlpha = alpha;
    
    if (alpha == 1) {
        
        [super setAlpha:alpha];
        
        return;
    }

    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];

}

- (void)setBackgroundColor:(UIColor *)backgroundColor {

    if (!backgroundColor) {
        backgroundColor = [UIColor whiteColor];
    }
    
    if (self.tempAlpha == 1) {
        [super setBackgroundColor:backgroundColor];
    }
    else
        [super setBackgroundColor:[backgroundColor colorWithAlphaComponent:self.tempAlpha]];

}

- (void)setTextX:(CGFloat)textX {

    _textX = textX;
    
    _order = 0;
}

- (void)setTextHorizontalAlignment:(SCTextHorizontalAlignment)textHorizontalAlignment {

    _textHorizontalAlignment = textHorizontalAlignment;
    
    _order = 1;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.type == SCPeriodicScrollViewTypeImage ? self.imagesArray.count * SCPeriodicScrollViewCycleIndex : self.textArray.count * SCPeriodicScrollViewCycleIndex;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.type == SCPeriodicScrollViewTypeWord) {
        SCPeriodicScrollViewWordADCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SCPeriodicScrollViewWordADCellID forIndexPath:indexPath];
        
        cell.text = self.textArray[indexPath.row % (self.textArray.count)];
        
        if (self.textColor) {
            cell.textColor = self.textColor;
        }
        
        if (self.textFont) {
            cell.textFont = self.textFont;
        }
        
        cell.order = _order;

        if (_order == 0) {
            if (self.textX) {
                cell.textX = self.textX;
            }
        }
        else {
        
            if (self.textHorizontalAlignment) {
                cell.textHorizontalAlignment = self.textHorizontalAlignment;
            }
        }

        cell.backgroundColor = self.backgroundColor;
        
        return cell;
    }
    else {
    
        SCPeriodicScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SCPeriodicScrollViewCellID forIndexPath:indexPath];
        
        _pageControl.currentPage = _currentIndex % self.imagesArray.count;
        
        cell.placeholderImage = self.placeholderImage;
        
        cell.image = self.imagesArray[indexPath.row % (self.imagesArray.count)];

        if (!self.textHidden) {
            cell.text = self.textArray[indexPath.row % (self.textArray.count)];
        }
        
        return cell;
    }
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger count = self.type == SCPeriodicScrollViewTypeImage ? self.imagesArray.count : self.textArray.count;
    
    if ([self.delegate respondsToSelector:@selector(periodicScrollView:didSelectItemAtIndex:)]) {
        [self.delegate periodicScrollView:self didSelectItemAtIndex:indexPath.row % count];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.hidden) return;
    
    NSInteger count = self.type == SCPeriodicScrollViewTypeImage ? self.imagesArray.count : self.textArray.count;
    
    if (count == 0) return;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        if (scrollView.contentOffset.y == 0) {
            
            _currentIndex = 0;
        }
        else if (scrollView.contentOffset.y == (count - 1) * self.frame.size.height) {
            
            _currentIndex = count - 1;
        }
        else
            _currentIndex =  (scrollView.contentOffset.y + scrollView.frame.size.height / 2.0 ) / scrollView.frame.size.height;
   
    }
    else {
    
        if (scrollView.contentOffset.x == 0) {
            
            _currentIndex = 0;
        }
        else if (scrollView.contentOffset.x == (count - 1) * self.frame.size.width) {
            
            _currentIndex = count - 1;
        }
        else
            _currentIndex =  (scrollView.contentOffset.x + scrollView.frame.size.width / 2.0 ) / scrollView.frame.size.width;
        
    }
    
    _pageControl.currentPage = _currentIndex % count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self disableTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self setupTimer];
}

#pragma mark - Lazy Load

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = self.frame.size;
        
        flowLayout.minimumLineSpacing = 0;
        
        flowLayout.minimumInteritemSpacing = 0;
        
        //妈蛋frame写成self.frame，层级位置不正确
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        
        collectionView.backgroundColor = [UIColor clearColor];
        
        collectionView.pagingEnabled = true;
        
        collectionView.showsVerticalScrollIndicator = false;
        
        collectionView.showsHorizontalScrollIndicator = false;
        
        [collectionView registerClass:[SCPeriodicScrollViewCell class] forCellWithReuseIdentifier:SCPeriodicScrollViewCellID];
        
        [collectionView registerClass:[SCPeriodicScrollViewWordADCell class] forCellWithReuseIdentifier:SCPeriodicScrollViewWordADCellID];
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
        
        [self addSubview:collectionView];
        
        _flowLayout = flowLayout;
        
        _collectionView = collectionView;
    }
    
    return _collectionView;
}

@end
