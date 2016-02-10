//
//  ViewController.m
//  LatLonAlti
//
//  Created by lee Neil on 2/2/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import "ViewController.h"
#import "LocationData.h"
#import <UIView+Toast.h>
#import "AnalysisModel.h"
#import "UIView+Toast.h"
#import "AnalysisController.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) LocationData *data;
@property (nonatomic, strong) NSMutableArray *modelArrayM;


//xib widgets
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *lonLabel;
@property (weak, nonatomic) IBOutlet UILabel *altiLabel;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController


- (void)initKVO {
    _data = [[LocationData alloc]init];
    [_data addObserver:self forKeyPath:@"lat" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_data addObserver:self forKeyPath:@"lon" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_data addObserver:self forKeyPath:@"alti" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"lat"]) {
        _latLabel.text = [NSString stringWithFormat:@"%.21g",_data.lat];
    }
    
    if ([keyPath isEqualToString:@"lon"]) {
        _lonLabel.text = [NSString stringWithFormat:@"%.21g",_data.lon];
    }
    
    if ([keyPath isEqualToString:@"alti"]) {
        _altiLabel.text = [NSString stringWithFormat:@"%.21g",_data.alti];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelArrayM = [NSMutableArray array];
    
    [self initKVO];
    
    _locationManager = [[CLLocationManager alloc]init];
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
    }
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //    [self.view makeToast:@"didUpdateLocations"
    //                duration:3.0
    //                position:CSToastPositionTop];
    if (locations.count > 0) {
        CLLocation *loc = [locations lastObject];
        _data.lon = loc.coordinate.longitude;
        _data.lat = loc.coordinate.latitude;
        _data.alti = loc.altitude;
    }
}


#pragma mark - capture
- (IBAction)capture:(id)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Data captured" message:@"Add Location Information" preferredStyle:(UIAlertControllerStyleAlert)];
    
    __block UITextField *txtField;
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        txtField = textField;
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:nil];
    
    AnalysisModel *model = [[AnalysisModel alloc]init];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"confirm" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        LocationData *d = [[LocationData alloc]initWithLat:_data.lat Lon:_data.lon Alti:_data.alti];
        
        model.userInput = txtField.text;
        model.locData = d;
        
        if (_modelArrayM.count > 1) {
            
            AnalysisModel *lastModel = [_modelArrayM lastObject];
            CLLocation *last = [[CLLocation alloc]initWithLatitude:lastModel.locData.lat longitude:lastModel.locData.lon];
            CLLocation *curr = [[CLLocation alloc]initWithLatitude:_data.lat longitude:_data.lon];
            CLLocationDistance dist = [last distanceFromLocation:curr];
            model.horizontalDif = dist;
            model.verticalDif = model.locData.alti - lastModel.locData.alti;
            
        }else {
            model.horizontalDif = 0;
            model.verticalDif = 0;
        }
        
        [_modelArrayM addObject: model];
        [self.view makeToast:@"success"];
    }];
    
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)viewAnalysis:(id)sender {
    AnalysisController *c = [[AnalysisController alloc]init];
    c.modelArray = [_modelArrayM copy];
    [self presentViewController:c animated:YES completion:nil];
}

@end


















