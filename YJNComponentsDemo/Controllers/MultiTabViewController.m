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

@implementation MultiTabViewController {
    NSUInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tabView = [[YJNMultiTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    _tabView.delegate = self;
    _tabView.needUnderline = NO;
    _tabView.indicatorHeight = 5;
    _tabView.indicatorWidth = 60;
    _tabView.backgroundColor = [UIColor cyanColor];
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i < 13; i++) {
        NSString *title = [NSString stringWithFormat:@"Tab %d",i];
        [titles addObject:title];
    }
    _tabView.tabTitles = titles;
    [self.view addSubview:_tabView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 80, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"tab" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(p_tab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)p_tab:(UIButton *)sender {
    if (_currentIndex==self.tabView.tabTitles.count) {
        _currentIndex--;
    }else {
        _currentIndex ++;
    }
    
    self.tabView.selectedTabIndex = _currentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)yjn_multiTabView:(YJNMultiTabView *)multiTab didSelectedTitle:(YJNMultiTabButton *)titleView atIndex:(NSUInteger)index {
    NSLog(@"当前选中的是:%li",index);
    _currentIndex = index;
}

@end
