//
//  ArtPopTestView.m
//  PopView
//
//  Created by Admin on 2020/6/6.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopTestView.h"
#import "ArtPopViewOperate.h"

@interface ArtPopTestView()

@property(nonatomic, strong) UILabel *testLab;

@property(nonatomic, strong) UIButton *testBtn;

@end

@implementation ArtPopTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubview];
    }
    return self;
}

- (void)configSubview {
    
    [self addSubview:self.testLab];
    [self addSubview:self.testBtn];
    
    [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
    }];
    
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.testLab.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [self.testBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction: (UIButton *)btn {
    
    [ArtPopViewOperate hidePopView];
}

- (UILabel *)testLab {
    if (!_testLab) {
        _testLab = [UILabel new];
        _testLab.text = @"测试";
        _testLab.textColor = UIColor.blackColor;
    }
    return _testLab;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [[UIButton alloc] init];
        [_testBtn setTitle:@"隐藏PopView" forState:UIControlStateNormal];
        [_testBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    }
    return _testBtn;
}

@end
