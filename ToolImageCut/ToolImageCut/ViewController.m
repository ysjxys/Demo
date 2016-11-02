//
//  ViewController.m
//  ToolImageCut
//
//  Created by ysj on 16/10/18.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    
    UIImage *img = [UIImage imageNamed:@"xs"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = img;
    [self.view addSubview:imgView];
    
    [self cutImage:img imgHeadName:@"xs" level:4 widthNum:24 heightNum:32];
    
    NSLog(@"cut over");
}

- (void)cutImage:(UIImage *)img imgHeadName:(NSString *)headName level:(unsigned int)level widthNum:(unsigned int)widthNum heightNum:(unsigned int)heightNum{
    if (widthNum < 1 || heightNum < 1) {
        return;
    }
    // NO透明
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    
    CGFloat widthDegree = img.size.width/widthNum;
    CGFloat heightDegree = img.size.height/heightNum;
    CGImageRef imgRef = img.CGImage;
    
    for (int i = 0; i < widthNum; i++) {
        for (int j = 0; j < heightNum; j++) {
            CGRect rect = CGRectMake(i*widthDegree, j*heightDegree, widthDegree, heightDegree);
            CGImageRef subImgRef = CGImageCreateWithImageInRect(imgRef, rect);
            
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            
            CGContextDrawImage(ctx, rect, subImgRef);
            
            UIImage *image = [UIImage imageWithCGImage:subImgRef];
            
            //图片保存
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%d-%d,%d.jpg",headName,level,i,j]];
            [data writeToFile:path atomically:YES];
        }
    }
    UIGraphicsEndImageContext();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
