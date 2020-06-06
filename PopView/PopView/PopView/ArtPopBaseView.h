//
//  ArtPopBaseView.h
//  PopView
//
//  Created by Admin on 2020/6/4.
//  Copyright © 2020 ZW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//角度转弧度
#define Degrees_To_Radians(angle) ((angle) / 180.0 * M_PI)

@interface ArtPopBaseView : UIView

// 距离上下左右的间距
@property(nonatomic, assign) UIEdgeInsets containerEdgeInsets;

// 四角的弧度的半径
@property(nonatomic, assign) CGFloat borderRadius;

// 线宽
@property(nonatomic, assign) CGFloat lineWidth;

// 顶点三角形的上角度（使用弧度制）
@property(nonatomic, assign) CGFloat triangleTopAngle;

// 顶点三角形的高度
@property(nonatomic, assign) CGFloat triangleHeight;

// 定点是否是尖角
@property(nonatomic, assign) BOOL isVertexTip;

// 三角形是否指向上方
@property(nonatomic, assign) BOOL isTriangleUp;

// 是否需要阴影
@property(nonatomic, assign) BOOL isNeedShadow;

// 阴影的偏移量
@property(nonatomic, assign) CGSize shadowOffset;

// 阴影的颜色
@property(nonatomic, strong) UIColor *shadowColor;

// 阴影透明度
@property(nonatomic, assign) CGFloat shadowOpacity;

// 设置顶部三角形的偏移距离，默认是0，表示不偏移
@property(nonatomic, assign) CGFloat triangleDeviationLength;

// 容器View
@property(nonatomic, strong) UIView *containerView;

// 计算出总的最大可便宜的距离
- (CGFloat)getMaxDeviationLength;

- (void)updateShow;

- (void)configSubview;

- (CGFloat)getContainerWidth;

- (CGFloat)getContainerHeight;

@end

NS_ASSUME_NONNULL_END
