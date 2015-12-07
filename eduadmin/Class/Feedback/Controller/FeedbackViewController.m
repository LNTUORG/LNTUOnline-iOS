//
//  FeedbackViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.infoTextView];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 按钮状态
- (void)textChange {
    
    self.uploadBtn.enabled = (self.infoTextView.text.length);
}


- (IBAction)endEditing {
    
    [self.view endEditing:YES];
}

- (IBAction)upload {
    
//    [MBProgressHUD showMessage:WAITSTR];
//    
//    NSDictionary *param = @{@"info":self.infoTextView.text,
//                            @"contact":self.contactTextField.text
//                            };
//    
//    [LJHTTPTool postHTTPWithURL:[NSString stringWithFormat:@"%@crash-log",MAINURL] params:param success:^(id responseHTTP) {
//        
//        NSString *flag = [[NSString alloc] initWithData:responseHTTP encoding:NSUTF8StringEncoding];
//        
//        if ([flag isEqualToString:@"OK"]) {
//            
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showSuccess:@"感谢您的反馈"];
//            
//        }else{
//            
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showError:@"出现异常"];
//        }
//        
//    } failure:^(NSError *error) {
//        
//        [MBProgressHUD hideHUD];
//    }];
}

@end
