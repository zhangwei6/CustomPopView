//
//  ArtPopBaseView.m
//  PopView
//
//  Created by Admin on 2020/6/4.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopBaseView.h"

@interface ArtPopBaseView()

@property(nonatomic, strong) UIBezierPath *bezierPath;

@property(nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation ArtPopBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configSubview];
    }
    return self;
}

- (void)configSubview {
    
    [self.layer addSublayer:self.shapeLayer];
    [self addSubview:self.containerView];
    
    self.bezierPath = [UIBezierPath bezierPath];
}

- (CGFloat)getContainerWidth {
    return self.containerView.bounds.size.width;
}

- (CGFloat)getContainerHeight {
    return self.containerView.bounds.size.height;
}

// 获取曲线路径
- (CGPathRef)getBorderPath {
    
    self.bezierPath = [UIBezierPath bezierPath];
    
    CGFloat containerW = [self getContainerWidth];
    CGFloat containerH = [self getContainerHeight];
    
    // 设置起始点，左上角下
    CGFloat topleftBottomX = self.containerEdgeInsets.left;
    CGFloat topleftBottomY = self.containerEdgeInsets.top + self.triangleHeight + self.borderRadius;
    CGPoint topleftBottom = CGPointMake(topleftBottomX, topleftBottomY);
    [self.bezierPath moveToPoint:topleftBottom];
    
    // 左上角上
    CGFloat topLeftCenterX = self.containerEdgeInsets.left + self.borderRadius;
    CGFloat topLeftCenterY = self.containerEdgeInsets.top + self.triangleHeight + self.borderRadius;
    CGPoint topLeftCenter = CGPointMake(topLeftCenterX, topLeftCenterY);
    [self.bezierPath addArcWithCenter:topLeftCenter radius:self.borderRadius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:true];
    
    // 获取三角形左下角弧度占据的侧面的长度
    CGFloat arcToLineLength = [self getTriangleArcToLineLength];
    
    // 暂时设置三角形在视图的中间
    // 三角形左下角与整个的左上角的距离
    CGFloat deltaTopLeft = [self getMaxDeviationLength] + self.triangleDeviationLength;
    
    // 三角形左下角
    CGFloat triangleLeftBottomX = self.containerEdgeInsets.left + self.borderRadius + deltaTopLeft;
    CGFloat triangleLeftBottomY = self.containerEdgeInsets.top + self.triangleHeight;
    CGPoint triangleLeftBottomPoint = CGPointMake(triangleLeftBottomX, triangleLeftBottomY);
    [self.bezierPath addLineToPoint:triangleLeftBottomPoint];
    
    // 三角形左上角
    CGFloat triangleLeftTopRadius = arcToLineLength * tan((M_PI + self.triangleTopAngle) / 4);
    CGFloat triangleLeftTopCenterX = triangleLeftBottomX;
    CGFloat triangleLeftTopCenterY = triangleLeftBottomY - triangleLeftTopRadius;
    CGPoint triangleLeftTopCenter = CGPointMake(triangleLeftTopCenterX, triangleLeftTopCenterY);
    [self.bezierPath addArcWithCenter:triangleLeftTopCenter radius:triangleLeftTopRadius startAngle:M_PI_2 endAngle:self.triangleTopAngle / 2 clockwise:false];
    
    // 顶点坐标值
    CGFloat triangleTopX = triangleLeftBottomX + arcToLineLength + (self.triangleHeight * tan(self.triangleTopAngle / 2));
    CGFloat triangleTopY = self.containerEdgeInsets.top;
    
    if (self.isVertexTip) {
        
        // 顶点是尖角
        // 三角形顶点
        CGPoint triangleTopPoint = CGPointMake(triangleTopX, triangleTopY);
        [self.bezierPath addLineToPoint:triangleTopPoint];
        
    } else {
        
        // 顶点不是尖角
        // 三角形左上角弧度的起点,默认顶部弧度占据的侧面长度为总长度的1/4
        CGFloat triangleTopLeftX = triangleTopX - (self.triangleHeight * tan(self.triangleTopAngle / 2)) / 4;
        CGFloat triangleTopLeftY = triangleTopY + self.triangleHeight / 4;
        CGPoint triangleTopLeftPoint = CGPointMake(triangleTopLeftX, triangleTopLeftY);
        [self.bezierPath addLineToPoint:triangleTopLeftPoint];
        
        // 三角形右上角弧度
        CGFloat triangleTopRadius = arcToLineLength / (tan((M_PI - self.triangleTopAngle) / 2));
        CGFloat triangleTopCenterX = triangleTopX;
        CGFloat triangleTopCenterY = triangleTopY + (arcToLineLength / cos(self.triangleTopAngle / 2));
        CGPoint triangleTopCenter = CGPointMake(triangleTopCenterX, triangleTopCenterY);
        [self.bezierPath addArcWithCenter:triangleTopCenter radius:triangleTopRadius startAngle:(M_PI + self.triangleTopAngle / 2) endAngle:(M_2_PI - self.triangleTopAngle) clockwise:true];
    }
    
    // 三角形右上角
    CGFloat triangleRightTopX = triangleTopX + (self.triangleHeight * tan(self.triangleTopAngle / 2)) / 4 * 3;
    CGFloat triangleRightTopY = triangleTopY + self.triangleHeight / 4 * 3;
    CGPoint triangleRightTop = CGPointMake(triangleRightTopX, triangleRightTopY);
    [self.bezierPath addLineToPoint:triangleRightTop];

    // 三角形右下角
    CGFloat triangleRightBottomCenterX = triangleTopX + (self.triangleHeight * tan(self.triangleTopAngle / 2)) + arcToLineLength;
    CGFloat triangleRightBottomCenterY = triangleLeftBottomY - triangleLeftTopRadius;
    CGPoint triangleRightBottomCenter = CGPointMake(triangleRightBottomCenterX, triangleRightBottomCenterY);
    [self.bezierPath addArcWithCenter:triangleRightBottomCenter radius:triangleLeftTopRadius startAngle:M_PI - (self.triangleTopAngle) / 2 endAngle:M_PI_2 clockwise:false];

    // 右上角上
    CGFloat topRightTopX = containerW - self.containerEdgeInsets.right - self.borderRadius;
    CGFloat topRightTopY = self.containerEdgeInsets.top + self.triangleHeight;
    CGPoint topRightTop = CGPointMake(topRightTopX, topRightTopY);
    [self.bezierPath addLineToPoint:topRightTop];

    // 右上角下
    CGFloat topRightCenterX = topRightTopX;
    CGFloat topRightCenterY = topRightTopY + self.borderRadius;
    CGPoint topRightCenter = CGPointMake(topRightCenterX, topRightCenterY);
    [self.bezierPath addArcWithCenter:topRightCenter radius:self.borderRadius startAngle:M_PI / 2 * 3 endAngle:0 clockwise:true];

    // 右下角上
    CGFloat bottomRightTopX = containerW - self.containerEdgeInsets.right;
    CGFloat bottomRightTopY = containerH - self.containerEdgeInsets.bottom - self.borderRadius;
    CGPoint bottomRightTop = CGPointMake(bottomRightTopX, bottomRightTopY);
    [self.bezierPath addLineToPoint:bottomRightTop];

    // 右下角下
    CGFloat bottomRightCenterX = topRightTopX;
    CGFloat bottomRightCenterY = bottomRightTopY;
    CGPoint bottomRightCenter = CGPointMake(bottomRightCenterX, bottomRightCenterY);
    [self.bezierPath addArcWithCenter:bottomRightCenter radius:self.borderRadius startAngle:0 endAngle:M_PI_2 clockwise:true];

    // 左下角下
    CGFloat bottomLeftBottomX = self.containerEdgeInsets.left + self.borderRadius;
    CGFloat bottomLeftBottomY = containerH - self.containerEdgeInsets.bottom;
    CGPoint bottomLeftBottom = CGPointMake(bottomLeftBottomX, bottomLeftBottomY);
    [self.bezierPath addLineToPoint:bottomLeftBottom];

    // 左下角上
    CGFloat bottomLeftCenterX = self.containerEdgeInsets.left + self.borderRadius;
    CGFloat bottomLeftCenterY = bottomRightTopY;
    CGPoint bottomLeftCenter = CGPointMake(bottomLeftCenterX, bottomLeftCenterY);
    [self.bezierPath addArcWithCenter:bottomLeftCenter radius:self.borderRadius startAngle:M_PI_2 endAngle:M_PI clockwise:true];

    [self.bezierPath closePath];
    
    return self.bezierPath.CGPath;
}

