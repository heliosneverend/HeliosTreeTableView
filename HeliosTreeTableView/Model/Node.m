//
//  Node.m
//  HeliosTreeTableView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "Node.h"

@implementation Node
- (instancetype)initWithParentID:(int )parentID
                          nodeID:(int )nodeID
                            name:(NSString *)name
                           depth:(int )depth
                          expand:(BOOL)expand {
    if (self = [super init]){
        self.parentID = parentID;
        self.nodeID = nodeID;
        self.name = name;
        self.depth = depth;
        self.expand = expand;
    }
    return self;
}
@end
