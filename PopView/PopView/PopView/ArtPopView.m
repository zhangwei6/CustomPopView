//
//  ArtPopView.m
//  PopView
//
//  Created by Admin on 2020/6/5.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopView.h"

@interface ArtPopView()

@end

@implementation ArtPopView

+ (instancetype)popViewWithInnerView:(ArtPopBaseInnerView *)innerView config:(ConfigBlock _Nullable) config {
    
    ArtPopView *popView = [[ArtPopView alloc] init];
    
    // 默认设置
    popView.backgroundColor = UIColor.clearColor;
    popView.containerEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    popView.borderRadius = 10;
    popView.lineWidth = 1;
    popView.triangleTopAngle = M_PI / 3;
    popView.triangleHeight = 20;
    popView.isVertexTip = false;
    popView.isNeedShadow = true;
    popView.shadowOffset = CGSizeMake(0, 0);
    popView.shadowColor = UIColor.blackColor;
    popView.shadowOpacity = 0.4;
    popView.isTriangleUp = true;
    popView.innerViewInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 自定义设置
    config(popView);
    
    popView.innerView = innerView;
    return popView;
}

- (void)setInnerView:(ArtPopBaseInnerView *)innerView {
    
    _innerView = innerView;
    
    [self.containerView addSubview:innerView];
    
    [innerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.innerViewInsets);
    }];
}

// 获取容器的宽度
- (CGFloat)getContainerWidth {
    return [self.innerView getInnerViewWidth] + self.containerEdgeInsets.left + self.containerEdgeInsets.right;
}

// 获取容器的高度
- (CGFloat)getContainerHeight {
    return [self.innerView getInnerViewHeight] + self.containerEdgeInsets.top + self.triangleHeight + self.containerEdgeInsets.bottom;
}

- (void)updateShow {
    
    [super updateShow];
    
    self.containerView.layer.cornerRadius = self.borderRadius;
        
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).mas_offset(self.containerEdgeInsets.left);
        make.right.mas_equalTo(self).mas_offset(-self.containerEdgeInsets.right);

        if (self.isTriangleUp) {

            make.top.mas_equalTo(self).mas_offset(self.containerEdgeInsets.top + self.triangleHeight);
            make.bottom.mas_equalTo(self).mas_offset(-self.containerEdgeInsets.bottom);

        } else {

            make.top.mas_equalTo(self).mas_offset(self.containerEdgeInsets.top);
            make.bottom.mas_equalTo(self).mas_offset(-(self.containerEdgeInsets.bottom + self.triangleHeight));
        }
    }];
}

@end
