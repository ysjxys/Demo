//
//  ViewController.m
//  TestPhotoResource
//
//  Created by ysj on 16/3/21.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 50, 120, 40);
    [btn1 setTitle:@"imagePicker" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(imagePickerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(80, 150, 160, 40);
    [btn2 setTitle:@"ALAssetsLibrary" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(assetsLibraryBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.view.backgroundColor = [UIColor orangeColor];
    imagePicker.delegate = self;
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum     照片相册
    //UIImagePickerControllerSourceTypePhotoLibrary     相册库
    //UIImagePickerControllerSourceTypeCamera       调用相机
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.allowsEditing = YES;
    self.imagePicker = imagePicker;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 230, 220, 250)];
    imgView.backgroundColor = [UIColor purpleColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView = imgView;
    [self.view addSubview:imgView];
}

- (void)assetsLibraryBtnClicked{
    
}

- (void)imagePickerBtnClicked{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imgView.image = img;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"cancel");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
