//
//  MapViewController.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/10.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITextFieldDelegate>
//地图
@property (nonatomic, strong) MAMapView *mapView;
//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
//搜索
@property (nonatomic, strong) AMapSearchAPI *search;
//起点
@property (nonatomic, strong) UITextField *startF;
//终点
@property (nonatomic, strong) UITextField *endF;
//大头针
@property (retain, nonatomic) MAPointAnnotation * pointAnnotation;

//中心图片
@property (nonatomic, strong) UIImageView *centerIMG;


@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;

@property (nonatomic, assign) BOOL selectePlace;//YES出发地  NO目的地  默认出发地YES

@property (nonatomic, strong) PublicTool *tool;

@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation MapViewController

-(UITextField *)startF{
    if (!_startF) {
        _startF = [[UITextField alloc] initWithFrame:CGRectMake(MATCHSIZE(40), MATCHSIZE(145), MATCHSIZE(SCREEN_W-80), MATCHSIZE(80))];
        _startF.leftViewMode=UITextFieldViewModeAlways;
        _startF.leftView = [[UIImageView alloc] initWithImage:[_tool scaleToSize:[UIImage imageNamed:@"location_center"] size:CGSizeMake(MATCHSIZE(50), MATCHSIZE(50))]];
        _startF.backgroundColor = [UIColor whiteColor];
        _startF.delegate = self;
        _startF.tag = 2000;
        _startF.placeholder = @"出发地";
        
    }
    return _startF;
}
-(UITextField *)endF{
    
    if (!_endF) {
        _endF = [[UITextField alloc] initWithFrame:CGRectMake(MATCHSIZE(40), MATCHSIZE(240), MATCHSIZE(SCREEN_W-80), MATCHSIZE(80))];
        _endF.leftViewMode=UITextFieldViewModeAlways;
        _endF.leftView = [[UIImageView alloc] initWithImage:[_tool scaleToSize:[UIImage imageNamed:@"location"] size:CGSizeMake(MATCHSIZE(50), MATCHSIZE(50))]];
        _endF.backgroundColor = [UIColor whiteColor];
        _endF.delegate = self;
        _endF.tag = 1000;
        _endF.placeholder = @"目的地";
    }
    return _endF;
}



-(AMapLocationManager *)locationManager{
    
    if (!_locationManager) {
        
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    
    return _locationManager;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        //初始化检索对象
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (MAPointAnnotation *)pointAnnotation {
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

-(MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mapView.delegate = self;
    }
    return _mapView;
}

-(void)viewWillAppear:(BOOL)animated{
  
   
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, MATCHSIZE(375*2), MATCHSIZE(149.88))];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"详细介绍"];
    NavTitle.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按钮" style:UIBarButtonItemStyleDone target:self action:nil];
    [nav pushNavigationItem:NavTitle animated:YES];
    
    nav.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:nav];
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tool = [PublicTool shareInstance];
    
    self.selectePlace = YES;//默认出发地
    
    [self creatBtnUI];
    
    [self initlocationManager];
    
    [self initMap];
    
    [self initF];
    
    [self creatCenterIMG];
   
    //测试按钮🔘添加地图页面
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(MATCHSIZE(30),SCREEN_H - MATCHSIZE(120), MATCHSIZE(60), MATCHSIZE(100));
    [btn setBackgroundImage:[UIImage imageNamed:@"off_Map"] forState:UIControlStateNormal];
    [self.mapView addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //        AlertView *alert = [AlertView shareInstanceWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) AndAddAlertViewType:AlertViewTypeGetMap];
        //        [alert alertViewShow];

        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}
-(void)creatCenterIMG{
    
    if (!_centerIMG) {
        
        _centerIMG = [[UIImageView alloc] initWithImage:[_tool scaleToSize:[UIImage imageNamed:@"location_center.png"] size:CGSizeMake(MATCHSIZE(80), MATCHSIZE(80))]];
        _centerIMG.center = self.mapView.center;
        _centerIMG.y -= MATCHSIZE(35);
    }
    
    [self.view addSubview:self.centerIMG];
}

-(void)initF{
    
    [self.view addSubview:self.startF];
    
    [self.view addSubview:self.endF];
}

-(void)creatBtnUI{
    
    NSArray *arr = @[@"定位",@"路况",@"导航",@"",@"",@""];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i<arr.count; i++) {
        
        UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc] initWithTitle:arr[i] style:UIBarButtonItemStylePlain target:self action:@selector(itembtnOnclick:)];
        itemBtn.tag = 10+i;
        [array addObject:itemBtn];
        
    }
    
    self.navigationItem.leftBarButtonItems = array;
}

-(void)itembtnOnclick:(UIBarButtonItem *)itemBtn{
    
    
    if (itemBtn.tag == 12) {
        //导航
//        AMMapNaviVC *navi = [[AMMapNaviVC alloc] init];
//        navi.startPoint = self.startPoint;
//        navi.endPoint = self.endPoint;
//        [self.navigationController pushViewController:navi animated:YES];
    }
    
    switch (itemBtn.tag) {
        case 10:
            NSLog(@"定位itemBtn.tag = 10");
            //开始连续定位
            [self.locationManager startUpdatingLocation];
            break;
        case 11:
            NSLog(@"路况itemBtn.tag = 11");
            self.mapView.showTraffic = !self.mapView.showTraffic;
            break;
        case 12:
            NSLog(@"导航itemBtn.tag = 12");
            //不可以跳转
            
            break;
        case 13:
            NSLog(@"itemBtn.tag = 13");
            
            break;
        case 14:
            NSLog(@"itemBtn.tag = 14");
            
            break;
            
        default:
            break;
    }
}


