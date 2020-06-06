//
//  ViewController.m
//  PopView
//
//  Created by Admin on 2020/6/4.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ViewController.h"
#import "ArtPopViewOperate.h"
#import <Masonry/Masonry.h>
#import "ArtPopTestView.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *btn1;
@property(nonatomic, strong) UIButton *btn2;
@property(nonatomic, strong) UIButton *btn3;
@property(nonatomic, strong) UIButton *btn4;
@property(nonatomic, strong) UIButton *btn5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubView];
    [self configValue];
}

- (void)configSubView {
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
//    [self.view addSubview:self.popView];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.bottom.mas_equalTo(self.view).mas_offset(-150);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.bottom.mas_equalTo(self.view).mas_offset(-150);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)configValue {
    [self.btn1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn4 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn5 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction:(UIButton *)btn {
    
    ArtPopTestView *innerView = [[ArtPopTestView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    innerView.backgroundColor = UIColor.greenColor;
    
    CGSize offset = CGSizeZero;
    
    [ArtPopViewOperate showPopWithInnerView:innerView On:btn offset:offset config:^(ArtPopView * _Nonnull popView) {
        
        // 自定义popView参数
        popView.shadowColor = UIColor.redColor;
        popView.innerViewInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    }];
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [[UIButton alloc] init];
        _btn1.backgroundColor = UIColor.redColor;
        [_btn1 setTitle:@"1" forState:UIControlStateNormal];
        _btn1.tag = 1;
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [[UIButton alloc] init];
        _btn2.backgroundColor = UIColor.redColor;
        [_btn2 setTitle:@"2" forState:UIControlStateNormal];
        _btn2.tag = 2;
    }
    return _btn2;
}

- (UIButton *)btn3 {
    if (!_btn3) {
        _btn3 = [[UIButton alloc] init];
        _btn3.backgroundColor = UIColor.redColor;
        [_btn3 setTitle:@"3" forState:UIControlStateNormal];
        _btn3.tag = 3;
    }
    return _btn3;
}

- (UIButton *)btn4 {
    if (!_btn4) {
        _btn4 = [[UIButton alloc] init];
        _btn4.backgroundColor = UIColor.redColor;
        [_btn4 setTitle:@"4" forState:UIControlStateNormal];
        _btn4.tag = 4;
    }
    return _btn4;
}

- (UIButton *)btn5 {
    if (!_btn5) {
        _btn5 = [[UIButton alloc] init];
        _btn5.backgroundColor = UIColor.redColor;
        [_btn5 setTitle:@"5" forState:UIControlStateNormal];
        _btn5.tag = 5;
    }
    return _btn5;
}

@end
