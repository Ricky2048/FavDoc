//
//  OFImagePreviewController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFImagePreviewController.h"

#define MaxSize CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)


@interface OFImagePreviewController ()
{
    
    
    __weak IBOutlet NSLayoutConstraint *_cs_imageView_width;
    
    __weak IBOutlet NSLayoutConstraint *_cs_imageView_height;
    
    __weak IBOutlet UIImageView *_imageView;
    
    CGSize _imageSize; // 图片原有的大小
    CGSize _imageViewSize; // 控件原有大小
    
}
@end

@implementation OFImagePreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"图片预览";
    
    if (_filePath) {
        NSString *fullPath = [OFDocHelper fullPath:_filePath];
//        NSLog(fullPath);
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        if ([image isKindOfClass:[UIImage class]]) {
            _imageView.image = image;
            _imageSize = image.size;
        }
    }
    
    [self addGestureRecognizerToView:_imageView];
    
    [OFDocHelper addToHistory:_filePath];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    float scale = MaxSize.width/_imageSize.width;
    if (MaxSize.width/_imageSize.width > MaxSize.height/_imageSize.height) {
        scale = MaxSize.height/_imageSize.height;
    }
    
    _imageViewSize = CGSizeMake(_imageSize.width*scale, _imageSize.height*scale);

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    
    _cs_imageView_width.constant = _imageViewSize.width;
    _cs_imageView_height.constant = _imageViewSize.height;
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

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [view addGestureRecognizer:doubleTap];

    // 点击手势
    UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [tapGestureRecongnizer requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:tapGestureRecongnizer];
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理点击手势
- (void) tapView:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }else {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }
    }];
}

// 处理双击
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }

}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded || pinchGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGPoint center = _imageView.center;
            
            if (view.width / _imageViewSize.width > 5) {
                
                view.frame = CGRectMake(0, 0, _imageViewSize.width*5, _imageViewSize.height*5);
                view.center = center;
            }
            
            if (view.width / _imageViewSize.width < .5) {
                
                view.frame = CGRectMake(0, 0, _imageViewSize.width*.5, _imageViewSize.height*.5);
                view.center = center;
            }
        }];
    
    }

}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }

    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded || panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGPoint center = _imageView.center;
            
            if (center.x < 0) {
                center.x = 0;
            }
            if (center.x > MaxSize.width) {
                center.x = MaxSize.width;
            }
            if (center.y < 0) {
                center.y = 0;
            }
            if (center.y > MaxSize.height) {
                center.y = MaxSize.height;
            }
            _imageView.center = center;
        }];
        
    }
}

#pragma mark - Actions



@end
