//
//  ChatIMessageVC.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "ChatIMessageVC.h"
#import "ChatMainCell.h"
#import "ChatMainModel.h"

@interface ChatIMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation ChatIMessageVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载数据
    [self loadData];
    
    //创建tableview
    [self creatTableView];
}
-(void)loadData{
    
    //这里到有真正数据要做出改变  想一下只用于测试
    for (int i = 0; i<20; i++) {
        ChatMainModel *model = [[ChatMainModel alloc] init];
        model.headIMG = nil;
        model.title = [NSString stringWithFormat:@"用户群题%d",i+1];
        model.inform = [NSString stringWithFormat:@"我刚刚想了一下，这是你说过的第%d句话了，我懂得...",i+1];
        [self.arrayData addObject:model];
    }
    
}


-(void)creatTableView{
    
    self.tableView.rowHeight = MATCHSIZE_PX(120);
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    
    ChatMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ChatMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = self.arrayData[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}



@end
