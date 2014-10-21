//
//  UITextView+CShtml.m
//  CSMysteryChallenge
//
//  Created by Rebecca ODell on 10/19/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "UITextView+CShtml.h"

@implementation UITextView (CShtml)

- (void)setHtml:(NSString*)html
{
    NSError *err = nil;
    self.attributedText = [[NSAttributedString alloc] initWithData: [html dataUsingEncoding:NSUnicodeStringEncoding]
                                                           options: @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                             error: &err];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

@end
