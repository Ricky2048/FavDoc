//
//  OFImagePreviewController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFImagePreviewController.h"

@interface OFImagePreviewController ()
{
    
    __weak IBOutlet UIImageView *_imageView;
    
}
@end

@implementation OFImagePreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_filePath) {
        NSString *fullPath = [OFDocHelper fullPath:_filePath];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        if ([image isKindOfClass:[UIImage class]]) {
            _imageView.image = image;
        }
    }
    
    [self addGestureRecognizerToView:_imageView];
    
    [self addToHistory:_filePath];
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

- (void)addToHistory:(NSString *)path
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFDataHelper shareInstance] fetcthTable:kTableHistory predicate:predicate];
    
    OFHistoryEntity *entity = results.firstObject;

    if (entity == nil) {
        
        entity = [[OFDataHelper shareInstance] insertToTable:kTableHistory];
        entity.path = path;
        entity.name = [path lastPathComponent];
    }
    entity.last_open = [NSDate date];
}

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
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
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (IBAction)operateAction:(id)sender {
    
    NSArray *results = [[OFDataHelper shareInstance] fetcthTable:kTableHistory predicate:nil];

    NSLog([results description]);
    
    NSArray *results1 = [[OFDataHelper shareInstance] fetcthTable:kTableFav predicate:nil];
    
    NSLog([results1 description]);
}

@end
