//
//  WBHInterfaceController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/12.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHInterfaceController.h"
#import "WBHHybirdController.h"
#import "WBHAnimatedTransitionsController.h"
#import "WBHCoreOfAnimationViewController.h"
@interface WBHInterfaceController ()<UITableViewDelegate,UITableViewDataSource>
//
@property (nonatomic,strong)UITableView * tableview;
//
@property (nonatomic,strong)NSArray     * dataArray;
//
@property (nonatomic,strong)NSArray     * VCArray;
@end

@implementation WBHInterfaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self createUI];
}
-(void)initData{
    _dataArray = @[@"(混编)Hybrid",@"转场动画",@"核心动画"];
    
    _VCArray = @[NSStringFromClass([WBHHybirdController  class]),
                 NSStringFromClass([WBHAnimatedTransitionsController class]),
                 NSStringFromClass([WBHCoreOfAnimationViewController class])
                 ];
}
-(void)createUI{

    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

#pragma mark UITableView的懒加载
-(UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    
    return _tableview;
}
#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    NSString * classString = [NSString stringWithFormat:@"%@", _VCArray[indexPath.row]];
    Class  vc =  NSClassFromString(classString);
    [self.navigationController pushViewController:[[vc alloc]init] animated:YES];
}

@end
