//
//  ViewController.m
//  iPhoneImages
//
//  Created by Olga on 10/23/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = [NSURL URLWithString:@"http://imgur.com/2vQtZBb.png"]; // 1
    
    [self downloadImage];
    

    
}

- (IBAction)showNextIphone:(UIBarButtonItem *)sender {
    int randomPic = arc4random_uniform(5)+1;
    
    switch (randomPic) {
        case 1:
            self.url = [NSURL URLWithString:@"http://imgur.com/2vQtZBb.png"];
            NSLog(@"Case 1, url: %@", self.url);
            break;
        case 2:
            self.url = [NSURL URLWithString:@"http://imgur.com/bktnImE.png"];
            NSLog(@"Case 2, url: %@", self.url);
            break;
        case 3:
            self.url = [NSURL URLWithString:@"http://imgur.com/zdwdenZ.png"];
            NSLog(@"Case 3, url: %@", self.url);
            break;
        case 4:
            self.url = [NSURL URLWithString:@"http://imgur.com/CoQ8aNl.png"];
            NSLog(@"Case 4, url: %@", self.url);
            break;
        case 5:
            self.url = [NSURL URLWithString:@"http://imgur.com/y9MIaCS.png"];
            NSLog(@"Case 5, url: %@", self.url);
            break;
        default:
            break;
    }
    
    [self downloadImage];
    
}

-(void)downloadImage{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:self.url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            self.iPhoneImageView.image = image; // 4
            
        }];
        
        
    }]; // 4
    
    [downloadTask resume]; // 5
}



@end
