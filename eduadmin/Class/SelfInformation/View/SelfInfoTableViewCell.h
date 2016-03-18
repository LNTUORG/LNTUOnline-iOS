//
//  CellItem.h
//  教务处
//
//  Created by Li Jie on 14-8-10.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInfoNormalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *keyLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@end

@interface SelfInfoEduTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *schoolInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *witnessLabel;
@end

@interface SelfInfoFamilyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *politicalAffiliationLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;
@property (strong, nonatomic) IBOutlet UILabel *workLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@end
