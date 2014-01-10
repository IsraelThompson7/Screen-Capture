//
//  ViewController.m
//  demo
//
//  Created by 5danyuan.com on 11-12-1.
//  Copyright (c) 2011年 5单元. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController
@synthesize lblTip;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setLblTip:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [lblTip setText:@""];
    [super viewWillAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [lblTip release];
    [super dealloc];
}

- (IBAction)btnOK_Click:(id)sender {
    lblTip.numberOfLines=0;
    [lblTip setText:@"这是为 iPhone 写的第一个界面。"];
    
    UIAlertView  *alert=[[[UIAlertView alloc] initWithTitle:@"\n致谢～" message:@"谢谢 olay 义无反顾地支持，并提供了macbook pro、iphone。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ]autorelease];
    
    [alert show];
    
    NSLog(@"开始");
    [self save];
}

- (void)save{
    UIImage *image = [self getNormalImage:self.view];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    NSLog(@"结束");
}

//获取当前屏幕内容
- (UIImage *)getNormalImage:(UIView *)view{
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)saveToDisk:(UIImage *)image{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSLog(@"保存路径：%@",dir);
    
    NSString *path = [NSString stringWithFormat:@"%@/pic_%f.png",dir,[NSDate timeIntervalSinceReferenceDate]];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data writeToFile:path atomically:YES];
    
    NSLog(@"保存完毕");
}
@end
