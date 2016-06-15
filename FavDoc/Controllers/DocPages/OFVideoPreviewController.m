//
//  OFVideoPreviewController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/30.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFVideoPreviewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface OFVideoPreviewController ()
{
    
    __weak IBOutlet UIView *_topBgView;

    __weak IBOutlet UIView *_playerView;
    
    __weak IBOutlet UIToolbar *_toolBar;
    
    MPMoviePlayerController *_player;
}
@end

@implementation OFVideoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"视频预览";
    
    [OFDocHelper addToHistory:_filePath];
    
    NSString *fullPath = [OFDocHelper fullPath:_filePath];
    NSURL *url = [NSURL fileURLWithPath:fullPath];
  
    _player =[[MPMoviePlayerController alloc] initWithContentURL:url];
    [_player prepareToPlay];
    _player.shouldAutoplay=YES;
    [_player setControlStyle:MPMovieControlStyleDefault];
    [_player play];

    // 注册相关操作的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_player]; //播放完后的通知
    
    [_playerView addSubview:_player.view];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    UIView *view1 = [[UIView alloc] init];
////    view1.frame = CGRectMake(0, 0, 200, 200);
//    view1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view1];
//    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)];
//    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)];
//    
//    [self.view addConstraints:constraints1];
//    [self.view addConstraints:constraints2];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_player pause];
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    

    _player = nil;
    
}

- (void)viewDidLayoutSubviews
{
    _player.view.frame = _playerView.bounds;

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

#pragma mark - Functions


- (void)updateCloth
{
    _topBgView.backgroundColor = kColorNavBg;
    _toolBar.tintColor = [UIColor whiteColor];

}

- (void)movieFinishedCallback:(id)sender
{
    NSLog(@"paly back");
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
