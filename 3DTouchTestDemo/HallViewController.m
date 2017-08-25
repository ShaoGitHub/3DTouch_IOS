//
//  SayUViewController.m
//  3DTouchTestDemo
//
//  Created by 杭州任性贸易有限公司 on 2017/8/25.
//  Copyright © 2017年 杭州任性贸易有限公司. All rights reserved.
//
//  github:https://github.com/ShaoGitHub/3-DTouch_IOS

#import "HallViewController.h"
#import "MyPreviewingViewController.h"

@interface HallViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation HallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"大厅首页";
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
//    NSIndexPath *indexPath = [_myTableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    //设定预览的界面
    MyPreviewingViewController *childVC = [[MyPreviewingViewController alloc] init];
    childVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
    childVC.myStr = [NSString stringWithFormat:@"我是%@,用力按一下进来-------",@"白纸上涂鸦"];
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
//    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,40);
    CGRect rect = self.view.frame;
    previewingContext.sourceRect = rect;
    //返回预览界面
    return childVC;
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    //    [self.view addSubview:viewControllerToCommit.view];
    [self showViewController:viewControllerToCommit sender:self];
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
