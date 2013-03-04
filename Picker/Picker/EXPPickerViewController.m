//
//  EXPPickerViewController.m
//  Picker
//
//  Created by iwashita jiro on 13/01/22.
//  Copyright (c) 2013年 jiroiwas. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "EXPAVPlayerView.h"

#import "EXPPickerViewController.h"

@interface EXPPickerViewController ()

@end

@implementation EXPPickerViewController {
    UIImage *_pickedImage;
    
    AVPlayer *_moviePlayer;
    AVPlayerLayer *_movieLayer;
    NSURL *_movieURL;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCameraAction:(id)sender
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = YES;
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}

- (IBAction)openCamerarollAction:(id)sender
{

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:controller.sourceType];
        controller.allowsEditing = YES;
       
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

- (IBAction)saveImageAction:(id)sender {
    
    // アルバムに保存
    if (_pickedImage) {
        
        UIImageWriteToSavedPhotosAlbum(_pickedImage, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
        
    }
    
}


#pragma mark -
#pragma mark delegate method

// イメージ選択時
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
        
        if ([mediaType isEqualToString:@"public.image"]) {
            // イメージ取得
            _pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
            // 表示
            _pickedImageView.image = _pickedImage;
        }
        
        else if ([mediaType isEqualToString:@"public.movie"]) {
            
            // 選択された動画ファイルのURLを取得して、プロパティにセットする
            _movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            // 動画を再生するためにプレイヤーを作成する
            _moviePlayer = [AVPlayer playerWithURL:_movieURL];
            
            EXPAVPlayerView *avPlayerView = [[EXPAVPlayerView alloc] initWithFrame:self.view.bounds];
            
            AVPlayerLayer *playerLayer = (AVPlayerLayer *)avPlayerView.layer;
            playerLayer.player = _moviePlayer;
            
            [self.view addSubview:avPlayerView];
            [_moviePlayer play];
        }
        
    }];
    
}

// イメージ選択キャンセル時
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -
#pragma other method

- (void)targetImage: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
        contextInfo: (void *) contextInfo
{
    
    if (error) {
        // エラー
    } else {
        // 成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"カメラロールに保存しました" delegate:self cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    
}



@end
