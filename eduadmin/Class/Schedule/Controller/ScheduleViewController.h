//
//  ScheduleViewController.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTabScrollView.h"

@interface ScheduleViewController : UIViewController <MSTabScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImg;

- (IBAction)reloadCourse:(id)sender;

@end
