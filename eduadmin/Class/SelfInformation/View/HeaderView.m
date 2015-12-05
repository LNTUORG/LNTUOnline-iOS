//
//  JWHeaderView.m
//  lntuApp
//
//  Created by Li Jie on 14/11/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "HeaderView.h"
#import "Title.h"

@interface HeaderView ()

@property (nonatomic,weak) UIButton *nameView;

@end

@implementation HeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"header";
    HeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (view == nil) {
        
        view = [[HeaderView alloc] initWithReuseIdentifier:ID];
    }
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 1.添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        nameView.backgroundColor = [UIColor redColor];
        
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //        nameView.imageEdgeInsets = ;
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [nameView addTarget:self action:@selector(viewClick) forControlEvents:UIControlEventTouchUpInside];
        
        _nameView = nameView;
        [self.contentView addSubview:nameView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _nameView.frame = self.bounds;
}


- (void)setTitle:(Title *)title {
    
    _title = title;
    [self.nameView setTitle:title.name forState:UIControlStateNormal];
}

- (void)viewClick {
    
    self.title.open = !self.title.isOpen;
    
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickNameView:)]) {
        
        [self.delegate headerViewDidClickNameView:self];
    }
    
}

- (void)didMoveToSuperview {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    
    if (self.title.open) {
        
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    } else {
        
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    [UIView commitAnimations];
}
@end