-(void)initMap{
    
    //是否显示用户的位置
    self.mapView.showsUserLocation = YES;
    
    //设置指南针compass，默认是开启状态，大小是定值，显示在地图的右上角
    self.mapView.showsCompass = NO;
    
    //设置比例尺scale，默认显示在地图的左上角
    self.mapView.showsScale = NO;
    
    //地图的缩放
    [self.mapView setZoomLevel:14 animated:YES];
    
    //设置地图logo，默认字样是“高德地图”，用logoCenter来设置logo的位置
    self.mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-50, CGRectGetHeight(self.view.bounds)-10);
    
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    
    
    //显示地图
    [self.view addSubview:self.mapView];
    
    //定位
    [self.locationManager startUpdatingLocation];
}

-(void)initlocationManager{
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.startF resignFirstResponder];
    [self.endF resignFirstResponder];
    
}

#pragma mark AMapLocationManagerDelegate
//连续定位回调函数
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    self.mapView.centerCoordinate = coordinate2D;
    
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
    }
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

/** -------------------------------------------------------- */
/** -------------------MAMapViewDelegate-------------------- */
/** -------------------------------------------------------- */

///**
// *  地图将要发生移动时调用此接口
// *
// *  @param mapView       地图view
// *  @param wasUserAction 标识是否是用户动作
// */
//- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
////    _locationCenter.hidden = NO;
////    [self.mapView removeAnnotation:self.pointAnnotation];
//
//}






/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapview 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}


/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapview 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
}

/**
 *  地图将要发生移动时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    
    [mapView removeAnnotation:self.pointAnnotation];
    
    if (self.selectePlace) {//出发地
        self.startF.placeholder = @"移动地图确定出发地";
        self.endF.placeholder = @"目的地";
    }else{
        self.endF.placeholder = @"移动地图确定目的地";
        self.startF.placeholder = @"出发地";
    }
    
}

/**
 *  地图移动结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    
    if (self.selectePlace) {
        //设置导航的起点
        self.startPoint = [AMapNaviPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    }else{
        //设置导航的终点
        self.endPoint = [AMapNaviPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    }
    
    [self.mapView addAnnotation:self.pointAnnotation];
    NSLog(@"经度%f  纬度%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    
    regeoRequest.location =[AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    //发起逆地理编码
    [self.search AMapReGoecodeSearch: regeoRequest];
    
    //自动显示气泡信息
    [self.mapView selectAnnotation:self.pointAnnotation animated:YES];
}

/**
 *  地图将要发生缩放时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{
    
}

/**
 *  地图缩放结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
    
}

/**
 * @brief 地图开始加载
 * @param mapview 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView{
    
}

/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{
    
}

/**
 * @brief 地图加载失败
 * @param mapView 地图View
 * @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [_tool scaleToSize:[UIImage imageNamed:@"location_center.png"] size:CGSizeMake(MATCHSIZE(80), MATCHSIZE(80))];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, MATCHSIZE(-35));
        return annotationView;
    }
    return nil;
}

/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
}

/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
}

/**
 * @brief 当取消选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
}

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
    
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    
}


#pragma mark - AMapSearchDelegate

/**
 *  当请求发生错误时，会调用代理的此方法.
 *
 *  @param request 发生错误的请求.
 *  @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
}

/**
 *  POI查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
}

/**
 *  沿途查询回调函数 (v4.3.0)
 *
 *  @param request  发起的请求，具体字段参考 AMapRoutePOISearchRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapRoutePOISearchResponse 。
 */
- (void)onRoutePOISearchDone:(AMapRoutePOISearchRequest *)request response:(AMapRoutePOISearchResponse *)response{
    
}

/**
 *  地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if(response.geocodes.count == 0)
    {
        return;
    }
    //通过AMapGeocodeSearchResponse对象处理搜索结果
    for (AMapTip *p in response.geocodes) {
        self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        self.mapView.centerCoordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        //                self.locationCoordinate2D = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        NSLog(@"responseObject: %f   %f", p.location.latitude, p.location.longitude);
    }
    
}

/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    //    *province; //!< 省/直辖市
    //    *city; //!< 市
    //    *citycode; //!< 城市编码
    //    *district; //!< 区
    //    *adcode; //!< 区域编码
    //    *township; //!< 乡镇街道
    //    *towncode; //!< 乡镇街道编码
    //    *neighborhood; //!< 社区
    //    *building; //!< 建筑
    //    *streetNumber; //!< 门牌信息
    if(response.regeocode != nil)
    {
        if (self.selectePlace) {//出发地
            self.startF.text = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.streetNumber.street];;
        }else{
            self.endF.text = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.streetNumber.street];;
        }
        
        self.pointAnnotation.title = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.streetNumber.street];
        self.pointAnnotation.subtitle = [NSString stringWithFormat:@"%@%@%@%@",response.regeocode.addressComponent.city,response.regeocode.addressComponent.township,response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        NSLog(@"response.regeocode.formattedAddress ============== %@",response.regeocode.formattedAddress);
    }
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        //目的地
        self.selectePlace = NO;
        
    }else{
        self.selectePlace = YES;
    }
    
}

@end
