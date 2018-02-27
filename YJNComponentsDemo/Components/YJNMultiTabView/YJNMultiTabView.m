//
//  YJNMultiTabView.m
//  FunctionTestOC
//
//  Created by YangJing on 2018/2/26.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNMultiTabView.h"
#import "YJNMultiTabButton.h"

@interface YJNMultiTabView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIView *underline;
@end
@implementation YJNMultiTabView {
    NSMutableArray *_tabButtons;
    YJNMultiTabViewEdgeInsets _defaultInsets;
    UIFont *_defaultTitleFont;
    CGFloat _defaultSpacing;
    CGFloat _defaultIndicatorHeight;
    CGFloat _defaultIndicatorWidth;
    
    CGFloat _appendContentWidth;
    BOOL _isFirstLoad;
}

-(instancetype)init {
    if (self = [super init]) {
        [self p_initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initView];
    }
    return self;
}

-(void)p_initView {
    _defaultInsets = YJNMultiTabViewOffsetMake(15, 15);
    _defaultTitleFont = [UIFont systemFontOfSize:15.0f];
    _defaultSpacing = 15.0f;
    _defaultIndicatorHeight = 3;
    _defaultIndicatorWidth = 25;
    
    _isFirstLoad = YES;
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    CGFloat lineHeight = 1/[UIScreen mainScreen].scale;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    self.underline.frame = CGRectMake(0, self.bounds.size.height - lineHeight, screen_width, lineHeight);
//    self.indicator.frame = CGRectMake(0, self.bounds.size.height - _defaultIndicatorHeight, _defaultIndicatorWidth, _defaultIndicatorHeight);
    
    if(self.selectedTabIndex){
        if (self.delegate && [_delegate respondsToSelector:@selector(yjn_multiTabView:didSelectedTitle:atIndex:)]) {
            YJNMultiTabButton *selectedBtn = _tabButtons[_selectedTabIndex];
            [_delegate yjn_multiTabView:self didSelectedTitle:selectedBtn atIndex:_selectedTabIndex];
        }
    }
    
    if(!self.selectedTabIndex)self.selectedTabIndex = 0;
}

-(void)setTabTitles:(NSArray<NSString *> *)tabTitles {
    _tabTitles = tabTitles;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _tabButtons = [[NSMutableArray alloc] init];
    
    __block CGFloat titleButton_X = _defaultInsets.left;
    [_tabTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [self getWidthOfString:obj font:_defaultTitleFont];
        
        CGRect titleFrame = CGRectMake(titleButton_X, 0, width, CGRectGetHeight(self.bounds));
        YJNMultiTabButton *titleButton = [self createTabButtonFrame:titleFrame title:obj];
        titleButton.selected = self.selectedTabIndex == idx;
        titleButton.tag = idx;
        [titleButton addTarget:self action:@selector(tabDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_tabButtons addObject:titleButton];
        [self.scrollView addSubview:titleButton];

        titleButton_X = titleButton.frame.origin.x + CGRectGetWidth(titleButton.bounds) + _defaultSpacing;

        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(titleButton.frame) + titleButton.frame.origin.x + _defaultInsets.right, CGRectGetHeight(self.scrollView.bounds));

        _appendContentWidth = self.scrollView.contentSize.width;
    }];
}

- (void)updateSlideTitleAttributes{
    __block CGFloat titleButton_X = self.contentInset.left?self.contentInset.left:_defaultInsets.left;
    
    CGFloat spacing = self.spacing?self.spacing:_defaultSpacing;
    [_tabButtons enumerateObjectsUsingBlock:^(YJNMultiTabButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIFont *tempFont = self.titleFont?self.titleFont:_defaultTitleFont;
        UIColor *tempColor = self.titleColor?self.titleColor:[UIColor blackColor];
        UIColor *tempSeletedColor = self.selectedColor?self.selectedColor:[UIColor redColor];
        UIColor *tempNoticeColor = self.badgeColor?self.badgeColor:[UIColor redColor];
        
        CGFloat rigthSpace = self.contentInset.right?self.contentInset.right:_defaultInsets.right;
        CGFloat width = [self getWidthOfString:obj.titleLabel.text font:tempFont];
        
        CGRect titleFrame = CGRectMake(titleButton_X, 0, width, CGRectGetHeight(self.bounds));
        obj.frame = titleFrame;
        obj.selected = idx == self.selectedTabIndex;
        obj.titleLabel.font = tempFont;
        obj.badgeColor = tempNoticeColor;
        
        [obj setTitleColor:tempSeletedColor forState:UIControlStateSelected];
        [obj setTitleColor:tempColor forState:UIControlStateNormal];

        titleButton_X = obj.frame.origin.x + CGRectGetWidth(obj.bounds) + spacing;

        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(obj.frame) + obj.frame.origin.x + rigthSpace, CGRectGetHeight(self.scrollView.bounds));

        _appendContentWidth = self.scrollView.contentSize.width;
    }];
    
    if(_appendContentWidth<=self.frame.size.width){
        [_tabButtons enumerateObjectsUsingBlock:^(YJNMultiTabButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat width = self.frame.size.width / _tabButtons.count;
            CGRect titleFrame = CGRectMake(idx * width, 0, width, CGRectGetHeight(self.bounds));
            obj.frame = titleFrame;
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        }];
    }
    
    if(_selectedTabIndex<_tabButtons.count){
        [self setSelectedButtonCenter:_tabButtons[_selectedTabIndex]];
        [self updateIndicatorViewOffsetCurrentButton:_tabButtons[_selectedTabIndex]];
    }
}

