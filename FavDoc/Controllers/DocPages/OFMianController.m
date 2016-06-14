//
//  OFMianController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFMianController.h"

#import "OFCatalogView.h"
#import "OFFileCell.h"
#import "OFFolderCell.h"
#import "OFSelectOperationView.h"

#import "OFImagePickerController.h"
#import "OFImagePreviewController.h"
#import "OFVideoPreviewController.h"

@interface OFMianController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_topBgView;
    
    __weak IBOutlet OFCatalogView *_catalogView;
    
    __weak IBOutlet UIButton *_leftButton;
    
    __weak IBOutlet UIButton *_rightButton;
    
}

@property (nonatomic, strong) NSDictionary *fileDic;

@property (nonatomic, strong) OFSelectOperationView *maskView;


@end

@implementation OFMianController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _topBgView.backgroundColor = kColorNavBg;
    _catalogView.backgroundColor = kColorNavBg;
    _tableView.separatorColor = kColorAllStyle;
    
    self.tabBarController.title = @"";

    _leftButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:24];
    [_leftButton setTitle:@"\U0000e628" forState:UIControlStateNormal];
    
    _rightButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:24];
    [_rightButton setTitle:@"\U0000e632" forState:UIControlStateNormal];

    _fileDic = @{keyPath:@"/",keyFolder:@[],keyFile:@[]};

    __weak __typeof__(self) weakSelf = self;
    
    [_catalogView addSelectBlock:^(NSString *dir) {
        
        [weakSelf setPath:dir];
    }];
    
    _maskView = [[OFSelectOperationView alloc] initWithFrame:self.view.bounds point:CGPointMake(self.view.frame.size.width-widthOfView, 64)];
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    
    [_maskView addSelectBlock:^(OFSelectOperation operation) {
        
        weakSelf.maskView.hidden = YES;
        
        switch (operation) {
            case OFSelectOperationCreateFolder:
            {
                NSString *path = weakSelf.fileDic[keyPath];
                path = [path stringByAppendingPathComponent:[Utils dateToString:[NSDate date]]];
                
                [[OFDocHelper shareInstance] createDirectoryAtPath:path];
                
                [weakSelf updateData];
                
            }
                break;
            case OFSelectOperationAddPhoto:
            {
                OFImagePickerController *vc = [[OFImagePickerController alloc] initWithNibName:@"OFImagePickerController" bundle:nil];
                vc.folderPath = weakSelf.fileDic[keyPath];
                [weakSelf presentViewController:vc animated:YES completion:^{
                    
                }];
            }
                break;
            case OFSelectOperationClearFolder:
            {
                
            }
                break;
            case OFSelectOperationMoveFolder:
            {
                
            }
                break;
            default:
                break;
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self updateData];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];

    _maskView.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    
    NSString *path = _fileDic[keyPath];
    NSString *newPath = [path stringByDeletingLastPathComponent];
    
    [self setPath:newPath];
    
}

- (IBAction)opertionAction:(id)sender {
    
    _maskView.hidden = !_maskView.hidden;
    
}

#pragma mark - Functions


- (void)setPath:(NSString *)path
{
    _fileDic = [[OFDocHelper shareInstance] getFilesFromPath:path];
//    NSLog([_fileDic description]);
    
    if (_fileDic != nil) {
        
        [_catalogView setPath:_fileDic[keyPath]];
        
        [_tableView reloadData];
        
        if ([_fileDic[keyPath] isEqualToString:@"/"]) {
            _leftButton.enabled = NO;
        }else {
            _leftButton.enabled = YES;
        }
        
    }}

- (void)updateData
{
    [self setPath:_fileDic[keyPath]];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        NSArray *arr = _fileDic[keyFolder];
        return arr.count;
    }
    NSArray *arr = _fileDic[keyFile];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    return 64;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"  文件夹";
    }
    return @"  文件";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    [header.textLabel setTextColor:kColorAllStyle];
    
    header.contentView.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        OFFolderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"folderCell" forIndexPath:indexPath];
        
        NSArray *arr = _fileDic[keyFolder];
        NSString *name = arr[indexPath.row];
        [cell setPath:_fileDic[keyPath] name:name];

        return cell;
    }
    
    OFFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSArray *arr = _fileDic[keyFile];
    NSString *name = arr[indexPath.row];
    [cell setPath:_fileDic[keyPath] name:name];
    
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        NSArray *arr = _fileDic[keyFolder];
        NSString *path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[indexPath.row]];
        [self setPath:path];
        
        
        return;
    }

    NSArray *arr = _fileDic[keyFile];
    NSString *path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[indexPath.row]];
    NSString *ext = [path pathExtension];
    
    if ([ext.uppercaseString isEqualToString:@"JPG"] || [ext.uppercaseString isEqualToString:@"PNG"]) {
        
        OFImagePreviewController *vc = [[OFImagePreviewController alloc] initWithNibName:@"OFImagePreviewController" bundle:nil];
        vc.filePath = path;
        [self presentViewController:vc animated:NO completion:^{
            
        }];
    }else if ([ext.uppercaseString isEqualToString:@"MP4"]) {
        OFVideoPreviewController *vc = [[OFVideoPreviewController alloc] initWithNibName:@"OFVideoPreviewController" bundle:nil];
        vc.filePath = path;
        [self presentViewController:vc animated:NO completion:^{
            
        }];
//        NSLog(@"mp4");
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    if (indexPath.section == 0 ) {
        NSArray *arr = _fileDic[keyFolder];
        NSString *path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[indexPath.row]];
        if ([path isEqualToString:@"/Videos"]||[path isEqualToString:@"/Pictures"]) {
            return NO;
        }
    }
    return YES;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *path;
        
        if (indexPath.section == 0) {
            NSArray *arr = _fileDic[keyFolder];
            path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[indexPath.row]];
        }
        if (indexPath.section == 1) {
            NSArray *arr = _fileDic[keyFile];
            path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[indexPath.row]];
        }
        if ([[OFDocHelper shareInstance] deleteItemAtPath:path]) {
            [self updateData];
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
 
@end
