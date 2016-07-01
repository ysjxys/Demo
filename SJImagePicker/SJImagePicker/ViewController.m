//
//  ViewController.m
//  SJImagePicker
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imgPC;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"hh" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(photoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *loadImg = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadImg setTitle:@"load" forState:UIControlStateNormal];
    loadImg.frame = CGRectMake(100, 400, 100, 100);
    [loadImg addTarget:self action:@selector(loadImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadImg];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img"]];
    imgView.backgroundColor = [UIColor grayColor];
    imgView.frame = CGRectMake(100, 250, 100, 100);
    [self.view addSubview:imgView];
    self.imgView = imgView;
}

- (void)loadImg{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"img.png"];
    
    UIImage *img = [UIImage imageWithContentsOfFile:fullPath];
    self.imgView.image = img;
}

- (void)photoLibrary{
    UIImagePickerController *imgPC = [[UIImagePickerController alloc]init];
    imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPC.delegate = self;
    self.imgPC = imgPC;
//    imgPC.allowsEditing = YES;
    [self presentViewController:imgPC animated:YES completion:^{
        BOOL isPhotoLibrarySupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        NSLog(@"%d",isPhotoLibrarySupport);
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    //save to document
    NSData *imageData = UIImagePNGRepresentation(img);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"img.png"];
    [imageData writeToFile:fullPath atomically:NO];
    
    [self.imgPC dismissViewControllerAnimated:YES completion:^{
        self.imgView.image = [UIImage imageNamed:@"img.png"];//useless
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
