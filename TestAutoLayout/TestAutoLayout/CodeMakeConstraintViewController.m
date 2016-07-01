//
//  CodeMakeConstraintViewController.m
//  TestAutoLayout
//
//  Created by ysj on 15/12/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "CodeMakeConstraintViewController.h"

@interface CodeMakeConstraintViewController ()

@end

@implementation CodeMakeConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple.jpg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imgView];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.5f constant:0.0f];
    
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    bottomConstraint.active = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    NSLayoutConstraint *scrollLeftConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *scrollRightConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *scrollTopConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imgView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *scrollBottomConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    
    scrollLeftConstraint.active = YES;
    scrollRightConstraint.active = YES;
    scrollTopConstraint.active = YES;
    scrollBottomConstraint.active = YES;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [UIColor purpleColor];
    titleLabel.text = @"苹果公司";
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:titleLabel];
    
    NSLayoutConstraint *titleLabelLeading = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *titleLabelTailing = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *titleLabelTop = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *titleLabelHeight = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f];
    
    titleLabelHeight.active = YES;
    titleLabelLeading.active = YES;
    titleLabelTailing.active = YES;
    titleLabelTop.active = YES;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    contentLabel.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:contentLabel];
    contentLabel.text = @"苹果公司（Apple Inc. ）是美国的一家高科技公司。由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗·韦恩(Ron Wayne)等三人于1976年4月1日创立，并命名为美国苹果电脑公司（Apple Computer Inc. ）， 2007年1月9日更名为苹果公司，总部位于加利福尼亚州的库比蒂诺。\n苹果公司创立之初主要开发和销售的个人电脑，截至2014年致力于设计、开发和销售消费电子、计算机软件、在线服务和个人计算机。苹果的Apple II于1970年代助长了个人电脑革命，其后的Macintosh接力于1980年代持续发展。该公司硬件产品主要是Mac电脑系列、iPod媒体播放器、iPhone智能手机和iPad平板电脑；在线服务包括iCloud、iTunes Store和App Store；消费软件包括OS X和iOS操作系统、iTunes多媒体浏览器、Safari网络浏览器，还有iLife和iWork创意和生产力套件。苹果公司在高科技企业中以创新而闻名世界。\n苹果公司1980年12月12日公开招股上市，2012年创下6235亿美元的市值记录，截至2014年6月，苹果公司已经连续三年成为全球市值最大公司。苹果公司在2014年世界500强排行榜中排名第15名。2013年9月30日，在宏盟集团的“全球最佳品牌”报告中，苹果公司超过可口可乐成为世界最有价值品牌。2014年，苹果品牌超越谷歌（Google），成为世界最具价值品牌 。";
    
    NSLayoutConstraint *contentLabelLeading = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *contentLabelTailing = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *contentLabelTop = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *contentLabelBottom = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    
    contentLabelBottom.active = YES;
    contentLabelLeading.active = YES;
    contentLabelTailing.active = YES;
    contentLabelTop.active = YES;
    
    NSLayoutConstraint *titleLabelWidth = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imgView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *contentLabelWidth = [NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imgView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    
    titleLabelWidth.active = YES;
    contentLabelWidth.active = YES;
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
