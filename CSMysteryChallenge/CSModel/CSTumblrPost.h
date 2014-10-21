//
//  CSTumblrPost.h
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/18/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTumblrPost : NSObject

@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSString *imagePostURL;
@property (assign, nonatomic) CGFloat imageWidth;
@property (assign, nonatomic) CGFloat imageHeight;

@end
