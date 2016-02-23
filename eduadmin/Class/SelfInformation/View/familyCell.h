//
//  familyCell.h
//  教务处
//
//  Created by Li Jie on 14-8-18.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface familyCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;

@property (nonatomic, weak) IBOutlet UILabel *relationship;

@property (nonatomic, weak) IBOutlet UILabel *politicalAffiliation;

@property (nonatomic, weak) IBOutlet UILabel *job;

@property (nonatomic, weak) IBOutlet UILabel *post;

@property (nonatomic, weak) IBOutlet UILabel *workLocation;

@property (nonatomic, weak) IBOutlet UILabel *tel;

@property (nonatomic, copy) NSString *tName;
@property (nonatomic, copy) NSString *tRelationship;
@property (nonatomic, copy) NSString *tPoliticalAffiliation;
@property (nonatomic, copy) NSString *tJob;
@property (nonatomic, copy) NSString *tPost;
@property (nonatomic, copy) NSString *tWorkLocation;
@property (nonatomic, copy) NSString *tTel;

@end
