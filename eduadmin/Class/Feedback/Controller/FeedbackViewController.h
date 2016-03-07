//
//  FeedbackViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *infoTextView;

@property (strong, nonatomic) IBOutlet UITextField *contactTextField;

@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;

- (IBAction)endEditing;

- (IBAction)upload;

@end
