//
//  ViewController.m
//  3DTouchTestDemo
//
//  Created by 杭州任性贸易有限公司 on 2017/8/25.
//  Copyright © 2017年 杭州任性贸易有限公司. All rights reserved.
//
//  github:https://github.com/ShaoGitHub/3-DTouch_IOS

#import "ViewController.h"
#import "HallViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"APP首页";
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(btnTouchOn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnTouchOn:(UIButton *)btn
{
    HallViewController *sayuView = [[HallViewController alloc] init];
    [self.navigationController pushViewController:sayuView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
