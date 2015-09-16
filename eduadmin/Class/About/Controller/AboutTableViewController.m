//
//  AboutTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "AboutTableViewController.h"
#import "ShowWebViewController.h"
#import "MBProgressHUD+LJ.h"
#import "Common.h"
#import "LJTools.h"
#import <MessageUI/MessageUI.h>

@interface AboutTableViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation AboutTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.versionLable.text = [NSString stringWithFormat:@"v%@",[LJDeviceTool getCurrentAppVersion]];
    self.rightsLable.text = [NSString stringWithFormat:@"Copyright © 2013-%ld PUPBOSS. All Rights Reserved",(long)[LJTimeTool getCurrentYear]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"about2web" sender:PUPBOSSURL];
    }
    if (indexPath.row == 1) {
        
        [self performSegueWithIdentifier:@"about2web" sender:WEIBOURL];
    }
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"about2web" sender:WANTEDURL];
    }
    if (indexPath.row == 3) {
        
        [self performSegueWithIdentifier:@"about2web" sender:FEEDBACKURL];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  点击取消按钮会自动调用
 */
- (void)g:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShowWebViewController *con = segue.destinationViewController;
    con.webURL = sender;
}

@end
