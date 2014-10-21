//
//  CSTumblrManager.m
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/18/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSTumblrManager.h"
#import "CSTumblrPost.h"
#import "TMAPIClient.h"

@implementation CSTumblrManager

- (void)fetchTumblrData
{
    [[TMAPIClient sharedInstance] posts:@"couchsurfing" type:nil parameters:nil callback: ^(id result, NSError *error) {
        NSLog(@"Result returned from Tumblr API is: %@", result);
        
        if (error) {
            
        } else {
            
            NSError *error = nil;
            NSArray *posts = [self parseTumblrPosts:result];
            
            [self.delegate didReceiveTumblrPosts:posts error:error];
        }
    }];
}

- (NSArray *)parseTumblrPosts:(NSDictionary *)recievedData
{
    NSArray *receivedPosts = recievedData[@"posts"];
    NSLog(@"receivedPosts count = %d", receivedPosts.count);

    NSMutableArray *posts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *receivedPost in receivedPosts) {
        CSTumblrPost *post = [[CSTumblrPost alloc] init];
        post.caption = @"";
        post.imagePostURL = nil;
        post.imageHeight = 0.0;
        
        if (receivedPost[@"caption"] && [receivedPost[@"caption"] isKindOfClass:[NSString class]]) {
            post.caption = receivedPost[@"caption"];
        }
        if (receivedPost[@"photos"] && [receivedPost[@"photos"] isKindOfClass:[NSArray class]]) {
            NSArray *receivedPhotoInfo = receivedPost[@"photos"];
            
            if (receivedPhotoInfo.count > 0) {
                NSDictionary *receivedPhotoSizes = receivedPhotoInfo[0];
                
                if (receivedPhotoSizes[@"alt_sizes"] && [receivedPhotoSizes[@"alt_sizes"] isKindOfClass:[NSArray class]]) {
                    
                    NSArray *receivedPhotos = receivedPhotoSizes[@"alt_sizes"];
                    NSLog(@"receivedPhotos.count = %d", receivedPhotos.count);

                    for (NSDictionary *postURLData in receivedPhotos) {
                        if ([postURLData[@"width"] integerValue] == 500 || [postURLData[@"width"] integerValue] == 487) {
                            post.imagePostURL = postURLData[@"url"];
                            post.imageWidth = [postURLData[@"width"] floatValue];
                            post.imageHeight = [postURLData[@"height"] floatValue];
                            NSLog(@"post.imagePostURL size = %@", NSStringFromCGSize(CGSizeMake([postURLData[@"width"] floatValue], [postURLData[@"height"] floatValue])));
                            break;
                        }
                    }
                }
            }
        }
        [posts addObject:post];
    }
    return [posts copy];
}

@end
