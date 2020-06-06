//
//  ArtPopView.h
//  PopView
//
//  Created by Admin on 2020/6/5.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopBaseView.h"
#import "ArtPopBaseInnerView.h"

NS_ASSUME_NONNULL_BEGIN
@class ArtPopView;
typedef void(^ConfigBlock)(ArtPopView *);

@interface ArtPopView : ArtPopBaseView

// popView中间插入的视图
@property(nonatomic, strong) ArtPopBaseInnerView *innerView;

// popView中间插入视图与containerView间距
@property(nonatomic, assign) UIEdgeInsets innerViewInsets;

+ (instancetype)popViewWithInnerView:(ArtPopBaseInnerView *)innerView config:(ConfigBlock _Nullable) config;

@end

NS_ASSUME_NONNULL_END
