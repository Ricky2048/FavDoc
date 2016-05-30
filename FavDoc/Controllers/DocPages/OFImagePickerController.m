//
//  OFImagePickerController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFImagePickerController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    OFMediaTypeImage,
    OFMediaTypeMoive
} OFMediaType;


@interface OFImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    __weak IBOutlet UIImageView *_photoImageView;

    __weak IBOutlet UILabel *_detailLabel;
    
    __weak IBOutlet UISlider *_sliderView;
    
    __weak IBOutlet UISlider *_sizeSliderView;
    
    // 图像输出
    UIImage *_photo;
    NSData *_photoData;
    
    OFMediaType _mediaType;
    
    // 视频输出
    AVAssetExportSession *_exportSession;
}
@end

@implementation OFImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma nark - Actions

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)saveAction:(id)sender {
    
    
    NSString *name = [Utils dateToString:[NSDate date]];
    NSString *path = [_folderPath stringByAppendingPathComponent:name];
    NSString *fullPath = [OFDocHelper fullPath:path];
    
    if (_mediaType == OFMediaTypeImage) {
        if (_photoData == nil) {
            return;
        }
        
        fullPath = [fullPath stringByAppendingPathExtension:@"jpg"];
        
        BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:fullPath contents:_photoData attributes:nil];
        
        if (isOk == NO) {
            NSLog(@"save image error!");
            return;
        }
        [self backAction:nil];

    }else {

        if (_exportSession == nil) {
            return;
        }
        
        fullPath = [fullPath stringByAppendingPathExtension:@"mp4"];

        _exportSession.outputURL = [NSURL fileURLWithPath:fullPath];
        _exportSession.shouldOptimizeForNetworkUse = YES;
        _exportSession.outputFileType = AVFileTypeMPEG4;
        [_exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([_exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    NSLog(@"压缩转换错误");
                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"压缩转换取消");
                    
                    break;
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"压缩转换成功");
                    [self backAction:nil];

                    break;
                default:
                    break;
            }
            
        }];
    
    }
    
    
}

- (IBAction)takePhotoAction:(id)sender {
    
    [self takePhoto];
}

- (IBAction)SelectAlbumAction:(id)sender {
    
    [self selectPhoto];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    [self changePhotoSize];

}

#pragma mark - Functions



- (void)changePhotoSize
{
    CGFloat scale = _sliderView.value;
    CGFloat sizeScale = _sizeSliderView.value;
    
    // 压缩尺寸
    UIImage *image = [Utils thumbnailWithImage:_photo size:CGSizeMake(_photo.size.width*sizeScale, _photo.size.height*sizeScale)];

    // 压缩质量
    _photoData = UIImageJPEGRepresentation(image, scale);
    image = [UIImage imageWithData:_photoData];
    
    [_photoImageView setImage:image];
    
    NSUInteger dataSize = _photoData.length;
    NSNumber *sizeNumber = [NSNumber numberWithUnsignedInteger:dataSize];
    NSString *sizeStr = [OFDocHelper getFileSizeStr:sizeNumber];
    _detailLabel.text = [NSString stringWithFormat:@"文件大小:%@ 压缩比:%.2f 尺寸:%.0fx%.0f",sizeStr,scale,image.size.width,image.size.height];
}

- (void)takePhoto
{
    //创建图片选择器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //指定源的类型
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        //picker.allowsEditing = YES;
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        picker.delegate = self;
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"Camera Can Not Use" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)selectPhoto
{
    //创建图片选择器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        //指定源的类型
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

        picker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
        
//        picker.cameraCaptureMode = UIImaxgePickerControllerCameraCaptureModeVideo;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        //picker.allowsEditing = YES;
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        picker.delegate = self;
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"Album Can Not Use" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma  mark UIImagePickerControllerDelegate

//用户点击图像选取器中的“cancel”按钮时被调用，这说明用户想要中止选取图像的操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//用户点击选取器中的“choose”按钮时被调用，告知委托对象，选取操作已经完成，同时将返回选取图片的实例
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        _sliderView.enabled = YES;
        _sizeSliderView.enabled = YES;
        _sliderView.value = 1.0;
        _sizeSliderView.value = 1.0;
        
        _photo = image;
        
        [self changePhotoSize];

    }];
}

// 设置后调用     picker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        NSLog([info description]);
        
        if([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            
            _mediaType = OFMediaTypeMoive;
            
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
//            NSLog(@"found a video url：%@",[videoURL absoluteString]);
            //获取视频的thumbnail
            MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoURL];
            UIImage  *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
            
            
            _sliderView.enabled = YES;
            _sizeSliderView.enabled = YES;
            
            _photoImageView.image = thumbnail;
            
            NSURL *url = info[UIImagePickerControllerMediaURL];
            AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
            _exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetLowQuality];
            
        }
        
        if([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            _mediaType = OFMediaTypeImage;

            UIImage *image = info[UIImagePickerControllerOriginalImage];
            _sliderView.enabled = YES;
            _sizeSliderView.enabled = YES;
            _sliderView.value = 1.0;
            _sizeSliderView.value = 1.0;
            
            _photo = image;
            
            [self changePhotoSize];

        }
    }];

}

@end
