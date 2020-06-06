//
//  ArtPopViewOperate.h
//  PopView
//
//  Created by Admin on 2020/6/6.
//  Copyright © 2020 ZW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtPopViewOperate : NSObject

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView;

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView offset:(CGSize)offset;

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView config:(ConfigBlock _Nullable) config;

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView On:(UIView *)onView offset:(CGSize)offset config:(ConfigBlock _Nullable) config;

+ (void)showPopWithInnerView:(ArtPopBaseInnerView *)innerView OnPoint:(CGPoint)onPoint offset:(CGSize)offset config:(ConfigBlock) config;

+ (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