// 获取三角形左下角弧度占据的侧面的长度
- (CGFloat)getTriangleArcToLineLength {
    // 三角形侧面的长度
    CGFloat leftLength = self.triangleHeight / cos(self.triangleTopAngle / 2);
    
    // 默认三角形左下角弧度占据的侧面的长度为总长度的1/4
    return leftLength / 4;
}

// 计算出总的最大可便宜的距离
- (CGFloat)getMaxDeviationLength {
    
    // 获取三角形左下角弧度占据的侧面的长度
    CGFloat arcToLineLength = [self getTriangleArcToLineLength];
    
    // 弧形三角形底部区域的宽度
    CGFloat triangleBottom = 2 * (arcToLineLength + self.triangleHeight * tan(self.triangleTopAngle / 2));
    
    // 三角形左下角与整个的左上角的距离
    CGFloat deltaTopLeft = ([self getContainerWidth] - self.containerEdgeInsets.left - self.containerEdgeInsets.right - (2 * self.borderRadius) - triangleBottom) / 2;
    
    return deltaTopLeft;
}

- (void)setTriangleDeviationLength:(CGFloat)triangleDeviationLength {
    
    _triangleDeviationLength = triangleDeviationLength;
    [self updateShow];
}

- (void)setIsTriangleUp:(BOOL)isTriangleUp {
    
    _isTriangleUp = isTriangleUp;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if (isTriangleUp) {
        
        self.shapeLayer.transform = CATransform3DIdentity;
        self.shapeLayer.position = CGPointMake(0, 0);
        
    } else {
        
        self.shapeLayer.position = CGPointMake(0,[self getContainerHeight]);
        
        CATransform3D transform3D = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        self.shapeLayer.transform = transform3D;
        
    }
    
    [CATransaction commit];
}

- (void)updateShow {
    // 设置路径
    self.shapeLayer.lineWidth = self.lineWidth;
    
    if (self.isNeedShadow) {
        self.shapeLayer.shadowColor = self.shadowColor.CGColor;
        self.shapeLayer.shadowOffset = self.shadowOffset;
        self.shapeLayer.shadowOpacity = self.shadowOpacity;
        self.shapeLayer.shadowRadius = self.borderRadius;
    }
    
    self.shapeLayer.shadowPath = [self getBorderPath];
    self.shapeLayer.path = [self getBorderPath];
    self.shapeLayer.fillColor  = UIColor.whiteColor.CGColor;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = UIColor.clearColor.CGColor;
    }
    return _shapeLayer;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.clearColor;
        _containerView.layer.masksToBounds = true;
    }
    return _containerView;
}

@end
