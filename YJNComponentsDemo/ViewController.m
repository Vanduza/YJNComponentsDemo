//
//  ViewController.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/11.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "ViewController.h"
#import "YJNChooseList.h"

@interface ViewController ()<YJNChooseListDataSource,YJNChooseListDelegate>
@property (nonatomic, strong) YJNChooseList* chooseList;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i = 0; i < 6; i++) {
        YJNChooseItem *item = [[YJNChooseItem alloc] init];
        item.title = [NSString stringWithFormat:@"Doctor%d",i];
        item.ID = [NSString stringWithFormat:@"id%d",i];
        [self.dataArr addObject:item];
    }
    
    [self.view addSubview:self.chooseList];
    self.chooseList.frame = self.view.bounds;
    
    [self.chooseList listWait];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chooseList showList];
    });
}

-(YJNChooseList *)chooseList {
    if (!_chooseList) {
        _chooseList = [[YJNChooseList alloc] init];
        _chooseList.delegate = self;
        _chooseList.dataSource = self;
        _chooseList.maxRowNum = 5;
        _chooseList.title = @"请选择医生姓名";
    }
    return _chooseList;
}
-(NSInteger)numberOfRowsInChooseList:(YJNChooseList *)list {
    return self.dataArr.count;
}

-(YJNChooseItem *)chooseList:(YJNChooseList *)list itemForRow:(NSInteger)row {
    YJNChooseItem *item = self.dataArr[row];
    return item;
}

-(void)chooseList:(YJNChooseList *)list didSelectedRow:(NSInteger)row {
    YJNChooseItem *item = self.dataArr[row];
    NSLog(@"当前选中的是:%@,id=%@",item.title,item.ID);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
