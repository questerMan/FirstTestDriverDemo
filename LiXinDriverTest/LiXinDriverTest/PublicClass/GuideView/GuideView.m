//
//  GuideView.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "GuideView.h"

@interface GuideView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *page;

@property (nonatomic, strong) UIButton *goingBtn;

//广告页
@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, strong) NSTimer *time;

@end

@implementation GuideView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置默认值，避免崩溃
        [self initValue];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/** 懒加载 */
-(NSMutableArray *)arrayIMG{
    if (!_arrayIMG) {
        _arrayIMG = [NSMutableArray array];
    }
    return _arrayIMG;
}

-(UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc] init];
    }
    return _image;
}

-(void)initValue{
    
    self.isGuide = YES;
    
    [self.arrayIMG addObjectsFromArray:@[@"2",@"1",@"0",@"3",@"4"]];
    
}

-(UIButton *)goingBtn{
    if (!_goingBtn) {
        _goingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _goingBtn;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELF_W, SELF_H)];
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}

-(UIPageControl *)page{
    if (!_page) {
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake((SELF_W - MATCHSIZE(230))/2, SELF_H - MATCHSIZE(60), MATCHSIZE(230), MATCHSIZE(50))];
    }
    return _page;
}

-(void)creatGuideViewWithIsGuide:(BOOL)isGuide
{
    PublicTool *tool = [PublicTool shareInstance];
    
    if (!isGuide) {//不是引导页
        //在头部插入最后一个图片
        [self.arrayIMG insertObject:self.arrayIMG.lastObject atIndex:0];
        //在尾部插入第一张图片
        [self.arrayIMG addObject:self.arrayIMG[1]];
    }
    
    for (int i = 0; i < self.arrayIMG.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SELF_W, 0, SELF_W, SELF_H)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_arrayIMG[i]] placeholderImage:[tool scaleToSize:[UIImage imageNamed:self.arrayIMG[i] ] size:CGSizeMake(SELF_W, SELF_H)]];
        
        imageView.tag = 100 + i;
        
        [self.scrollView addSubview:imageView];
    }
    
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(self.arrayIMG.count*SELF_W, SELF_H);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView. bounces = NO;
    [self addSubview:self.scrollView];
    
    //图片标示控件
    self.page.numberOfPages = self.arrayIMG.count;
    //设置圆点的颜色
    self.page.pageIndicatorTintColor = DEFAULT_COLOR1;
    //设置被选中的圆点的颜色
    self.page.currentPageIndicatorTintColor = DEFAULT_COLOR3;
    //关闭用户交互功能
    self.page.userInteractionEnabled = NO;    self.page.currentPage = 0;
    [self addSubview:self.page];
    
    
    self.goingBtn.frame = CGRectMake((self.arrayIMG.count-1)*SELF_W + (SELF_W-MATCHSIZE(200))/2, SELF_H - MATCHSIZE(120), MATCHSIZE(200), MATCHSIZE(60));
    self.goingBtn.backgroundColor = RGBAlpha(174, 204, 12, 1);
    self.goingBtn.layer.cornerRadius = MATCHSIZE(30);
    [self.goingBtn setTintColor:RGBAlpha(255, 255, 255, 1)];
    [self.goingBtn addTarget:self action:@selector(goButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goingBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.goingBtn];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
}

#pragma mark - - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取移动的偏移定点坐标
    CGPoint offSet = scrollView.contentOffset;
    
    //根据坐标算出滚动到第几屏的位置下标
    NSInteger index = offSet.x/SELF_W;
    self.page.currentPage=index;
}

#pragma mark - 立刻体验按钮响应 / 立即跳过
- (void)goButtonAction:(UIButton*) button
{
    [self.image removeFromSuperview];
    [self.scrollView removeFromSuperview];
    [self.goingBtn removeFromSuperview];
    [self.page removeFromSuperview];
    [self removeFromSuperview];
    [self.time invalidate];
    
}
#pragma mark -
-(void)creatAdvert{
    
    self.image.frame = [UIScreen mainScreen].bounds;
    
    NSString *imageStr = @"http://m.fantastrip.cn/u/201508/10150402dibd.jpg";
    NSURL *url = [NSURL URLWithString:[PublicTool UTF8String:imageStr]];
    
    [self.image sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"1"] options:SDWebImageCacheMemoryOnly progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.image.userInteractionEnabled = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.image];
    
    self.goingBtn.frame = CGRectMake(SELF_W-MATCHSIZE(200), MATCHSIZE(50), MATCHSIZE(180), MATCHSIZE(50));
    self.goingBtn.backgroundColor = DEFAULT_COLOR;
    self.goingBtn.layer.cornerRadius = MATCHSIZE(20);
    [self.goingBtn setTintColor:RGBAlpha(255, 255, 255, 1)];
    self.goingBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    [self.goingBtn addTarget:self action:@selector(goButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goingBtn setTitle:@"立即跳过3s" forState:UIControlStateNormal];
    [self.image addSubview:self.goingBtn];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [self.image removeFromSuperview];
        [self.time invalidate];
        NSLog(@"3秒后添加到队列");
        
    });
    
    
    _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTouch:) userInfo:nil repeats:YES];
    
    
}

static int i = 3;
-(void)timeTouch:(NSTimer *)time{
    i -= 1;
    
    [self.goingBtn setTitle:[NSString stringWithFormat:@"立即跳过%ds",i] forState:UIControlStateNormal];
    
}


@end
