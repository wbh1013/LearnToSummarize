//
//  WBHHybirdController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/13.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHHybirdController.h"
#import "WBHWebViewJSController.h"
#import "WBHJSCameraController.h"

@interface WBHHybirdController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
//数据源
@property (nonatomic,strong)NSArray * dataArray;
//控制器
@property (nonatomic,strong)NSArray * vcArray;
@end

@implementation WBHHybirdController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self initData];
    
}
-(void)initData{
    _dataArray = @[@"UIWebView与js的交互",
                   @"JS通过Native调用iOS设备摄像头"
                   ];
    _vcArray   = @[NSStringFromClass([WBHWebViewJSController class]),
                   NSStringFromClass([WBHJSCameraController class])
                   ];
}
-(void)createUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellI";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Class vcClass = NSClassFromString(_vcArray[indexPath.row]);
    [self.navigationController pushViewController:[[vcClass alloc]init] animated:true];
    
}

@end
