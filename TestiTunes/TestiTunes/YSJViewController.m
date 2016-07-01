//
//  ViewController.m
//  TestiTunes
//
//  Created by ysj on 16/1/21.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "YSJViewController.h"

@interface YSJViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *fileNameArr;
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@property (nonatomic, strong) QLPreviewController *qlPreviewController;
@end

@implementation YSJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self saveData];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:documentPath error:&error];
    
    self.fileNameArr = [NSMutableArray array];
    for (NSString *fileName in fileList) {
        [self.fileNameArr addObject:fileName];
    }
    
    [self.tableView reloadData];
}

- (void)setDocumentInteractionControllerWithURL:(NSURL *)url{
    if (!self.docInteractionController) {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }else{
        self.docInteractionController.URL = url;
    }
}

#pragma mark - UIDocumentInteractionController delegate
//- (NSString *)applicationDocumentsDirectory
//{
//    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//}
//
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}

#pragma mark - QLPreviewController delegate & datasource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *pathStrArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathStr = [pathStrArr objectAtIndex:0];
    NSString *filePath = [pathStr stringByAppendingPathComponent:self.fileNameArr[indexPath.row]];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    return url;
}

#pragma mark - UITableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fileNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:self.fileNameArr[indexPath.row]];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [self setDocumentInteractionControllerWithURL:fileURL];
    
    if (self.docInteractionController.icons.count > 0) {
        cell.imageView.image = self.docInteractionController.icons[0];
    }
    cell.textLabel.text = self.fileNameArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.qlPreviewController.currentPreviewItemIndex = indexPath.row;
    [self.navigationController pushViewController:self.qlPreviewController animated:YES];
    
//    QLPreviewController *previewController = [[QLPreviewController alloc]init];
//    previewController.delegate = self;
//    previewController.dataSource = self;
//    previewController.currentPreviewItemIndex = indexPath.row;
//    [self.navigationController pushViewController:previewController animated:YES];
    
//    [self checkFileType:self.fileNameArr[indexPath.row]];
    [self checkFileType2:self.fileNameArr[indexPath.row]];
    
}

- (void)checkFileType2:(NSString *)fileName{
    if (![fileName containsString:@"."]) {
        NSLog(@"未知类型");
        return;
    }
    fileName = [fileName stringByAppendingString:@"."];
    NSRange markRange = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    if (fileName.length <= markRange.location+1) {
        NSLog(@"后缀名不明");
    }
    NSString *fileType = [fileName substringFromIndex:markRange.location+1];
    NSLog(@"%@",fileType);
}

- (void)checkFileType:(NSString *)filePath{
    NSArray *tempArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = tempArr[0];
    NSString *fullPath = [documentPath stringByAppendingPathComponent:filePath];
    
    NSData *data = [NSData dataWithContentsOfFile:fullPath];
    if (data.length < 2) {
        NSLog(@"文件路径不存在");
        return;
    }
    int char1 = 0;
    int char2 = 0;
    [data getBytes:&char1 range:NSMakeRange(0, 1)];
    [data getBytes:&char2 range:NSMakeRange(1, 1)];
    NSLog(@"%d %d",char1,char2);
}



- (void)initView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.qlPreviewController = [[QLPreviewController alloc]init];
    self.qlPreviewController.delegate = self;
    self.qlPreviewController.dataSource = self;
}

- (void)saveData{
    UIImage *img = [UIImage imageNamed:@"play_share_icon4"];
    NSData *imgData = UIImageJPEGRepresentation(img, 0.8);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"friend.png"];
    [imgData writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
