//
//  YJNMultiTabView.h
//  FunctionTestOC
//
//  Created by YangJing on 2018/2/26.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNMultiTabConstant.h"

@class YJNMultiTabView;
@class YJNMultiTabButton;

@protocol YJNMultiTabDelegate <NSObject>
-(void)yjn_multiTabView:(YJNMultiTabView *)multiTab didSelectedTitle:(YJNMultiTabButton *)titleView atIndex:(NSUInteger)index;
@end

@interface YJNMultiTabView : UIView
@property (nonatomic, strong) NSArray <NSString *>* tabTitles;
@property (nonatomic, weak) id<YJNMultiTabDelegate> delegate;

/** 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 指示器颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 指示器风格 */
@property (nonatomic, assign) YJNMultiTabIndicatorStyle indicatorViewStyle;
/** 指定指示器宽度 */
@property (nonatomic, assign) CGFloat indicatorWidth;
/** 指定指示器高度 */
@property (nonatomic, assign) CGFloat indicatorHeight;
/** 设置标题左右偏移量(整体左右) 注意:此属性只有在内容大于屏幕的时候生效 */
@property (nonatomic, assign) YJNMultiTabViewEdgeInsets contentInset;
/** 中间间距(默认15) 注意:此属性只有在内容大于屏幕的时候生效 */
@property (nonatomic, assign) CGFloat spacing;
/** 是否显示指示器(默认YES) */
@property (nonatomic, assign) BOOL needIndicator;
/** 返回需要显示badge的下标 */
@property (nonatomic, strong) NSArray <NSNumber *>* slideTitlebadges;
/** 需要隐藏badge的下标 */
@property (nonatomic, strong) NSArray <NSNumber *>* hiddenSlideBadges;
/** badge的颜色 */
@property (nonatomic, strong) UIColor *badgeColor;
/** 底部线条颜色 */
@property (nonatomic, strong) UIColor *underlineColor;
/** 是否显示底部线条 (默认YES)*/
@property (nonatomic, assign) BOOL needUnderline;

@property (nonatomic, assign) NSInteger selectedTabIndex;

@end
