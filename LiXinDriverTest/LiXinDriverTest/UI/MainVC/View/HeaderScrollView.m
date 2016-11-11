//
//  HeaderScrollView.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/9.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "HeaderScrollView.h"

@interface HeaderScrollView ()<RPRingedPagesDelegate, RPRingedPagesDataSource>

@property (nonatomic, strong) RPRingedPages *pages;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HeaderScrollView



- (RPRingedPages *)pages {
    if (_pages == nil) {
        CGRect pagesFrame = CGRectMake(0, MATCHSIZE(10), SCREEN_W, MATCHSIZE(300));
        
        RPRingedPages *pages = [[RPRingedPages alloc] initWithFrame:pagesFrame];
        CGFloat height = pagesFrame.size.height - pages.pageControlHeight - pages.pageControlMarginTop - pages.pageControlMarginBottom;
        pages.carousel.mainPageSize = CGSizeMake(height*1.5, height);
        pages.carousel.pageScale = 0.6;
        pages.dataSource = self;
        pages.delegate = self;

        _pages = pages;
    }
    return _pages;
}



- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pages];
    [self makeDataSource];
    [self.pages reloadData];
}

- (void)makeDataSource {
    for (int i=0; i<4; i++) {
        
        [self.dataSource addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfItemsInRingedPages:(RPRingedPages *)pages {
    return self.dataSource.count;
}
- (UIView *)ringedPages:(RPRingedPages *)pages viewForItemAtIndex:(NSInteger)index {
    
    UIImageView *imageView = (UIImageView *)[pages dequeueReusablePage];
    if (![imageView isKindOfClass:[UIImageView class]]) {
        imageView = [[UIImageView alloc] init];
    }
    imageView.image = self.dataSource[index];
    return imageView;
}
- (void)didSelectedCurrentPageInPages:(RPRingedPages *)pages {
    NSLog(@"pages selected, the current index is %zd", pages.currentIndex);
}
- (void)pages:(RPRingedPages *)pages didScrollToIndex:(NSInteger)index {
//    NSLog(@"pages scrolled to index: %zd", index);
}


@end
