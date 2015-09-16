//
//  JoinViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goNextButton;


- (IBAction)goBack:(id)sender;

- (IBAction)goNext:(id)sender;

- (IBAction)disappear:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy) NSString *webURL;

@end
