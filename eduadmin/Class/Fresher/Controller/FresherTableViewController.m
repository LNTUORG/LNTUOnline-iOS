//
//  FresherTableViewController.m
//  eduadmin
//
//  Created by JieLee on 15/5/14.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "FresherTableViewController.h"
#import "SchoolLocationCell.h"

@interface FresherTableViewController ()

@end

@implementation FresherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.schoolArr = @[@"葫芦岛校区", @"阜新校区", @"玉龙校区"];
    self.imageArr = @[@"huludao", @"fuxin", @"yulong"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SchoolLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scool_location"];
    
    if (!cell) {
        cell = [SchoolLocationCell newLocationCell];
    }
    
    cell.imageName = self.imageArr[indexPath.row];
    cell.schoolName = self.schoolArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
