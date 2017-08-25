//
//  MyPreviewingViewController.m
//  3DTouchTestDemo
//
//  Created by 杭州任性贸易有限公司 on 2017/8/25.
//  Copyright © 2017年 杭州任性贸易有限公司. All rights reserved.
//
//  github:https://github.com/ShaoGitHub/3-DTouch_IOS

#import "MyPreviewingViewController.h"

@interface MyPreviewingViewController ()

@end

@implementation MyPreviewingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.bounds];
    lab.backgroundColor = [UIColor redColor];
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.text = _myStr;
    [self.view addSubview:lab];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你点了-删除" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [alert show];
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"置顶" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你点了-置顶" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [alert show];
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"啥也不干" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"真的啥也不干？" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [alert show];
    }];
    NSArray *actions = @[action1,action2,action3];
    
    // and return them (return the array of actions instead to see all items ungrouped)
    return actions;
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
