//
//  ViewController.m
//  HeliosTreeTableView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"
#import "HeliosTreeTableView.h"
@interface ViewController ()<HeliosTreeDelegate>
{
    NSArray *_data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setDataSource];
    [self makeUI];
}

- (void)makeUI {
    HeliosTreeTableView *tableview = [[HeliosTreeTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) withDataSource:_data];
    tableview.treeDelegate = self;
    [self.view addSubview:tableview];
}

- (void)setDataSource {
    Node *country1 = [[Node alloc] initWithParentID:-1 nodeID:0 name:@"中国" depth:0 expand:YES];
    Node *province1 = [[Node alloc] initWithParentID:0 nodeID:1 name:@"江苏" depth:1 expand:NO];
    Node *city1 = [[Node alloc] initWithParentID:1 nodeID:2 name:@"南通" depth:2 expand:NO];

    Node *city2 = [[Node alloc] initWithParentID:1 nodeID:3 name:@"南京" depth:2 expand:NO];
    Node *city3 = [[Node alloc] initWithParentID:1 nodeID:4 name:@"苏州" depth:2 expand:NO];
    Node *province2 = [[Node alloc] initWithParentID:0 nodeID:5 name:@"广东" depth:1 expand:NO];
    Node *city4 = [[Node alloc] initWithParentID:5 nodeID:6 name:@"深圳" depth:2 expand:NO];
    Node *city5 = [[Node alloc] initWithParentID:5 nodeID:7 name:@"广州" depth:2 expand:NO];
    Node *province3 = [[Node alloc] initWithParentID:0 nodeID:8 name:@"浙江" depth:1 expand:NO];
    Node *city6 = [[Node alloc] initWithParentID:8 nodeID:9 name:@"杭州" depth:2 expand:NO];
   
    Node *country2 = [[Node alloc] initWithParentID:-1 nodeID:10 name:@"美国" depth:0 expand:YES];
    Node *province4 = [[Node alloc] initWithParentID:10 nodeID:11 name:@"纽约州" depth:1 expand:NO];
    Node *province5 = [[Node alloc] initWithParentID:10 nodeID:12 name:@"德州" depth:1 expand:NO];
    Node *city7 = [[Node alloc] initWithParentID:12 nodeID:13 name:@"休斯顿" depth:2 expand:NO];
    Node *province6 = [[Node alloc] initWithParentID:10 nodeID:14 name:@"加州" depth:1 expand:NO];
    Node *city8 = [[Node alloc] initWithParentID:14 nodeID:15 name:@"洛杉矶" depth:2 expand:NO];
    Node *city9 = [[Node alloc] initWithParentID:14 nodeID:16 name:@"旧金山" depth:2 expand:NO];
    
    Node *country3 = [[Node alloc] initWithParentID:-1 nodeID:17 name:@"日本" depth:0 expand:YES];
    Node *province7 = [[Node alloc] initWithParentID:17 nodeID:18 name:@"东京" depth:1 expand:NO];
    Node *province8 = [[Node alloc] initWithParentID:17 nodeID:19 name:@"东京1" depth:1 expand:NO];
    Node *province9 = [[Node alloc] initWithParentID:17 nodeID:20 name:@"东京2" depth:1 expand:NO];
 
    _data = [NSArray arrayWithObjects:country1,province1,city1,city2,city3,province2,city4,city5,province3,city6,country2,province4,province5,city7,province6,city8,city9,country3,province7,province8,province9, nil];

}
#pragma mark - TreeTableCellDelegate
-(void)selectCell:(Node *)node{
    NSLog(@"%@",node.name);
}

- (void)dIDReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
