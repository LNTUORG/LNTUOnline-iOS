//
//  FeedbackViewController.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

- (IBAction)endEditing;

- (IBAction)upload;

@end
