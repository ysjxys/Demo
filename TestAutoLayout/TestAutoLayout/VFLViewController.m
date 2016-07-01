//
//  VFLViewController.m
//  TestAutoLayout
//
//  Created by ysj on 15/12/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "VFLViewController.h"

@interface VFLViewController ()

@end

@implementation VFLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple.jpg"]];
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
    NSArray *hConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imgView]-0-|" options:0 metrics:nil views:@{@"imgView":imgView}];
    [NSLayoutConstraint activateConstraints:hConstraintArray];
    
//    NSArray *vConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imgView]" options:0 metrics:nil views:@{@"imgView":imgView}];
//    [NSLayoutConstraint activateConstraints:vConstraintArray];
    
//    NSLayoutConstraint *hImgView = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0.0f];
//    hImgView.active = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    NSArray *hConstaintScrollArr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)];
    [NSLayoutConstraint activateConstraints:hConstaintScrollArr];
    
    NSArray *vConstraintScrollArr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imgView(==scrollView)][scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imgView,scrollView)];
    [NSLayoutConstraint activateConstraints:vConstraintScrollArr];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"苹果公司";
    [scrollView addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    contentLabel.numberOfLines = 0;
    [scrollView addSubview:contentLabel];
    contentLabel.text = @"苹果公司（Apple Inc. ）是美国的一家高科技公司。由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗·韦恩(Ron Wayne)等三人于1976年4月1日创立，并命名为美国苹果电脑公司（Apple Computer Inc. ）， 2007年1月9日更名为苹果公司，总部位于加利福尼亚州的库比蒂诺。\n苹果公司创立之初主要开发和销售的个人电脑，截至2014年致力于设计、开发和销售消费电子、计算机软件、在线服务和个人计算机。苹果的Apple II于1970年代助长了个人电脑革命，其后的Macintosh接力于1980年代持续发展。该公司硬件产品主要是Mac电脑系列、iPod媒体播放器、iPhone智能手机和iPad平板电脑；在线服务包括iCloud、iTunes Store和App Store；消费软件包括OS X和iOS操作系统、iTunes多媒体浏览器、Safari网络浏览器，还有iLife和iWork创意和生产力套件。苹果公司在高科技企业中以创新而闻名世界。\n苹果公司1980年12月12日公开招股上市，2012年创下6235亿美元的市值记录，截至2014年6月，苹果公司已经连续三年成为全球市值最大公司。苹果公司在2014年世界500强排行榜中排名第15名。2013年9月30日，在宏盟集团的“全球最佳品牌”报告中，苹果公司超过可口可乐成为世界最有价值品牌。2014年，苹果品牌超越谷歌（Google），成为世界最具价值品牌 。";
    
    NSArray *hConstaintTitleLabel = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel(==imgView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel,imgView)];
    [NSLayoutConstraint activateConstraints:hConstaintTitleLabel];
    
    NSArray *hConstraintContentLabel = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentLabel(==imgView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentLabel,imgView)];
    [NSLayoutConstraint activateConstraints:hConstraintContentLabel];
    
    NSArray *vConstraintLabel = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel(20)][contentLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel,contentLabel)];
    [NSLayoutConstraint activateConstraints:vConstraintLabel];
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
