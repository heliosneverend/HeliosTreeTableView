//
//  Node.h
//  HeliosTreeTableView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
/*
 ** 节点类型
 */

//父节点的id，如果为-1表示该节点为根节点
@property (nonatomic , assign) int parentID;
//本节点的id
@property (nonatomic , assign) int nodeID;
//本节点的名称
@property (nonatomic , strong) NSString *name;
//该节点的深度
@property (nonatomic , assign) int depth;
//该节点是否处于展开状态
@property (nonatomic , assign) BOOL expand;

- (instancetype)initWithParentID:(int )parentID
                          nodeID:(int )nodeID
                            name:(NSString *)name
                           depth:(int )depth
                          expand:(BOOL)expand;
@end
