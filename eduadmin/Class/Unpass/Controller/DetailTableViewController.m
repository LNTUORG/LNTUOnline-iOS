//
//  DetailTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UnpassGradeRecord.h"
#import "DetailGradeCell.h"
#import "UnpassGradeRecord.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController
@synthesize records;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.allowsSelection = NO;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return records.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"det"];
    
    if (cell == nil) {
        cell = [DetailGradeCell newDetailGradeCell];
    }
    
    cell.records = records[indexPath.row];
    
    return cell;
}

@end