#pragma mark - action
- (void)tabDidSelected:(YJNMultiTabButton *)sender{
    _isFirstLoad = NO;
    
    if (self.delegate && [_delegate respondsToSelector:@selector(yjn_multiTabView:didSelectedTitle:atIndex:)]) {
        [_delegate yjn_multiTabView:self didSelectedTitle:sender atIndex:sender.tag];
    }
    
    [self setSelectedButtonCenter:sender];
    
    [self updateIndicatorViewOffsetCurrentButton:sender];
    
    [self updateSeletedButton:sender];
}

- (void)updateSeletedButton:(YJNMultiTabButton *)sender{
    [_tabButtons enumerateObjectsUsingBlock:^(YJNMultiTabButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj.tag == sender.tag;
        UIColor *tempColor = self.titleColor?self.titleColor:[UIColor blackColor];
        UIColor *tempSeletedColor = self.selectedColor?self.selectedColor:[UIColor redColor];
        if(obj.selected){
            obj.titleLabel.textColor = tempSeletedColor;
        }
        else{
            obj.titleLabel.textColor = tempColor;
        }
    }];
}

- (void)updateIndicatorViewOffsetCurrentButton:(YJNMultiTabButton *)sender{
    if(sender.tag>_tabButtons.count)return;
    
    __block CGFloat indicatorView_W = 0,indicatorView_H = _defaultIndicatorHeight,indicatorView_X = 0,indicatorView_Y = CGRectGetHeight(self.bounds) - indicatorView_H;
    
    if (_appendContentWidth <= self.bounds.size.width) {
        [UIView animateWithDuration:_isFirstLoad?0:0.2 animations:^{
            switch (self.indicatorViewStyle) {
                case YJNMultiTabIndicatorStyleDefault: {
                    indicatorView_X = sender.center.x - _defaultIndicatorWidth / 2;
                    indicatorView_W = _defaultIndicatorWidth;
                }break;
                case YJNMultiTabIndicatorStyleTextWidth: {
                    indicatorView_W = [self getWidthOfString:sender.titleLabel.text font:sender.titleLabel.font];
                    indicatorView_X = sender.center.x - indicatorView_W / 2;
                }break;
                case YJNMultiTabIndicatorStyleAverageWidth: {
                    indicatorView_W = CGRectGetWidth(sender.bounds);
                    indicatorView_X = sender.frame.origin.x;
                }break;
                    
                default: {
                    indicatorView_X = sender.center.x - _defaultIndicatorWidth / 2;
                    indicatorView_W = _defaultIndicatorWidth;
                }break;
            }
            self.indicator.frame = CGRectMake(indicatorView_X, indicatorView_Y, indicatorView_W, indicatorView_H);
        }];
    }else {
        [UIView animateWithDuration:_isFirstLoad?0:0.2 animations:^{
            switch (self.indicatorViewStyle) {
                case YJNMultiTabIndicatorStyleDefault: {
                    indicatorView_X = sender.center.x - _defaultIndicatorWidth / 2;
                    indicatorView_W = _defaultIndicatorWidth;
                }break;
                case YJNMultiTabIndicatorStyleTextWidth: {
                    indicatorView_X = sender.frame.origin.x;
                    indicatorView_W = [self getWidthOfString:sender.titleLabel.text font:sender.titleLabel.font];
                }break;
                    
                default: {
                    indicatorView_X = sender.center.x - _defaultIndicatorWidth / 2;
                    indicatorView_W = _defaultIndicatorWidth;
                }break;
            }
            self.indicator.frame = CGRectMake(indicatorView_X, indicatorView_Y, indicatorView_W, indicatorView_H);
        }];
    }
}

- (void)setSelectedButtonCenter:(YJNMultiTabButton *)sender {
    if(sender.tag>_tabButtons.count)return;

    CGFloat offsetX = sender.center.x - self.bounds.size.width * 0.5;
    if (offsetX < 0) offsetX = 0;

    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.frame.size.width;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;

    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (CGFloat)getWidthOfString:(NSString *)content font:(UIFont *)font{
    NSDictionary *attrDic = @{NSFontAttributeName:font};
    CGRect strRect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];
    return strRect.size.width;
}

- (YJNMultiTabButton *)createTabButtonFrame:(CGRect)frame title:(NSString *)title{
    YJNMultiTabButton *btn = [YJNMultiTabButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    btn.frame = frame;
    return btn;
}

#pragma mark - getter
- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_underline];
    }
    return _underline;
}
-(UIView *)indicator {
    if (!_indicator) {
        _indicator = [[UIView alloc] init];
        _indicator.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:_indicator];
    }
    return _indicator;
}

#pragma mark - setter
-(void)setSelectedTabIndex:(NSInteger)selectedTabIndex {
    _selectedTabIndex = selectedTabIndex;
    [self updateSlideTitleAttributes];
}

-(void)setNeedIndicator:(BOOL)needIndicator {
    _needIndicator = needIndicator;
    self.indicator.hidden = _needIndicator;
}

- (void)setContentInset:(YJNMultiTabViewEdgeInsets)contentInset{
    _contentInset = contentInset;
    [self updateSlideTitleAttributes];
}

-(void)setIndicatorViewStyle:(YJNMultiTabIndicatorStyle)indicatorViewStyle {
    _indicatorViewStyle = indicatorViewStyle;
    [self updateSlideTitleAttributes];
}

@end
