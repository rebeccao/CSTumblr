//
//  CSTumblrCollectionViewCell.m
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/19/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSTumblrCollectionViewCell.h"
#import "UIColor+CSColor.h"

@implementation CSTumblrCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.imageView.image = nil;
    self.textView.text = @"";
}


@end
