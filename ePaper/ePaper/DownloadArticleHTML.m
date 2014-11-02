//
//  DownloadArticleHTML.m
//  ePaper
//
//  Created by Sanjay Dandekar on 22/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "DownloadArticleHTML.h"
#import "AppDelegate.h"
#import "Utility.h"

#define NEEDLE_1 @"<div id=\"divArtBody\""
#define NEEDLE_2 @"<div id=\"divEmailsAndUrls\""

#define HTML_SNIPPET @"\357\273\277<html><head><style>div {font-family: Frutiger, 'Frutiger Linotype', Univers, Calibri, 'Gill Sans', 'Gill Sans MT', 'Myriad Pro', Myriad, 'DejaVu Sans Condensed', 'Liberation Sans', 'Nimbus Sans L', Tahoma, Geneva, 'Helvetica Neue', Helvetica, Arial, sans-serif;} div#divArticleBlurb {font-size: 1.75em;} div#divArticleContent {font-size: 1.25em;}</style></head><body>%@</body></html>"

@implementation DownloadArticleHTML

@synthesize article = _article;

@synthesize edition = _edition;

@synthesize ctrl = _ctrl;

- (void) main
{
    // We have to do a HTTP get request to a URL of type ->
    // http://epaperbeta.timesofindia.com/Article.aspx?eid=31805&articlexml=Uddhav-blinks-heads-for-Delhi-to-meet-BJP-22102014001058
    //
    // So now lets form the url
    NSString* urlString = [NSString stringWithFormat:@"http://epaperbeta.timesofindia.com/Article.aspx?eid=%@&articlexml=%@", self.edition, self.article.name];
    // Download the URL content
    NSData* haystackData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if (haystackData != nil && haystackData.length > 0)
    {
        // Convert the haystackData to string for this operation
        NSString* haystack = [[NSString alloc] initWithData:haystackData encoding:NSUTF8StringEncoding];
        // We now have to search for the string <div id="divArtBody"
        NSRange range = [haystack rangeOfString: NEEDLE_1];
        if (range.length > 0)
        {
            // Remember this position
            int startIndex = (int)(range.location);
            // Throw away the initial data
            haystack = [haystack substringFromIndex: startIndex];
            // Now find <div id="divEmailsAndUrls"
            range = [haystack rangeOfString: NEEDLE_2];
            if (range.length > 0)
            {
                // Throw away the rest of the data
                haystack = [haystack substringToIndex: range.location];
                // Now create html out of it
                haystack = [NSString stringWithFormat:HTML_SNIPPET, haystack];
                // Form the path to file
                NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@/%@.html", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, self.edition, self.article.name];
                [Utility writeData:[haystack dataUsingEncoding:NSUTF8StringEncoding] toFile:filePath];
                //
                [self.ctrl imageDownloaded];
            }
        }
    }
}

@end
