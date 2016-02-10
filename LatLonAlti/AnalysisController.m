//
//  AnalysisController.m
//  LatLonAlti
//
//  Created by lee Neil on 2/3/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import "AnalysisController.h"
#import "LLATableViewCell.h"
#import "AnalysisModel.h"

@interface AnalysisController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AnalysisController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(200, 300, 40, 40);
    [btn setTitle:@"back" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnalysisModel *model = _modelArray[indexPath.row];
    
    LLATableViewCell *cell = [LLATableViewCell cell];
    cell.locInfoLabel.text = model.userInput;
    cell.hdistance.text = [NSString stringWithFormat:@"%.3f",model.horizontalDif];
    cell.vdistance.text = [NSString stringWithFormat:@"%.3f",model.verticalDif];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[[NSBundle mainBundle]loadNibNamed:@"group_header" owner:self options:nil]lastObject];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
