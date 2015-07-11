//
//  familyCell.m
//  教务处
//
//  Created by 李杰 on 14-8-18.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "familyCell.h"

@implementation familyCell

+ (id)newFamilyCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"familyCell" owner:nil options:nil][0];
}

- (void)setTName:(NSString *)tName
{
    _tName = tName;
    self.name.text = tName;
}

- (void)setTRelationship:(NSString *)tRelationship
{
    _tRelationship = tRelationship;
    self.relationship.text = [NSString stringWithFormat:@"（%@）", tRelationship];
}

- (void)setTPoliticalAffiliation:(NSString *)tPoliticalAffiliation
{
    _tPoliticalAffiliation = tPoliticalAffiliation;
    self.politicalAffiliation.text = tPoliticalAffiliation;
}

- (void)setTJob:(NSString *)tJob
{
    _tJob = tJob;
    self.job.text = tJob;
}

- (void)setTPost:(NSString *)tPost
{
    _tPost = tPost;
    self.post.text = tPost;
}

- (void)setTWorkLocation:(NSString *)tWorkLocation
{
    _tWorkLocation = tWorkLocation;
    self.workLocation.text = tWorkLocation;
}

- (void)setTTel:(NSString *)tTel
{
    _tTel = tTel;
    self.tel.text = tTel;
}


@end
