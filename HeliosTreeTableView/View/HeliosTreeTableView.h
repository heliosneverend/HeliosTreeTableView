//
//  HeliosTreeTableView.h
//  HeliosTreeTableView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@protocol HeliosTreeDelegate <NSObject>

- (void)selectCell:(Node *)node;

@end
@interface HeliosTreeTableView : UITableView
@property (nonatomic , weak) id<HeliosTreeDelegate> treeDelegate;
- (instancetype )initWithFrame:(CGRect)frame withDataSource:(NSArray *)data;
@end
