//
//  MMMapView.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMMapView.h"
#import "MMGDMapView.h"
#import "MMGoogleMapView.h"
#import "MMMapTopView.h"
#import "MMMapRightView.h"
#import "MMGDPolygon.h"
#import "MMMapPolyLineEditView.h"
#import "MMMapPolygonEditView.h"
#import "MMMapSelectedAnnotationEditView.h"
#import "MMMapEditAnnotationsPopupView.h"
#import "MMMapEditPolygonPopupView.h"
#import "MMMapEditPolygonJWPopupView.h"
#import "MMMapMyCollectViewController.h"
#import "MMPolygonChooseStartView.h"
#import "MMSingleTapAnnotationView.h"


@interface MMMapView()<MMGDMapViewDelegate,MMGoogleMapViewDelegate,MMMapRightViewDelegate,MMMapPolyLineEditViewDelegate,MMMapPolygonEditViewDelegate,MMMapSelectedAnnotationEditViewDelegate,MMMapEditAnnotationsPopupViewDelegate,MMMapEditPolygonJWPopupViewDelegate,MMMapEditPolygonPopupViewDelegate,MMPolygonChooseStartViewDelegate,UITextFieldDelegate>
/** 高德地图 */
@property (nonatomic,strong) MMGDMapView *gdMapView;
/** 谷歌地图 */
@property (nonatomic,strong) MMGoogleMapView *googleMapView;
/** 顶部 */
@property (nonatomic,strong) MMMapTopView *mapTopView;
/** 右侧 */
@property (nonatomic,strong) MMMapRightView *mapRightView;
/** 多点编辑 */
@property (nonatomic,strong) MMMapPolyLineEditView *polyLineEditView;
/** 多点选中编辑 */
@property (nonatomic,strong) MMMapSelectedAnnotationEditView *selectedEditView;
/** 区域编辑 */
@property (nonatomic,strong) MMMapPolygonEditView *polygonEditView;
/** 编辑点的弹出框 */
@property (nonatomic,strong) MMMapEditAnnotationsPopupView *editAnnotationsView;
/** 编辑经纬度的弹出框 */
@property (nonatomic,strong) MMMapEditPolygonJWPopupView *editPolygonJWView;
/** 编辑区域生成规则的弹出框 */
@property (nonatomic,strong) MMMapEditPolygonPopupView *editPolygonView;
/** 编辑区域开始边的起始点 */
@property (nonatomic,strong) MMPolygonChooseStartView *chooseStartView;
//手动输入点的经纬度输入框
@property (nonatomic,strong) UITextField *latitudeTextField;
@property (nonatomic,strong) UITextField *longitudeTextField;
@end

