//
//  YJNChooseList.m
//  FunctionTestOC
//
//  Created by YangJing on 2018/1/10.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNChooseList.h"
#import "YJNChooseListCover.h"
@interface YJNChooseListCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end
@implementation YJNChooseListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(void)layoutSubviews {
    _titleLabel.frame = self.bounds;
    [super layoutSubviews];
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end

@implementation YJNChooseItem {}
@end

@interface YJNChooseList() <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *list;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YJNChooseListCover *cover;
@end
@implementation YJNChooseList {
    UIView *background;
}
-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    //背景
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    //底布
    background = [[UIView alloc]initWithFrame:CGRectZero];
    background.backgroundColor = [UIColor whiteColor];
//    UIView *section = [[UIView alloc] initWithFrame:CGRectZero];
//    [background addSubview:section];
    CGFloat title_ratio = 53.0 / 375.0;
    CGFloat titleHeight = [UIScreen mainScreen].bounds.size.width * title_ratio;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];

    UIButton *cancle = [[UIButton alloc] init];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(hideList) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    
    [_titleLabel addSubview:line1];
    [background addSubview:self.titleLabel];
    [background addSubview:self.list];
    [background addSubview:self.cover];
    [background addSubview:line2];
    [background addSubview:cancle];
    [self addSubview:background];
    
    //layout
    //line1
    line1.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat line1Height = 1.0 / [UIScreen mainScreen].scale;
    NSLayoutConstraint *line1_left = [NSLayoutConstraint constraintWithItem:line1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *line1_right = [NSLayoutConstraint constraintWithItem:line1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *line1_bottom = [NSLayoutConstraint constraintWithItem:line1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *line1_height = [NSLayoutConstraint constraintWithItem:line1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:line1Height];
    [self.titleLabel addConstraints:@[line1_left,line1_right,line1_bottom]];
    [line1 addConstraint:line1_height];
    
    //titleLabel
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *label_top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *label_left = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *label_right = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *label_height = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:titleHeight];
    [background addConstraints:@[label_top,label_left,label_right]];
    [self.titleLabel addConstraint:label_height];
    
    //list
    self.list.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat row_ratio = 40.0 / 375.0;
    CGFloat rowHeight = [UIScreen mainScreen].bounds.size.width * row_ratio;
    NSLayoutConstraint *list_top = [NSLayoutConstraint constraintWithItem:self.list attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *list_left = [NSLayoutConstraint constraintWithItem:self.list attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *list_right = [NSLayoutConstraint constraintWithItem:self.list attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *list_bottom = [NSLayoutConstraint constraintWithItem:self.list attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:line2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *list_height = [NSLayoutConstraint constraintWithItem:self.list attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:rowHeight * _maxRowNum];
    list_height.priority = 750;
    list_height.identifier = @"list_height";
    [background addConstraints:@[list_top,list_left,list_right,list_bottom]];
    [self.list addConstraint:list_height];
    
    //cover
    self.cover.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *cover_leading = [NSLayoutConstraint constraintWithItem:self.cover attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *cover_trailing = [NSLayoutConstraint constraintWithItem:self.cover attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *cover_top = [NSLayoutConstraint constraintWithItem:self.cover attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *cover_bottom = [NSLayoutConstraint constraintWithItem:self.cover attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:line2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *cover_height = [NSLayoutConstraint constraintWithItem:self.cover attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:160];
    cover_height.identifier = @"cover_height";
    cover_height.priority = 749;
    [background addConstraints:@[cover_top,cover_leading,cover_trailing,cover_bottom]];
    [self.cover addConstraint:cover_height];
    
    //line2
    line2.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat line2Height = 7.0 * line1Height;
    NSLayoutConstraint *line2_left = [NSLayoutConstraint constraintWithItem:line2 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *line2_right = [NSLayoutConstraint constraintWithItem:line2 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *line2_bottom = [NSLayoutConstraint constraintWithItem:line2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cancle attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *line2_height = [NSLayoutConstraint constraintWithItem:line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:line2Height];
    [background addConstraints:@[line2_left,line2_right,line2_bottom]];
    [line2 addConstraint:line2_height];
    
    //cancle
    cancle.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *btn_left = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *btn_right = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *btn_height = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:rowHeight];
    NSLayoutConstraint *btn_bottom = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [background addConstraints:@[btn_left,btn_right,btn_bottom]];
    [cancle addConstraint:btn_height];
    
    //background
    background.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bg_left = [NSLayoutConstraint constraintWithItem:background attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bg_right = [NSLayoutConstraint constraintWithItem:background attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bg_bottom = [NSLayoutConstraint constraintWithItem:background attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[bg_left,bg_right,bg_bottom]];
}

-(void)hideList {
    [self removeFromSuperview];
}

-(void)listWait {
    self.cover.hidden = NO;
    NSLayoutConstraint *list_height = nil;
    for (NSLayoutConstraint *constraint in self.list.constraints) {
        if ([constraint.identifier isEqualToString:@"list_height"]) {
            list_height = constraint;
        }
    }
    
    NSLayoutConstraint *cover_height = nil;
    for (NSLayoutConstraint *constraint in self.cover.constraints) {
        if ([constraint.identifier isEqualToString:@"cover_height"]) {
            cover_height = constraint;
        }
    }
    
    list_height.priority = 749;
    cover_height.priority = 750;
    
    [UIView animateWithDuration:0.3 animations:^{
        [background layoutIfNeeded];
    } completion:nil];
}

-(void)showList {
    NSLayoutConstraint *list_height = nil;
    for (NSLayoutConstraint *constraint in self.list.constraints) {
        if ([constraint.identifier isEqualToString:@"list_height"]) {
            list_height = constraint;
        }
    }
    
    NSLayoutConstraint *cover_height = nil;
    for (NSLayoutConstraint *constraint in self.cover.constraints) {
        if ([constraint.identifier isEqualToString:@"cover_height"]) {
            cover_height = constraint;
        }
    }
    
    list_height.priority = 750;
    cover_height.priority = 749;
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0;
        [background layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.cover.hidden = YES;
    }];
}

-(void)showError:(NSString *)error {
    if (self.cover.superview) {
        self.cover.infoLabel.text = error;
    }
}

-(UITableView *)list {
    if (!_list) {
        CGFloat ratio = 40.0 / 375.0;
        _list = [[UITableView alloc] init];
        [_list registerClass:[YJNChooseListCell class] forCellReuseIdentifier:@"YJNChooseListCell"];
        _list.rowHeight = [UIScreen mainScreen].bounds.size.width * ratio;
        _list.delegate = self;
        _list.dataSource = self;
        _list.showsHorizontalScrollIndicator = NO;
        _list.bounces = NO;
        _list.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _list.separatorInset = UIEdgeInsetsZero;
    }
    return _list;
}

-(YJNChooseListCover *)cover {
    if (!_cover) {
        _cover = [[YJNChooseListCover alloc] init];
        _cover.hidden = YES;
        [_cover.indicator startAnimating];
    }
    return _cover;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

-(void)setMaxRowNum:(NSInteger)maxRowNum {
    _maxRowNum = maxRowNum;
    if (maxRowNum > 0 && maxRowNum < 6) {
        _maxRowNum = maxRowNum;
    }else {
        _maxRowNum = 0;
    }
    [self updateListHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowNum = 0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowsInChooseList:)]) {
        rowNum = [_dataSource numberOfRowsInChooseList:self];
        //避免numberOfRowsInSection多次调用时 rowNum==_maxRowNum 重复
        if (rowNum < _maxRowNum) {
            self.maxRowNum = rowNum;
            self.list.bounces = NO;
        }else if (rowNum > _maxRowNum) {
            self.list.bounces = YES;
        }
    }
    return rowNum;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJNChooseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJNChooseListCell"];
    YJNChooseItem *item = [_dataSource chooseList:self itemForRow:indexPath.row];
    cell.titleLabel.text = item.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(chooseList:didSelectedRow:)]) {
        [_delegate chooseList:self didSelectedRow: indexPath.row];
    }
}

-(void)updateListHeight {
    //list
    CGFloat row_ratio = 40.0 / 375.0;
    CGFloat rowHeight = [UIScreen mainScreen].bounds.size.width * row_ratio;
    
    for (NSLayoutConstraint *constraint in self.list.constraints) {
        if ([constraint.identifier isEqualToString:@"list_height"]) {
            constraint.constant = rowHeight * _maxRowNum;
            [self.list updateConstraintsIfNeeded];
        }
    }
}

@end

