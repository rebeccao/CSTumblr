//
//  CSViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSViewController.h"
#import "CSTumblrPost.h"
#import "CSTumblrCollectionViewCell.h"
#import "UIColor+CSColor.h"
#import "UITextView+CShtml.h"

@interface CSViewController ()

@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *CellIdentifier  = @"CellIdentifier";

@implementation CSViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoCouchsurfing.png"]];
    
    self.collectionView.backgroundColor = [UIColor backgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    CSTumblrManager *tumblrManager = [[CSTumblrManager alloc] init];
    tumblrManager.delegate = self;
    
    [tumblrManager fetchTumblrData];
}

- (void)didReceiveTumblrPosts:(NSArray *)tumblrPosts  error:(NSError *)error
{
    if (!error && tumblrPosts.count > 0) {
        self.posts = tumblrPosts;
        [self.collectionView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_posts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTumblrCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                           forIndexPath:indexPath];
    CSTumblrPost *post = [self.posts objectAtIndex:indexPath.row];

    cell.textView.backgroundColor = [UIColor backgroundColor];
    
    [cell.textView setScrollEnabled:YES];
    cell.textView.attributedText = [[NSAttributedString alloc] initWithData:[post.caption dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                         documentAttributes:nil
                                                                      error:nil];
    [cell.textView sizeToFit];
    [cell.textView setScrollEnabled:NO];

    NSLog(@"%d cell.textView size = %@", indexPath.row,  NSStringFromCGSize(cell.textView.bounds.size));
    cell.activityIndicator.hidesWhenStopped = YES;
    [cell.activityIndicator startAnimating];
    
    cell.imageView.backgroundColor = [UIColor backgroundImageColor];
    
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:[NSURL URLWithString:post.imagePostURL]
                                                   completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       UIImage *image = [UIImage imageWithData:
                                                                         [NSData dataWithContentsOfURL:location]];
                                                       NSLog(@"%d image size = %@", indexPath.row,  NSStringFromCGSize(image.size));
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           cell.imageView.backgroundColor = [UIColor clearColor];
                                                           [cell.activityIndicator stopAnimating];
                                                           cell.imageView.image = image;
                                                           NSLog(@"%d cell.imageView size = %@", indexPath.row,  NSStringFromCGSize(cell.imageView.bounds.size));
                                                       });
                                                   }];
    [downloadPhotoTask resume];
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTumblrPost *post = [self.posts objectAtIndex:indexPath.row];
    
    UITextView *dummyTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 262, 233)];
    
    [dummyTextView setScrollEnabled:YES];
    dummyTextView.attributedText = [[NSAttributedString alloc] initWithData:[post.caption dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                         documentAttributes:nil
                                                                      error:nil];
    [dummyTextView sizeToFit];
    [dummyTextView setScrollEnabled:NO];
    
    NSLog(@"%d - sizeForItemAtIndexPath dummyTextView size = %@", indexPath.row, NSStringFromCGSize(dummyTextView.bounds.size));
    NSLog(@"     sizeForItemAtIndexPath image size = %@", NSStringFromCGSize(CGSizeMake(post.imageWidth, post.imageHeight)));
    CGSize retval = CGSizeMake(280.0, dummyTextView.bounds.size.height + 195.0);
    NSLog(@"     sizeForItemAtIndexPath total size = %@\n\n", NSStringFromCGSize(retval));
                                                                                
    return retval;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
