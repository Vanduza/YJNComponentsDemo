//
//  MultiTabViewController.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/2/27.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "MultiTabViewController.h"
#import "YJNMultiTabView.h"

@interface MultiTabViewController ()<YJNMultiTabDelegate>
@property (nonatomic, strong) YJNMultiTabView *tabView;
@end

@implementation MultiTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tabView = [[YJNMultiTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    _tabView.delegate = self;
    _tabView.backgroundColor = [UIColor cyanColor];
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i < 13; i++) {
        NSString *title = [NSString stringWithFormat:@"Tab %d",i];
        [titles addObject:title];
    }
    _tabView.tabTitles = titles;
    [self.view addSubview:_tabView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)yjn_multiTabView:(YJNMultiTabView *)multiTab didSelectedTitle:(YJNMultiTabButton *)titleView atIndex:(NSUInteger)index {
    NSLog(@"当前选中的是:%li",index);
}

@end
