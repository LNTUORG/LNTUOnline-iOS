//
//  JoinViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goNextButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)goBack:(id)sender;

- (IBAction)goNext:(id)sender;

- (IBAction)disappear:(id)sender;

@property (nonatomic, copy) NSString *webURL;

@end
