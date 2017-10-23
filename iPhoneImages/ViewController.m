//
//  ViewController.m
//  iPhoneImages
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic, strong, readwrite) NSMutableArray *imageURLs;

@end

@implementation ViewController
- (IBAction)randomizeImagePressed:(id)sender {
    [self downloadImage:self.imageURLs[arc4random_uniform(5)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imageURLs = @[@"http://imgur.com/bktnImE.png", @"http://imgur.com/zdwdenZ.png", @"http://imgur.com/CoQ8aNl.png", @"http://imgur.com/2vQtZBb.png", @"http://imgur.com/y9MIaCS.png"];
    self.imageURLs = [[NSMutableArray alloc] initWithArray:imageURLs];
    [self downloadImage:self.imageURLs[arc4random_uniform(5)]];
    
}

-(void)downloadImage:(NSString *)imageURL {
    NSURL *url = [NSURL URLWithString:imageURL]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
