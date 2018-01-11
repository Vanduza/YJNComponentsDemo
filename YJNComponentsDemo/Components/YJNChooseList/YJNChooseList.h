//
//  YJNChooseList.h
//  FunctionTestOC
//
//  Created by YangJing on 2018/1/10.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJNChooseList;
@class YJNChooseItem;

@protocol YJNChooseListDelegate <NSObject>
@optional
-(void)chooseList:(YJNChooseList *)list didSelectedRow:(NSInteger)row;
@end
@protocol YJNChooseListDataSource <NSObject>
@required
-(NSInteger)numberOfRowsInChooseList:(YJNChooseList *)list;
-(YJNChooseItem *)chooseList:(YJNChooseList *)list itemForRow:(NSInteger)row;
@end

@interface YJNChooseItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@end

@interface YJNChooseList : UIView

@property (nonatomic, assign) NSInteger maxRowNum;
@property (nonatomic, weak) id <YJNChooseListDelegate> delegate;
@property (nonatomic, weak) id <YJNChooseListDataSource> dataSource;

@property (nonatomic, copy) NSString *title;

@end
