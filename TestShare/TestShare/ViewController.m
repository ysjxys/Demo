//
//  ViewController.m
//  TestShare
//
//  Created by ysj on 15/12/8.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"

@interface ViewController ()<UMSocialUIDelegate>
@property (nonatomic, copy) NSString *UMAppKey;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.UMAppKey = @"5627252e67e58e4ca4000040";
    UIButton *defaultShare = [UIButton buttonWithType:UIButtonTypeSystem];
    [defaultShare setTitle:@"默认分享" forState:UIControlStateNormal];
    [defaultShare addTarget:self action:@selector(defaultShareBtnClcked) forControlEvents:UIControlEventTouchUpInside];
    defaultShare.frame = CGRectMake(50, 100, 150, 40);
    [self.view addSubview:defaultShare];
    
    UIButton *useAPIBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [useAPIBtn setTitle:@"使用API分享" forState:UIControlStateNormal];
    [useAPIBtn addTarget:self action:@selector(useAPIBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    useAPIBtn.frame = CGRectMake(50, 180, 150, 40);
    [self.view addSubview:useAPIBtn];
    
    UIButton *QQLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [QQLogin setTitle:@"qq第三方登录" forState:UIControlStateNormal];
    [QQLogin addTarget:self action:@selector(qqloginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    QQLogin.frame = CGRectMake(50, 260, 150, 40);
    [self.view addSubview:QQLogin];
    
    UIButton *wxLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [wxLogin setTitle:@"wx第三方登录" forState:UIControlStateNormal];
    [wxLogin addTarget:self action:@selector(wxloginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    wxLogin.frame = CGRectMake(50, 340, 150, 40);
    [self.view addSubview:wxLogin];
}

- (void)wxloginBtnClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        }
    });
}

- (void)qqloginBtnClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
        NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
    }});
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}

- (void)useAPIBtnClicked{
    [[UMSocialControllerService defaultControllerService] setShareText:@"这是内容文字" shareImage:[UIImage imageNamed:@"img80.png"] socialUIDelegate:self];
    [[UMSocialData defaultData] setTitle:@"这是标题"];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    
    UMSocialData *data = [[UMSocialData alloc]initWithIdentifier:@"identifier" withTitle:@"这是标题"];
    data.shareText = @"这是分享内容";
    data.title = @"这是标题";
    data.extConfig.wechatSessionData.title = @"title";
    data.shareImage = [UIImage imageNamed:@"img80.png"];
    UMSocialControllerService *service = [[UMSocialControllerService alloc]initWithUMSocialData:data];
    
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,service,YES);
}

- (void)defaultShareBtnClcked{
    //QQ空间title及点击跳转
    [UMSocialData defaultData].extConfig.qzoneData.title = @"这是title";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
    //微信好友title及点击跳转
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    //微信朋友圈title及点击跳转
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeNone;
    
    
//  tableView形式
//    [UMSocialSnsService presentSnsController:self
//                                      appKey:self.UMAppKey
//                                   shareText:@"这是分享文字"
//                                  shareImage:[UIImage imageNamed:@"img80.png"]
//                             shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,nil]
//                                    delegate:self];
    
//  collectionView形式
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:self.UMAppKey
                                      shareText:@"这是分享文字"
                                     shareImage:[UIImage imageNamed:@"img80.png"]
                                shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina]
                                       delegate:self];
}

//实现回调方法（可选）：
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
