//
//  CSTumblrManager.h
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/18/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSTumblrManagerDelegate
- (void)didReceiveTumblrPosts:(NSArray *)posts  error:(NSError *)error;
@end

@interface CSTumblrManager : NSObject

@property (weak, nonatomic) id<CSTumblrManagerDelegate> delegate;

- (void)fetchTumblrData;

@end
