//
//  CSViewController.h
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTumblrManager.h"

@interface CSViewController : UIViewController <CSTumblrManagerDelegate,
                                                UICollectionViewDataSource,
                                                UICollectionViewDelegateFlowLayout>

@end