@implementation MMMapView
+ (instancetype)mapView{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
    [self addSubview:self.gdMapView];
    [self addSubview:self.googleMapView];
    [self addSubview:self.mapRightView];
    [self addSubview:self.mapTopView];
    
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        self.gdMapView.hidden = NO;
        self.googleMapView.hidden = YES;
    }else{
        self.gdMapView.hidden = YES;
        self.googleMapView.hidden = NO;
    }
    [self mapChangeSmall:YES];
}
- (MMGDMapView *)gdMapView
{
    if (!_gdMapView) {
        _gdMapView = [MMGDMapView mapView];
        _gdMapView.delegate = self;
    }
    return _gdMapView;
}
- (MMGoogleMapView *)googleMapView
{
    if (!_googleMapView) {
        _googleMapView = [MMGoogleMapView mapView];
        _googleMapView.delegate = self;
    }
    return _googleMapView;
}
- (MMMapTopView *)mapTopView
{
    if (!_mapTopView) {
        _mapTopView = [MMMapTopView new];
        __weak typeof(self) weakSelf = self;
        _mapTopView.setInedx = ^(MAP_function setIndex) {
            weakSelf.gdMapView.mapFunction = setIndex;
            weakSelf.googleMapView.mapFunction = setIndex;
        };
    }
    return _mapTopView;
}
- (MMMapRightView *)mapRightView
{
    if (!_mapRightView) {
        _mapRightView = [MMMapRightView new];
        _mapRightView.delegate = self;
    }
    return _mapRightView;
}
- (MMMapPolyLineEditView *)polyLineEditView
{
    if (!_polyLineEditView) {
        _polyLineEditView = [[MMMapPolyLineEditView alloc] init];
        _polyLineEditView.delegate = self;
    }
    return _polyLineEditView;
}
- (MMMapPolygonEditView *)polygonEditView
{
    if (!_polygonEditView) {
        _polygonEditView = [[MMMapPolygonEditView alloc] init];
        _polygonEditView.delegate = self;
    }
    return _polygonEditView;
}
- (MMMapSelectedAnnotationEditView *)selectedEditView
{
    if (!_selectedEditView) {
        _selectedEditView = [[MMMapSelectedAnnotationEditView alloc] init];
        _selectedEditView.delegate = self;
    }
    return _selectedEditView;
}
- (MMPolygonChooseStartView *)chooseStartView
{
    if (!_chooseStartView) {
        _chooseStartView = [[MMPolygonChooseStartView alloc] init];
        _chooseStartView.delegate = self;
    }
    return _chooseStartView;
}
- (MMMapEditAnnotationsPopupView *)editAnnotationsView
{
    if (!_editAnnotationsView) {
        _editAnnotationsView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MMMapEditAnnotationsPopupView class]) owner:self options:nil][0];
        _editAnnotationsView.frame = CGRectMake((ViewWidth-414)/2, 30, 414, ViewHight-30);
        _editAnnotationsView.delegate = self;
    }
    return _editAnnotationsView;
}
- (MMMapEditPolygonJWPopupView *)editPolygonJWView
{
    if (!_editPolygonJWView) {
        _editPolygonJWView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MMMapEditPolygonJWPopupView class]) owner:self options:nil][0];
        _editPolygonJWView.frame = CGRectMake((ViewWidth-414)/2, 30, 414, 270);
        _editPolygonJWView.delegate = self;
    }
    return _editPolygonJWView;
}
- (MMMapEditPolygonPopupView *)editPolygonView
{
    if (!_editPolygonView) {
        _editPolygonView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MMMapEditPolygonPopupView class]) owner:self options:nil][0];
        _editPolygonView.frame = CGRectMake((ViewWidth-414)/2, 30, 414, ViewHight-30);
        _editPolygonView.delegate = self;
    }
    return _editPolygonView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.googleMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.gdMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.mapRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(ViewHight-25);
    }];
    __weak typeof(self) weakSelf = self;
    [self.mapTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(weakSelf.mapRightView.mas_left);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(74);
    }];
    if (_polyLineEditView) {
        [self.polyLineEditView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(self);
            make.width.mas_equalTo(ViewWidth*0.67);
            make.height.mas_equalTo(71);
        }];
    }
    if (_polygonEditView) {
        [self.polygonEditView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(self);
            make.width.mas_equalTo(ViewWidth*0.67);
            make.height.mas_equalTo(71);
        }];
    }
    if (_selectedEditView) {
        [self.selectedEditView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.polyLineEditView).with.offset(8);
            make.right.mas_equalTo(self.polyLineEditView).with.offset(-90);
            make.bottom.mas_equalTo(self.polyLineEditView.mas_top).with.offset(2);
            make.height.mas_equalTo(73);
        }];
    }
    if (_chooseStartView) {
        [self.chooseStartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(@(-70.5-68.5-3));
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(@(156));
            make.height.mas_equalTo(68.5);
        }];
    }
    
}
- (void)mapChangeSmall:(BOOL)isSmall
{
    if (isSmall) {
        self.mapRightView.hidden = YES;
        self.mapTopView.hidden = YES;
    }else{
        self.mapRightView.hidden = NO;
        self.mapTopView.hidden = NO;
    }
}
#pragma mark - MMGDMapViewDelegate
- (void)GDMapView:(MMGDMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if ([MMMapManager manager].showType == MapShowTypePreview) {
        if ([_delegate respondsToSelector:@selector(MMMapViewPreviewClick:)]) {
            [_delegate MMMapViewPreviewClick:self];
        }
    }else{
        switch ([MMMapManager manager].mapFunction) {
            case MAP_pointTypePointingFlight:
            {
                //清除
                [_gdMapView clear];
                //点信息
                MMAnnotation *annotation = [[MMAnnotation alloc] init];
                annotation.coordinate = coordinate;
                annotation.index = [MMMapManager manager].annotations.count+1;
                //加点
                [[MMMapManager manager].annotations removeAllObjects];
                [[MMMapManager manager].annotations addObject:annotation];
                [_gdMapView addAnnotations:[MMMapManager manager].annotations];
                [TheNotificationCenter postNotificationName:@"MMSingleTapAnnotationViewCoordinate" object:nil userInfo:@{@"lat":[NSString stringWithFormat:@"%.7f",coordinate.latitude],@"log":[NSString stringWithFormat:@"%.7f",coordinate.longitude]}];
                BOOL isOver = [[MMMapManager manager] isOverFlightAtFlyCoordinate:coordinate userCoordinate:_gdMapView.userAnnotation.coordinate];
                if (isOver) {
                    //超出范围不划线
                    [[MMMapManager manager].annotations removeLastObject];
                }else{
                    //划线
                    [_gdMapView addPolyLines:@[mapView.userAnnotation,annotation] lineColor:MAPLineBlueColor];
                }
            }
                break;
            case MAP_pointTypeRoutePlanning:
            {
                //清除
                [_gdMapView clear];
                //点信息
                MMAnnotation *annotation = [[MMAnnotation alloc] init];
                annotation.coordinate = coordinate;
                annotation.index = [MMMapManager manager].annotations.count+1;
                //加点
                [[MMMapManager manager].annotations addObject:annotation];
                [_gdMapView addAnnotations:[MMMapManager manager].annotations];
                BOOL isOver = [[MMMapManager manager] isOverFlightAtFlyCoordinate:coordinate userCoordinate:_gdMapView.userAnnotation.coordinate];
                if (isOver) {
                    //超出范围不划线
                    [[MMMapManager manager].annotations removeLastObject];
                }
                //划线
                [_gdMapView addPolyLines:[MMMapManager manager].annotations lineColor:MAPLineBlueColor];
                _polyLineEditView.markArr = [MMMapManager manager].annotations;
            }
                break;
                case MAP_pointTypeRegionalRoute:
                {
                    //点信息
                    MMAnnotation *annotation = [[MMAnnotation alloc] init];
                    annotation.coordinate = coordinate;
                    annotation.index = [MMMapManager manager].annotations.count+1;
                    BOOL isOver = [[MMMapManager manager] isOverFlightAtFlyCoordinate:coordinate userCoordinate:_gdMapView.userAnnotation.coordinate];
                    if (isOver) {
                        //超出范围没啥变化
                        [_gdMapView addAnnotation:annotation];
                        return;
                    }
                    [[MMMapManager manager].annotations addObject:annotation];
                    [[MMMapManager manager] changeConvexPolygon:[MMMapManager manager].annotations];
                    _polyLineEditView.markArr = [MMMapManager manager].annotations;
                    if ([MMMapManager manager].annotations.count < 3) {
                        [_gdMapView addAnnotation:annotation];
                        return;
                    }
                    //清除
                    [_gdMapView clear];
                    [_gdMapView addAnnotations:[MMMapManager manager].annotations];
                    //划区域
                    [_gdMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeSolid];
                }
                    break;
            default:
                break;
        }
    }
}
- (void)GDMapViewSingleClickGO:(MMGDMapView *)mapView
{
    DLog(@"高德起飞了");
}
#pragma mark - MMGoogleMapViewDelegate
- (void)googleMapView:(MMGoogleMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if ([MMMapManager manager].showType == MapShowTypePreview) {
        if ([_delegate respondsToSelector:@selector(MMMapViewPreviewClick:)]) {
            [_delegate MMMapViewPreviewClick:self];
        }
    }else{
        
    }
}
#pragma mark - MMMapRightViewDelegate
- (void)mapRightView:(MMMapRightView *)rightView index:(MAP_pointType)index
{
    if (index != MAP_pointTypeHidden) {
        [MMMapManager manager].mapFunction = index;
    }
    if (_selectedEditView) {
        _selectedEditView.hidden = YES;
    }
    CGFloat width = 20;
    if (index == MAP_pointTypeHidden) {
        width = 50;
    }else{
        if ([MMMapManager manager].type == MapTypeGaoDe) {
            [_gdMapView clear];
        }else{
            [_googleMapView clear];
        }
        [[MMMapManager manager].annotations removeAllObjects];
        if (index == MAP_pointTypeRoutePlanning || index == MAP_pointTypeRegionalRoute) {
            if (!_polyLineEditView) {
                [self addSubview:self.polyLineEditView];
            }else{
                self.polyLineEditView.hidden = NO;
                [self bringSubviewToFront:self.polyLineEditView];
            }
            self.polyLineEditView.markArr = [MMMapManager manager].annotations;
            [self.polyLineEditView setUpButton];
        }else{
            self.polyLineEditView.hidden = YES;
        }
    }
    [_mapRightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    //更新约束
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}
#pragma mark - MMMapPolyLineEditViewDelegate
/** 选中航点 */
//index:若为一个时显示选中第几个
- (void)selctedMarkOnMapDuodianEditView:(MMMapPolyLineEditView *)editView selectedMarkArr:(NSArray *)markArr oneIndex:(NSInteger)index
{
    if (markArr.count == 0) {
        _selectedEditView.hidden = YES;
        return;
    }
    if (!_selectedEditView) {
        [self addSubview:self.selectedEditView];
    }else{
        _selectedEditView.hidden = NO;
        [self bringSubviewToFront:_selectedEditView];
    }
    _selectedEditView.selectedArr = [markArr copy];
}
//全选
- (void)clickAllOnMapDuodianEditView:(MMMapPolyLineEditView *)editView isYes:(BOOL)yes
{
    if (yes) {
        if (!_selectedEditView) {
            [self addSubview:self.selectedEditView];
        }else{
            _selectedEditView.hidden = NO;
            [self bringSubviewToFront:_selectedEditView];
        }
        _selectedEditView.selectedArr = [[MMMapManager manager].annotations copy];
    }else{
        _selectedEditView.hidden = YES;
    }
}
//收藏
- (void)clickCollectOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
        //航线规划
        if ([MMMapManager manager].annotations.count == 0) {
            [SVProgressHUD showErrorWithStatus:Localized(@"TIP_NOTChoosePoint")];
            [SVProgressHUD dismissWithDelay:1.3];
            return;
        }
    }else{
        //区域航线
        if ([MMMapManager manager].annotations.count < 3) {
            [SVProgressHUD showErrorWithStatus:Localized(@"TIP_SetAreaPointsNotEnough")];
            [SVProgressHUD dismissWithDelay:1.8];
            return;
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Localized(@"TIP_WarmPrompt") message:Localized(@"EditCollectedWaypointName") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Localized(@"YUNTAICancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:Localized(@"YUNTAISure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL ret;
        UITextField *textField = alertController.textFields[0];
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
            //航线规划
            ret = [NSArray saveHangxianWith:@{@"type":@2,@"name":textField.text,@"isChina":@"1",@"models":[MMAnnotation mj_keyValuesArrayWithObjectArray:[MMMapManager manager].annotations]}];
        }else{
            //区域航线
            ret = [NSArray saveHangxianWith:@{@"type":@3,@"name":textField.text,@"isChina":@"1",@"models":[MMAnnotation mj_keyValuesArrayWithObjectArray:[MMMapManager manager].annotations]}];
        }
        if (ret) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            [SVProgressHUD dismissWithDelay:1.2];
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
            textField.text = Localized(@"EditERoutePlanning");
        }else{
            textField.text = Localized(@"EditERegionalPlanning");
        }
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
//编辑
- (void)clickEditOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    DLog(@"编辑");
    __block NSInteger count = 0;
    [editView.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected) {
            count++;
        }
    }];
    if (count == 0) {
        [SVProgressHUD showInfoWithStatus:Localized(@"TIP_NOTChoosePoint")];
        [SVProgressHUD dismissWithDelay:1.0];
    }else{
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
            //航线规划
            [[MMMapManager manager] addPopopView:self.editAnnotationsView];
            if (count == 1) {
                self.editAnnotationsView.model = [MMMapManager manager].selectedAnnotations[0];
                self.editAnnotationsView.tittleText = [NSString stringWithFormat:@"%@%ld",Localized(@"EditPoints"),(long)self.editAnnotationsView.model.index];
            }else{
                self.editAnnotationsView.model = nil;
                self.editAnnotationsView.tittleText = Localized(@"EditERoutePlanning");
            }
        }else{
            //区域航线
            [[MMMapManager manager] addPopopView:self.editPolygonJWView];
            self.editPolygonJWView.model = [MMMapManager manager].selectedAnnotations[0];
        }
    }
}
//添加航点
- (void)addHangdianOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:Localized(@"TIP_AddPoints") message:nil preferredStyle:UIAlertControllerStyleAlert];
    //定义第一个输入框；
    __weak typeof(self) weakSelf = self;
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = Localized(@"MineWeidu");
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        weakSelf.latitudeTextField = textField;
    }];
    //定义第二个输入框；
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = Localized(@"MineJingdu");
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        weakSelf.longitudeTextField = textField;
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:Localized(@"YUNTAISure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *weidu = alertVC.textFields[0];
        UITextField *jingdu = alertVC.textFields[1];
        
        MMAnnotation *model = [[MMAnnotation alloc] init];
        CLLocationCoordinate2D addCoordinate = CLLocationCoordinate2DMake([weidu.text doubleValue], [jingdu.text doubleValue]);
        model.coordinate = addCoordinate;
        model.iconType = MAP_iconTypeCommonRed;
        model.index = [MMMapManager manager].annotations.count+1;
        if ([MMMapManager manager].type == MapTypeGaoDe) {
            [weakSelf.gdMapView addAnnotation:model];
        }else{
            [weakSelf.gdMapView addAnnotation:model];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Localized(@"YUNTAICancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:^{
        
    }];
}
//航线规划时
- (void)clickGoOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    DLog(@"Go");
}
//区域航线时
- (void)clickDuiOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    DLog(@"对");
    if ([MMMapManager manager].annotations.count == 0) {
        [SVProgressHUD showInfoWithStatus:Localized(@"TIP_SetAreaPoints")];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if ([MMMapManager manager].annotations.count < 3) {
        [SVProgressHUD showInfoWithStatus:Localized(@"TIP_SetAreaPointsNotEnough")];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if (_selectedEditView) {
        _selectedEditView.hidden = YES;
    }
    if (_polygonEditView) {
        self.polygonEditView.hidden = NO;
        [self bringSubviewToFront:self.polygonEditView];
    }else{
        [self addSubview:self.polygonEditView];
    }
//    [UIView animateWithDuration:0.5 animations:^{
//        self.polygonEditView.frame = CGRectMake(150, ViewHight-70.5, ViewWidth-150, 70.5);
//    }];
    self.polygonEditView.type = 1;
    [self.polygonEditView showCollectAndReplaning:NO];

    if (!_chooseStartView) {
        [self addSubview:self.chooseStartView];
    }else{
        self.chooseStartView.hidden = NO;
        [self bringSubviewToFront:self.chooseStartView];
        [self.chooseStartView setDefault];
    }

    //开始重新绘制
    [self redrawBian:0 start:0];
}
- (void)redrawBian:(NSInteger)bianIndex start:(NSInteger)startIndex
{
    NSArray *points = [MMMapManager manager].groupArray[bianIndex];
    [points enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx+1;
        obj.title = [NSString stringWithFormat:@"%lu",idx+1];
        if (startIndex == idx) {
            obj.iconType = MAP_iconTypeRoundedRedNumbers;
        }else{
            obj.iconType = MAP_iconTypeRoundedBlueNumbers;
        }
    }];
    [[MMMapManager manager].middleArray enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (bianIndex == idx) {
            obj.iconType = MAP_iconTypeRoundedRedAlphabet;
        }
    }];
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        //1.清除
        [self.gdMapView clear];
        //2.绘制区域
        [self.gdMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeDashed];
        //3.绘制选中边为黄色
        [self.gdMapView addPolyLines:points lineColor:MAPLineYellowColor];
        //4.绘制选中边的两端
        [self.gdMapView addAnnotations:points];
        //5.绘制各边中点，选中边为红色，其余为灰色
        [self.gdMapView addAnnotations:[MMMapManager manager].middleArray];
    }else{
        //1.清除
        [self.googleMapView clear];
        //2.绘制区域
        [self.googleMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeDashed];
        //3.绘制选中边为黄色
        [self.googleMapView addPolyLines:points lineColor:MAPLineYellowColor lineType:MAPLineTypeSolid];
        //4.绘制选中边的两端
        [self.googleMapView addAnnotations:points];
        //5.绘制各边中点，选中边为红色，其余为灰色
        [self.gdMapView addAnnotations:[MMMapManager manager].middleArray];
    }
}
- (void)clickCuoOnMapDuodianEditView:(MMMapPolyLineEditView *)editView
{
    DLog(@"错");
    [[MMMapManager manager] clearDataArray];
    if (_selectedEditView) {
        _selectedEditView.hidden = YES;
    }
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        [self.gdMapView clear];
    }else{
        [self.googleMapView clear];
    }
    editView.markArr = nil;
}
#pragma mark - MMMapSelectedAnnotationEditViewDelegate
- (void)deleteOnMMMapSelectedAnnotationEditView:(MMMapSelectedAnnotationEditView *)view
{
    //1.重新整理数据
    [[[MMMapManager manager].annotations copy] enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected == YES) {
            [[MMMapManager manager].annotations removeObject:obj];
        }
    }];
    //2.隐藏选中弹框
    if (_selectedEditView) {
        _selectedEditView.hidden = YES;
    }
    //3.清空地图，并重新绘制
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        [self.gdMapView clear];
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
            //航线规划
            [self.gdMapView addAnnotations:[MMMapManager manager].annotations];
            [self.gdMapView addPolyLines:[MMMapManager manager].annotations lineColor:MAPLineBlueColor];
        }else{
            //区域航线
            [self.gdMapView addAnnotations:[MMMapManager manager].annotations];
            [self.gdMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeSolid];
        }
    }else{
        [self.googleMapView clear];
    }
    //4.重新绘制底部显示点
    self.polyLineEditView.markArr = [MMMapManager manager].annotations;
}
#pragma mark - MMMapPolygonEditViewDelegate
//收藏
- (void)clickCollectOnQuyuChooseView:(MMMapPolygonEditView *)quyuView
{
    
}
//重新规划
- (void)clickReplanningOnQuyuChooseView:(MMMapPolygonEditView *)quyuView
{
    
}
//对
- (void)clickDuiOnQuyuChooseView:(MMMapPolygonEditView *)quyuView
{
    
}
//错
- (void)clickCuoOnQuyuChooseView:(MMMapPolygonEditView *)quyuView
{
    
}
//选中某个
- (void)selctedOnQuyuChooseView:(MMMapPolygonEditView *)quyuView index:(NSInteger)index
{
    
}
#pragma mark - MMMapEditAnnotationsPopupViewDelegate
- (void)editEndOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view editModel:(MMAnnotation *)model
{
    //更新model(3个视图)
    [[MMMapManager manager] updateAnnotations:model];
    //用setter方法更新数据
    self.selectedEditView.selectedArr = [MMMapManager manager].selectedAnnotations;
    //鉴于修改数据之后地图会变化
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        [self.gdMapView clear];
        [self.gdMapView addAnnotations:[MMMapManager manager].annotations];
        //划线
        [self.gdMapView addPolyLines:[MMMapManager manager].annotations lineColor:MAPLineBlueColor];
    }else{
        [self.googleMapView clear];
        [self.googleMapView addAnnotations:[MMMapManager manager].annotations];
        //划线
        [self.googleMapView addPolyLines:[MMMapManager manager].annotations lineColor:MAPLineBlueColor lineType:MAPLineTypeSolid];
    }
    //清除弹框
    [[MMMapManager manager] clearShadeView];
}
- (void)cancelOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view
{
    //清除弹框
    [[MMMapManager manager] clearShadeView];
}

