//
//  CSTumblrCollectionViewCell.h
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/19/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSTumblrCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
