//
//  familyCell.h
//  教务处
//
//  Created by 李杰 on 14-8-18.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface familyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *relationship;

@property (weak, nonatomic) IBOutlet UILabel *politicalAffiliation;

@property (weak, nonatomic) IBOutlet UILabel *job;

@property (weak, nonatomic) IBOutlet UILabel *post;

@property (weak, nonatomic) IBOutlet UILabel *workLocation;

@property (weak, nonatomic) IBOutlet UILabel *tel;

@property (nonatomic,copy) NSString *tName;
@property (nonatomic,copy) NSString *tRelationship;
@property (nonatomic,copy) NSString *tPoliticalAffiliation;
@property (nonatomic,copy) NSString *tJob;
@property (nonatomic,copy) NSString *tPost;
@property (nonatomic,copy) NSString *tWorkLocation;
@property (nonatomic,copy) NSString *tTel;

+ (id)newFamilyCell;

@end