#pragma mark - MMMapEditPolygonPopupViewDelegate
- (void)editEndOnMMMapEditPolygonPopupView:(MMMapEditPolygonPopupView *)view regulation:(NSInteger)regulation spacing:(NSInteger)spacing speed:(NSString *)speed height:(NSString *)height
{
    
}
- (void)cancelOnMMMapEditPolygonPopupView:(MMMapEditPolygonPopupView *)view
{
    self.editPolygonView.hidden = YES;
}

#pragma mark - MMMapEditPolygonJWPopupViewDelegate
- (void)editEndOnMMMapEditPolygonJWView:(MMMapEditPolygonJWPopupView *)view editModel:(MMAnnotation *)model
{
    //更新model
    [[MMMapManager manager] updateAnnotations:model];
    //用setter方法更新数据
    self.selectedEditView.selectedArr = [MMMapManager manager].selectedAnnotations;
    //地图重绘
    if ([MMMapManager manager].type == MapTypeGaoDe) {
        [self.gdMapView clear];
        [self.gdMapView addAnnotations:[MMMapManager manager].annotations];
        [self.gdMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeSolid];
    }else{
        [self.googleMapView clear];
        [self.googleMapView addAnnotations:[MMMapManager manager].annotations];
        [self.googleMapView addPolygon:[MMMapManager manager].annotations lineType:MAPLineTypeSolid];
    }
}
- (void)cancelOnMMMapEditPolygonJWView:(MMMapEditPolygonJWPopupView *)view
{
    self.editPolygonJWView.hidden = YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _latitudeTextField || textField == _longitudeTextField) {
        if ([string isNumberStr] || [string isEqualToString:@""] || [string isEqualToString:@"."]) {
            if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
                return NO;
            }
            //还未输入小数点时
            if (![textField.text containsString:@"."] && [string isNumberStr]) {
                if (textField == _latitudeTextField) {
                    //纬度的话小数点前最多两位，并且绝对值小于90
                    if (textField.text.length == 2) {
                        return NO;
                    }
                    int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
                    if (abs(willStr) > 89) {
                        return NO;
                    }
                }else{
                    //经度的话小数点前最多三位，并且绝对值小于180
                    if (textField.text.length == 3) {
                        return NO;
                    }
                    int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
                    if (abs(willStr) > 179) {
                        return NO;
                    }
                }
            }
            return YES;
        }else{
            return NO;
        }
    }else{
        if ([string isNumberStr] || [string isEqualToString:@""]) {
            return YES;
        }else{
            return NO;
        }
    }
}
@end
