//
//  JWHeaderView.h
//  lntuApp
//
//  Created by JieLee on 14/11/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderView,Title;

@protocol HeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickNameView:(HeaderView *)headerView;
@end

@interface HeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView: (UITableView *)tableView;

@property (nonatomic,copy) Title *title;
@property (nonatomic,weak) id<HeaderViewDelegate> delegate;
@end
