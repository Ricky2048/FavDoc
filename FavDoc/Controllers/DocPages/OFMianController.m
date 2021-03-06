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
    
    NSIndexPath *_currentIndex;
    
}

@property (nonatomic, strong) NSDictionary *fileDic;

@property (nonatomic, strong) OFSelectOperationView *maskView;


@end

@implementation OFMianController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _leftButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:24];
    [_leftButton setTitle:@"\U0000e628" forState:UIControlStateNormal];
    
    _rightButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:24];
    [_rightButton setTitle:@"\U0000e632" forState:UIControlStateNormal];

    _fileDic = @{keyPath:@"/",keyFolder:@[],keyFile:@[]};

    __weak __typeof__(self) weakSelf = self;
    
    [_catalogView addSelectBlock:^(NSString *dir) {
        
        [weakSelf setPath:dir];
    }];
    
    _maskView = [[OFSelectOperationView alloc] initWithFrame:self.view.bounds point:CGPointMake(self.view.width-widthOfView, 64)];
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    
    
    
    [_maskView addSelectBlock:^(NSString *selectOption) {
        
        weakSelf.maskView.hidden = YES;
        
        if ([selectOption isEqualToString:SelectOptionNewFolder]) {
            NSString *path = weakSelf.fileDic[keyPath];
            path = [path stringByAppendingPathComponent:[Utils dateToString:[NSDate date]]];
            
            [[OFDocHelper shareInstance] createDirectoryAtPath:path];
            
            [weakSelf updateData];
        }
      
        if ([selectOption isEqualToString:SelectOptionFromAblum]) {

            
        }
       
        if ([selectOption isEqualToString:SelectOptionUSerCamera]) {
            
            OFImagePickerController *vc = [[OFImagePickerController alloc] initWithNibName:@"OFImagePickerController" bundle:nil];
            vc.folderPath = weakSelf.fileDic[keyPath];
            [weakSelf presentViewController:vc animated:YES completion:^{
                
            }];
        }
        
        if ([selectOption isEqualToString:SelectOptionNewText]) {
    
            
        }
        
        if ([selectOption isEqualToString:SelectOptionNewRecord]) {
            
        }
        
        if ([selectOption isEqualToString:SelectOptionPlaste]) {
            
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
    
    self.tabBarController.title = @"文件夹";
    
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

- (void)updateCloth
{
    _topBgView.backgroundColor = kColorNavBg;
    _catalogView.backgroundColor = kColorNavBg;
    _tableView.separatorColor = kColorLine;
    [_catalogView updateCloth];
    [_maskView updateCloth];
    
    
//    [_tableView reloadData];
}

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
        cell.indexPath = indexPath;

        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:recognizer];
        
        return cell;
    }
    
    OFFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSArray *arr = _fileDic[keyFile];
    NSString *name = arr[indexPath.row];
    [cell setPath:_fileDic[keyPath] name:name];
    cell.indexPath = indexPath;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:recognizer];
    
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
        [self.tabBarController.navigationController pushViewController:vc animated:YES];

    }else if ([ext.uppercaseString isEqualToString:@"MP4"]) {
        OFVideoPreviewController *vc = [[OFVideoPreviewController alloc] initWithNibName:@"OFVideoPreviewController" bundle:nil];
        vc.filePath = path;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
    
}



//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
        

//
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

#pragma mark - UIMenuController

- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        OFBaseCell *cell = (OFBaseCell *)recognizer.view;
        
        _currentIndex = cell.indexPath;
        
        [cell becomeFirstResponder];
        
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制"action:@selector(myCopy:)];
        
        UIMenuItem *cut = [[UIMenuItem alloc] initWithTitle:@"剪切"action:@selector(myCut:)];

        UIMenuItem *rename = [[UIMenuItem alloc] initWithTitle:@"重命名"action:@selector(myRename:)];
        
        UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除"action:@selector(myDelete:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copy, cut, rename, delete, nil]];
        
        [menu setTargetRect:cell.frame inView:cell.superview];
        
        [menu setMenuVisible:YES animated:YES];
        
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(myCopy:)) {
        return YES;
    }
    if (action == @selector(myCut:)) {
        return YES;
    }
    if (action == @selector(myRename:)) {
        return YES;
    }
    if (action == @selector(myDelete:)) {
        return YES;
    }
    return NO;
}

- (void)myCopy:(id)sender
{

    
    
}

- (void)myCut:(id)sender
{
    if (![self canEditCurrentIndex]) {
        return;
    }

    
}

- (void)myRename:(id)sender
{
    if (![self canEditCurrentIndex]) {
        return;
    }
    
}

- (void)myDelete:(id)sender
{
    if (![self canEditCurrentIndex]) {
        return;
    }

    NSString *path;
    
    if (_currentIndex.section == 0) {
        NSArray *arr = _fileDic[keyFolder];
        path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[_currentIndex.row]];
    }
    if (_currentIndex.section == 1) {
        NSArray *arr = _fileDic[keyFile];
        path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[_currentIndex.row]];
    }
    if ([[OFDocHelper shareInstance] deleteItemAtPath:path]) {
        [self updateData];
    }
}

- (BOOL)canEditCurrentIndex
{
    if (_currentIndex.section == 0 ) {
        NSArray *arr = _fileDic[keyFolder];
        NSString *path = [_fileDic[keyPath] stringByAppendingPathComponent:arr[_currentIndex.row]];
        if ([path isEqualToString:defaultFloder1]||[path isEqualToString:defaultFloder2]) {
            return NO;
        }
    }
    
    return YES;
}

@end
