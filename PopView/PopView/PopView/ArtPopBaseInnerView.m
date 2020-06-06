//
//  ArtPopBaseInnerView.m
//  PopView
//
//  Created by Admin on 2020/6/6.
//  Copyright © 2020 ZW. All rights reserved.
//

#import "ArtPopBaseInnerView.h"

// 默认的宽高，如果当前视图的宽高小于设置的值，那么使用该值
#define defSize CGSizeMake(200, 300)

@implementation ArtPopBaseInnerView

// 获取innerView的宽度
- (CGFloat)getInnerViewWidth {
    
    if (self.frame.size.width < defSize.width) {
        return defSize.width;
    }
    
    return self.frame.size.width;
}

// 获取innerView的高度
- (CGFloat)getInnerViewHeight {
    if (self.frame.size.height < defSize.height) {
        return defSize.height;
    }
    
    return self.frame.size.height;
}

@end
