//
//  ArtPopViewOperate.m
//  PopView
//
//  Created by Admin on 2020/6/6.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopViewOperate.h"

static NSInteger containerTag = 111;

@implementation ArtPopViewOperate

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView {
    
    [self showPopWithInnerView:innerView On:onView offset:CGSizeZero config:nil];
}

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView offset:(CGSize)offset {
    
    [self showPopWithInnerView:innerView On:onView offset:offset config:nil];
}

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView config:(ConfigBlock _Nullable) config {
    
    [self showPopWithInnerView:innerView On:onView offset:CGSizeZero config:config];
}

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView offset:(CGSize)offset config:(ConfigBlock _Nullable) config {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) { return; }
    
    // 获取onView相对于window的位置
    CGRect onViewRect = [window convertRect:onView.frame toView:window];
    CGPoint onViewCenterPoint = CGPointMake(CGRectGetMidX(onViewRect), CGRectGetMidY(onViewRect));
    
    [self showPopWithInnerView:innerView OnPoint:onViewCenterPoint offset:offset config:config];
}

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView OnPoint:(CGPoint)onPoint offset:(CGSize)offset config:(ConfigBlock) config {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) { return; }
    
    // 全屏view
    UIView *containerView = [UIView new];
    containerView.backgroundColor = UIColor.clearColor;
    containerView.frame = [UIScreen mainScreen].bounds;
    containerView.tag = containerTag;     // 这里添加tag是为了手动删除toast
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [containerView addGestureRecognizer:tapGes];
    [window addSubview:containerView];
    [window bringSubviewToFront:containerView];

    // 获取onPoint相对于window的位置
    CGPoint convertedPoint = [window convertPoint:onPoint toWindow:window];
    
    // 将中心点偏移指定的距离
    convertedPoint = CGPointMake(convertedPoint.x + offset.width, convertedPoint.y + offset.height);
    
    // 创建popView
    ArtPopView *popView = [ArtPopView popViewWithInnerView:innerView config:config];
    [containerView addSubview:popView];
    
    CGFloat popViewW = [popView getContainerWidth];
    CGFloat popViewH = [popView getContainerHeight];

    CGFloat newPopX = convertedPoint.x - popViewW / 2;

    // 获取当前popView顶点三角形左右最大可偏移距离（从顶点在中间往左右两边偏移）
    CGFloat maxDeviationLength = [popView getMaxDeviationLength];

    if (newPopX < 0) {

        // 表示顶部三角形需要偏移
        if (fabs(newPopX) < maxDeviationLength) {

            // 偏移的距离在可接受范围内
            NSLog(@"偏移距离为：%f", newPopX);
            popView.triangleDeviationLength = newPopX;
        } else {
            NSLog(@"偏移距离为：%f", -maxDeviationLength);
            popView.triangleDeviationLength = -maxDeviationLength;
        }

        newPopX = 0;

    } else if ((newPopX + popViewW) > kScreenWidth) {

        CGFloat delta = newPopX + popViewW - kScreenWidth;

        if (delta < maxDeviationLength) {
            popView.triangleDeviationLength = delta;
        } else {
            popView.triangleDeviationLength = maxDeviationLength;
        }

        newPopX = kScreenWidth - popViewW;

    } else {

        popView.triangleDeviationLength = 0;
    }

    CGFloat newPopY = convertedPoint.y;

    if ((newPopY + popViewH) > kScreenHeight) {
        newPopY = newPopY - popViewH;
        popView.isTriangleUp = false;
    } else {
        popView.isTriangleUp = true;
    }

    popView.frame = CGRectMake(newPopX, newPopY, popViewW, popViewH);

    [popView updateShow];
}

+ (void)hidePopView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (!window) { return; }
    
    for (UIView *view in window.subviews) {
        
        if (view.tag == containerTag) {
            
            [view removeFromSuperview];
        }
    }
}

+ (void)tapAction:(UITapGestureRecognizer *)tapGes {
    
    UIView *containerView = tapGes.view;
    
    // 获取popView
    ArtPopView *popView;
    for (UIView *subView in containerView.subviews) {
        
        if ([subView isKindOfClass:[ArtPopView class]]) {
            popView = (ArtPopView *)subView;
        }
    }
    
    CGRect popViewRect = [containerView convertRect:popView.frame toView:containerView];
    CGPoint tapPoint = [tapGes locationInView:containerView];
    
    if (!CGRectContainsPoint(popViewRect, tapPoint)) {
        [self hidePopView];
    }
}

@end
