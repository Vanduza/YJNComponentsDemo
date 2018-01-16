//
//  DateDescripController.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "DateDescripController.h"
#import "NSDate+YJNDateDescription.h"

@interface DateDescripController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation DateDescripController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)describeDate:(UIButton *)sender {
    if (_inputTextField.text) {
        NSNumber *number = [NSNumber numberWithInteger:[_inputTextField.text integerValue]];
        if (number) {
            NSTimeInterval timeInterval = number.doubleValue;
            _descLabel.text = [NSDate describeMessageTimeInterval:timeInterval];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
