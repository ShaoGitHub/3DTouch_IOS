# 3DTouch_IOS
对集成3DTouch的简单讲解

@(3-DTouch_IOS)[3DTouch|IOS|iphone6s]

> 自动iPhone6s推出以后，其最大的亮点无疑就是最新携带的3DTouch功能。这项技术不仅给各个应用增加更多方便快捷的入口，其产品本身的交互体验也是超级酷炫，而且最重要的，苹果不仅推出该功能，还开放其API的调用接口，这对广大iOS开发者来说真是福音啊，不像之前iPhone5s推出的指纹解锁功能，要隔段好久才开放API接口，可见苹果对这项新功能的推广之心之迫切。闲话少说，本文就iOS开发中如何集成3DTouch做下简单的讲解。

开发环境及调试设备：
Xcode7或以上，iOS9或以上，iPhone6s或以上

3DTouch功能主要分为两大块：主屏幕Icon上的快捷标签（Home Screen Quick Actions）； Peek（预览）和Pop（跳至预览的详细界面）

## Home Screen Quick Actions的实现</br>
### 主屏幕icon上的快捷标签的实现方式有两种，一种是在工程文件info.plist里静态设置，另一种是代码的动态实现.
-------------
#### 静态设置</br>
静态设置方式如下图所示：
![demo1](/resouse/demo.png)

下面是各个标签类型的说明，plist文件里还没提供UIApplicationShortcutItems选项，没办法，只能手动敲了，或者直接复制粘贴过去。
UIApplicationShortcutItems：数组中的元素就是我们的那些快捷选项标签。
UIApplicationShortcutItemTitle：标签标题（必填）
UIApplicationShortcutItemType：标签的唯一标识 （必填）
UIApplicationShortcutItemIconType：使用系统图标的类型，如搜索、定位、home等（可选）
UIApplicationShortcutItemIcon File：使用项目中的图片作为标签图标 （可选）
UIApplicationShortcutItemSubtitle：标签副标题 （可选）
UIApplicationShortcutItemUserInfo：字典信息，如传值使用 （可选）

--------------

#### 动态实现
动态设置方式如下所示：</br>

    //动态创建应用图标上的3D touch快捷选项
    - (void)creatShortcutItem
    {
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.test.shequ" localizedTitle:@"社区" localizedSubtitle:@"开启心声,展望全新世界" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:@{}];
        
        [UIApplication sharedApplication].shortcutItems = @[item1];
    }

到此，主屏幕icon上的快捷标签创建就介绍完了，而他们点击进入页面的实现就有点类似消息通知的实现方式了，只要增加两处代码就好：首次启动APP和APP没被杀死从后台启动。

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // Override point for customization after application launch.
        
        ViewController *vc = [[ViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
        
        //动态创建应用图标上的3D touch快捷选项
        [self creatShortcutItem];
        UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        if (shortcutItem) {
            //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
            if([shortcutItem.type isEqualToString:@"com.test.shengyou"]){
                NSLog(@"新启动APP-- 声优界面");
                HallViewController *sayuView = [[HallViewController alloc] init];
                [[self topViewController].navigationController pushViewController:sayuView animated:YES];
            } else if ([shortcutItem.type isEqualToString:@"com.test.shequ"]) {
                //进入搜索界面
                NSLog(@"新启动APP-- 社区界面");
            }
            return NO;
        }
        
        return YES;
    }
    
    - (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler
    {
        NSLog(@"%@",shortcutItem.userInfo);
        if (shortcutItem) {
            //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
            if([shortcutItem.type isEqualToString:@"com.xys.shengyou"]){
                NSLog(@"新启动APP-- 声优界面");
                HallViewController *sayuView = [[HallViewController alloc] init];
                [[self topViewController].navigationController pushViewController:sayuView animated:YES];
            } else if ([shortcutItem.type isEqualToString:@"com.xys.shequ"]) {
                //进入搜索界面
                NSLog(@"新启动APP-- 社区界面");
            }
        }
        
        if (completionHandler) {
            completionHandler(YES);
        }
    }

----------------

## Peek和Pop的实现-四部曲
* 注册(在哪个页面上使用该功能就注册在哪个页面上)



        [self registerForPreviewingWithDelegate:self sourceView:self.view];



* 继承协议UIViewControllerPreviewingDelegate

        @interface HallViewController ()<UIViewControllerPreviewingDelegate>

* 实现UIViewControllerPreviewingDelegate方法

        //peek(预览)
       - (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
       {
           //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
           //NSIndexPath *indexPath = [_myTableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];

          //设定预览的界面
          MyPreviewingViewController *childVC = [[MyPreviewingViewController alloc] init];
          childVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
          childVC.myStr = [NSString stringWithFormat:@"我是%@,用力按一下进来-------",@"白纸上涂鸦"];

          //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
          //CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,40);
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


* 当弹出预览时，上滑预览视图，出现预览视图中快捷选项

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


__到此，3DTouch在APP中的集成就先介绍这些，3DTouch中还有个重要的属性--压力属性（force 和 maximumPossibleForce）这里就不详细介绍了，感兴趣的同学可以去看下官方文档，网上也很多相关资料。以上有说的不对的地方，还望高手指正，相互学习，共同进步.__

我的简书地址:[http://www.jianshu.com/u/e0c475eb47e9](http://www.jianshu.com/u/e0c475eb47e9)</br>
# 喜欢的记得star一下哦!!!
