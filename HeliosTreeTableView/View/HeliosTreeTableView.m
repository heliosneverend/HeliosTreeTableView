//
//  HeliosTreeTableView.m
//  HeliosTreeTableView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "HeliosTreeTableView.h"
@interface HeliosTreeTableView()<UITableViewDataSource,UITableViewDelegate>
/*
 ** 注入的数据源 (完整)
 */
@property (nonatomic, strong)NSArray *dataArr;

/*
 ** /用于存储数据源（部分数据）
 */
@property (nonatomic , strong) NSMutableArray *tempDataArr;
@end
@implementation HeliosTreeTableView

- (instancetype )initWithFrame:(CGRect)frame withDataSource:(NSArray *)data {
    if(self = [super initWithFrame:frame style:UITableViewStyleGrouped]){
        self.dataSource = self;
        self.delegate = self;
        _dataArr = data;
        _tempDataArr = [self createTempData:data];
    }
    return self;
}

/*
 ** 初始化数据源
 */
- (NSMutableArray *)createTempData:(NSArray *)data {
     NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<data.count; i++) {
        Node *node = data[i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tempDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *NODE_CELL_ID = @"node_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    Node *node;
    if(_tempDataArr.count > 0){
         node = _tempDataArr[indexPath.row];
    }
   
   /*
    ** cell 的缩进的depth
    */
    cell.indentationLevel = node.depth;
    cell.indentationWidth = 30.f;
    cell.textLabel.text = node.name;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     ** 修改数据源
     */
    Node *parentNode = _tempDataArr[indexPath.row];
    if(_treeDelegate && [_treeDelegate respondsToSelector:@selector(selectCell:)]){
        [_treeDelegate selectCell:parentNode];
    }
    
    NSUInteger startPosition = indexPath.row + 1;
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    for (int i = 0; i< _dataArr.count; i++) {
        Node *node = _dataArr[i];
        if(node.parentID == parentNode.nodeID){
            node.expand = !node.expand;
            if(node.expand){
                [_tempDataArr insertObject:node atIndex:endPosition];
                expand = YES;
                endPosition++;
            }else{
                expand = NO;
                endPosition = [self removeAllNodesAtParentNode:parentNode];
                break;
            }
        }
    }
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    //插入或者删除相关节点
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }

}
/*
 *  删除该父节点下的所有子节点（包括孙子节点）
 *  @param parentNode 父节点
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (Node *)parentNode{
    NSUInteger startPosition = [_tempDataArr indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempDataArr.count; i++) {
        Node *node = [_tempDataArr objectAtIndex:i];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == _tempDataArr.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_tempDataArr removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

@end
