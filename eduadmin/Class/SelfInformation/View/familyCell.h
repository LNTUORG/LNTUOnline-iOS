//
//  familyCell.h
//  教务处
//
//  Created by Li Jie on 14-8-18.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface familyCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *relationship;

@property (strong, nonatomic) IBOutlet UILabel *politicalAffiliation;

@property (strong, nonatomic) IBOutlet UILabel *job;

@property (strong, nonatomic) IBOutlet UILabel *post;

@property (strong, nonatomic) IBOutlet UILabel *workLocation;

@property (strong, nonatomic) IBOutlet UILabel *tel;

@property (nonatomic, copy) NSString *tName;
@property (nonatomic, copy) NSString *tRelationship;
@property (nonatomic, copy) NSString *tPoliticalAffiliation;
@property (nonatomic, copy) NSString *tJob;
@property (nonatomic, copy) NSString *tPost;
@property (nonatomic, copy) NSString *tWorkLocation;
@property (nonatomic, copy) NSString *tTel;

@end
