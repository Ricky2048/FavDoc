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
    MPMoviePlayerController *_player;
    
}
@end

@implementation OFVideoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSURL *url = [[NSURL alloc] initWithString:[OFDocHelper fullPath:_filePath]];

    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"mp4"];
    
    MPMoviePlayerController *movewController =[[MPMoviePlayerController alloc] initWithContentURL:url];
    
    [movewController prepareToPlay];
    
    [self.view addSubview:movewController.view];//设置写在添加之后   // 这里是addSubView
    
    movewController.shouldAutoplay=YES;
    
    [movewController setControlStyle:MPMovieControlStyleDefault];
    
    [movewController setFullscreen:YES];
    
    [movewController.view setFrame:CGRectMake(100, 100, 200, 200)];
    
    [movewController play];
    
//    这里注册相关操作的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(movieFinishedCallback:)
     
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
     
                                               object:movewController]; //播放完后的通知
    

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
