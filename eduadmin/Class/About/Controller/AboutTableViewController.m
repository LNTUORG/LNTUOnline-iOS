//
//  AboutTableViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 JieLee. All rights reserved.
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
        
        if (![MFMailComposeViewController canSendMail]) return;
        
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
        
        // 设置邮件主题
        [vc setSubject:@"BUG反馈"];
        // 设置邮件内容
        NSString *content = [NSString stringWithFormat:@"系统版本: iOS %@ \n设备型号: %@ \n软件版本: %@ \n\n", [LJDeviceTool getCurrentSystemVersion], [LJDeviceTool getCurrentDeviceModel], [LJDeviceTool getCurrentAppVersion]];
        [vc setMessageBody:content isHTML:NO];
        // 设置收件人列表
        [vc setToRecipients:@[SUPPORTMAIL]];
        
        
        // 设置代理
        vc.mailComposeDelegate = self;
        // 显示控制器
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        
        [self performSegueWithIdentifier:@"about2web" sender:FEEDBACKURL];
    }
    if (indexPath.row == 3) {
        
        NSString *url = [NSString stringWithFormat:@"http://wpa.qq.com/msgrd?v=3&uin=%@&site=qq&menu=yes", LJQQ];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    if (indexPath.row == 4) {
        
        [self performSegueWithIdentifier:@"about2web" sender:WEIBOURL];
    }
    if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"about2web" sender:WANTEDURL];
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
