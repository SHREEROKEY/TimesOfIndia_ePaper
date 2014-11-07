//
//  FetchDayIndexData.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "FetchDayIndexData.h"
#import <libxml/xmlmemory.h>
#import <libxml/parser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <libxml/xmlschemas.h>
#import "Page.h"
#import "Article.h"
#import "Utility.h"

#define URL         @"http://epaperbeta.timesofindia.com/index.aspx?eid=%@&dt=%@"
#define NEEDLE      @"var strDayIndex = '"
#define END_NEEDLE  @"'"

#define PAGE_XPATH      @"/DayIndex/Page"
#define PAGE_XPATH_1    @"/DayIndex/Page[%d]"
#define NAME_ATTR       @"name"
#define TITLE_ATTR      @"title"
#define ART_XPATH       @"/DayIndex/Page[%d]/Article"
#define ART_XPATH_1     @"/DayIndex/Page[%d]/Article[%d]"
#define ART_XPATH_2     @"/DayIndex/Page[%d]/Article[%d]/ArticleTitle"
#define ART_XPATH_3     @"/DayIndex/Page[%d]/Article[%d]/ArticleBody"
#define IMAGE_URL       @"http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/%@/%@/%@/%@/%@/Article/%@/%@_%@_%@_%@_%@.jpg"
#define PAGE_THUMB_URL  @"http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/%@/%@/%@/%@/%@/Page/%@.jpg"
#define MP3_URL         @"http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/%@/%@/%@/%@/%@/podcast/%@.mp3"

#define DAYINDEX_FILE   @"/DayIndex.xml"

@interface FetchDayIndexData()
{
    NSString* pathToDayData;
}
@end


@implementation FetchDayIndexData

@synthesize edition = _edition;
@synthesize date = _date;
@synthesize ctrl = _ctrl;
@synthesize cityName = _cityName;

- (void) main
{
    // The data for file
    NSData* data = nil;
    // Set the controller data to nil
    self.ctrl.pages = nil;
    // Create the path to today's data in Documents folder
    pathToDayData = [NSString stringWithFormat:@"%@/%@/%@", [Utility applicationDocumentsDirectory], self.date, [NSString stringWithFormat:@"%d", (int)self.edition.editionId]];
    // The file that stored day index
    NSString *dayIndexFile = [NSString stringWithFormat:@"%@/%@", pathToDayData, DAYINDEX_FILE];
    // Check if the directory exists or not?
    if ([[NSFileManager defaultManager] fileExistsAtPath:dayIndexFile])
    {
        // Read the file
        data = [NSData dataWithContentsOfFile:dayIndexFile];
    }
    else
    {
        // create the URL
        NSString* strUrl = [NSString stringWithFormat:URL, [NSString stringWithFormat:@"%d", (int)self.edition.editionId], self.date];
        NSURL* url = [NSURL URLWithString:strUrl];
        // Now execute HTTP get command
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        // execute
        NSURLResponse* resp = nil;
        NSError* error = nil;
        //
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
        // Create the directory first
        [[NSFileManager defaultManager] createDirectoryAtPath:pathToDayData withIntermediateDirectories:YES attributes:nil error:&error];
        // Save this data to the disk so next time we do not have to download it
        [Utility writeData:data toFile:dayIndexFile];
    }
    // do we have data?
    if (data != nil && data.length > 0)
    {
        // convert to string
        NSString* strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // find the existance of var strDayIndex = '
        NSRange range = [strData rangeOfString: NEEDLE];
        if (range.length > 0)
        {
            int startIndex = (int)(range.location + NEEDLE.length);
            // find the end index
            strData = [strData substringFromIndex: startIndex];
            range = [strData rangeOfString: END_NEEDLE];
            //
            if (range.location > 0)
            {
                strData = [strData substringToIndex: range.location];
                // Get the data from strData
                NSData* dailyData = [strData dataUsingEncoding:NSUTF8StringEncoding];
                // Have we got any data?
                if (dailyData != nil && [dailyData length] > 0x0)
                {
                    // yes - create the document object
                    xmlDocPtr document = xmlReadMemory([dailyData bytes], (int)[dailyData length], "", NULL, 0);
                    // do we have valid document?
                    if (document != NULL)
                    {
                        // yes - create Context reference
                        xmlXPathContextPtr context = xmlXPathNewContext(document);
                        if (context != NULL)
                        {
                            // get the count of /DayIndex/Page
                            NSInteger pageCount = [self getNodeCountFromContext: context withXPath: PAGE_XPATH];
                            // now iterate and get all items
                            //
                            NSMutableArray* pages = [[NSMutableArray alloc] init];
                            for (int index = 0; index < pageCount; index++)
                            {
                                Page* page = [[Page alloc] init];
                                // create the XPath for page
                                NSString* xpath = [NSString stringWithFormat: PAGE_XPATH_1, index + 1];
                                //
                                page.title = [self getAttributeValueFormContext: context xPath: xpath attributeName: TITLE_ATTR];
                                if (![page.title hasPrefix:@"Advertisement"])
                                {
                                    // do not include advertisement pages
                                    page.name = [self getAttributeValueFormContext: context xPath: xpath attributeName: NAME_ATTR];
                                    // get article count
                                    NSString* artCntXpath = [NSString stringWithFormat:ART_XPATH, index + 1];
                                    NSInteger aCount = [self getNodeCountFromContext: context withXPath: artCntXpath];
                                    //
                                    //
                                    NSMutableArray* articles = [[NSMutableArray alloc] init];
                                    for (int aidx = 0; aidx < aCount; aidx++)
                                    {
                                        Article* art = [[Article alloc] init];
                                        // create the xpath
                                        NSString* artBodyXPath = [NSString stringWithFormat:ART_XPATH_3, index + 1, aidx + 1];
                                        art.body = [self getNodeContentFromContext:context withXPath:artBodyXPath];
                                        art.body = [art.body stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                                        art.body = [art.body stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, art.body.length)];
                                        art.body = [art.body stringByReplacingOccurrencesOfString:@"<p>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, art.body.length)];
                                        art.body = [art.body stringByReplacingOccurrencesOfString:@"<br>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, art.body.length)];
                                        //
                                        NSString* artTitleXPath = [NSString stringWithFormat:ART_XPATH_2, index + 1, aidx + 1];
                                        art.title = [self getNodeContentFromContext:context withXPath:artTitleXPath];
                                        // do we have a valid body?
                                        NSString* upperTitle = [art.title uppercaseString];
                                        if (!(([upperTitle containsString:@"TIMES"] || [upperTitle hasPrefix:@"DATE LINE"]) && [art.body isEqualToString:@"..."]))
                                        {
                                            NSString* artNameXPath = [NSString stringWithFormat:ART_XPATH_1, index + 1, aidx + 1];
                                            art.name = [self getAttributeValueFormContext:context xPath:artNameXPath attributeName:NAME_ATTR];
                                            //
                                            NSString* imageParts = [art.name substringWithRange: NSMakeRange(art.name.length - 14, 14)];
                                            // now extract parts
                                            NSString* day = [imageParts substringWithRange: NSMakeRange(0, 2)];
                                            NSString* month = [imageParts substringWithRange: NSMakeRange(2, 2)];
                                            NSString* year = [imageParts substringWithRange: NSMakeRange(4, 4)];
                                            NSString* pageNumber = [imageParts substringWithRange: NSMakeRange(8, 3)];
                                            NSString* articleNumber = [imageParts substringWithRange: NSMakeRange(11, 3)];
                                            //
                                            art.mp3Url = [NSString stringWithFormat:MP3_URL, self.edition.editionPath, self.cityName, year, month, day, art.name];
                                            // // http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/THETIMESOFINDIA/BANGALORE/2014/10/22/podcast/Doing-business-to-get-easy-registration-in-just-22102014001038.mp3
                                            //
                                            if (page.thumbnailUrl == nil)
                                            {
                                                // http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/THETIMESOFINDIA/BANGALORE/2014/09/19/PageThumb/19_09_2014_001.jpg
                                                page.thumbnailUrl = [NSString stringWithFormat:PAGE_THUMB_URL, self.edition.editionPath, self.cityName, year, month, day, page.name];
                                                NSString* imageFilePath = [NSString stringWithFormat:@"%@/%@", pathToDayData, page.name];
                                                NSData* imageData = nil;
                                                if ([[NSFileManager defaultManager] fileExistsAtPath:imageFilePath])
                                                {
                                                    imageData = [NSData dataWithContentsOfFile: imageFilePath];
                                                    page.thumbnailImage = [UIImage imageWithData:imageData];
                                                }
                                                else
                                                {
                                                    // Do not load the image now as it slows down the process of loading first page
                                                    // Store the local path as we will need it later to persist the data
                                                    page.localPath = imageFilePath;
                                                }
                                            }
                                            // http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/THETIMESOFINDIA/BANGALORE/2014/09/19/Article/001/19_09_2014_001_016.jpg
                                            art.imageUrl = [NSString stringWithFormat:IMAGE_URL, self.edition.editionPath, self.cityName, year, month, day, pageNumber, day, month, year, pageNumber, articleNumber];
                                            //
                                            [articles addObject:art];
                                        }
                                    }
                                    //
                                    if (articles.count > 0)
                                    {
                                        page.articles = articles;
                                        //
                                        [pages addObject:page];
                                    }
                                }
                            }
                            //
                            self.ctrl.pages = pages;
                        }
                    }
                }
            }
        }
    }
    // Inform the controller that data is updated
    // This may get called when we are unble to fetch data
    [self.ctrl dataUpdated];
}

// Given a node return its content as string. If the content is empty
// we return an empty string so that the caller avoids a null check
- (NSString *) getNodeContentFromNode:(xmlNodePtr)node
{
    NSString *value = @"";
    
    xmlChar *content = NULL;
    
    // check if node is null or not
    if (node != NULL && node->children != NULL && node->children->content != NULL)
    {
        if (node->type == XML_ELEMENT_NODE)
        {
            // Node is valid - get its text content
            content = xmlNodeGetContent(node->children);
        }
        else if (node->type == XML_ATTRIBUTE_NODE)
        {
            // Node is valid - get its text content
            content = xmlNodeGetContent(node);
        }
        
        if (content != NULL)
        {
            value = [NSString stringWithCString:(const char *)content encoding:NSUTF8StringEncoding];
        }
    }
    
    xmlFree(content);
    
    return value;
}

// Get note text content for the given node - if the content is not present
// we return empty string
- (NSString *) getNodeContentFromContext:(xmlXPathContextPtr)context withXPath:(NSString *)xpath
{
    NSString *value = @"";
    
    if (context == nil)
    {
        return value;
    }
    
    // Local variables
    xmlXPathObjectPtr xpathPtr = nil;
    xmlChar *queryString = (xmlChar *)[xpath cStringUsingEncoding:NSUTF8StringEncoding];
    // Execute the xpath
    xpathPtr = xmlXPathEvalExpression(queryString, context);
    
    // do we have any data
    if (xmlXPathNodeSetIsEmpty(xpathPtr->nodesetval) != 1)
    {
        value = [self getNodeContentFromNode:xpathPtr->nodesetval->nodeTab[0x0]];
    }
    
    xmlXPathFreeObject(xpathPtr);
    return value;
}

// Get how many nodes exist in the XML for a given xPath
- (NSInteger) getNodeCountFromContext:(xmlXPathContextPtr)context withXPath:(NSString *)xpath
{
    NSInteger count = 0;
    
    if (context == nil)
    {
        return count;
    }
    
    // Local variables
    xmlXPathObjectPtr xpathPtr = nil;
    // Execute the xpath
    xmlChar *queryString = (xmlChar *)[xpath cStringUsingEncoding:NSUTF8StringEncoding];
    
    xpathPtr = xmlXPathEvalExpression(queryString, context);
    
    // do we have any data
    if (xmlXPathNodeSetIsEmpty(xpathPtr->nodesetval) != 1)
    {
        count = xpathPtr->nodesetval->nodeNr;
    }
    else
    {
        count= 0;
    }
    
    xmlXPathFreeObject(xpathPtr);
    return count;
}

- (xmlNodePtr)getNodeFromContext:(xmlXPathContextPtr)context withXPath:(NSString *)xpath
{
    xmlXPathObjectPtr result;
    
    if (context == nil)
    {
        return nil;
    }
    
    xmlChar *queryString = (xmlChar *)[xpath cStringUsingEncoding:NSUTF8StringEncoding];
    result = xmlXPathEvalExpression(queryString, context);
    
    if (result == nil)
    {
        return nil;
    }
    
    if (xmlXPathNodeSetIsEmpty(result->nodesetval))
    {
        xmlXPathFreeObject(result);
        return nil;
    }
    
    xmlNodeSetPtr nodes = result->nodesetval;
    if (!nodes)
    {
        /* Cleanup */
        xmlXPathFreeObject(result);
        return nil;
    }
    
    if (nodes->nodeNr <= 0x0)
    {
        /* Cleanup */
        xmlXPathFreeObject(result);
        return nil;
    }
    
    // We only care about the first node
    xmlNodePtr node = nodes->nodeTab[0x0];
    
    xmlXPathFreeObject(result);
    
    return node;
}

- (NSString *)getAttributeValueFormContext:(xmlXPathContextPtr)context xPath:(NSString*)xPath attributeName:(NSString *)attributeName;
{
    xmlNodePtr node = [self getNodeFromContext:context withXPath:xPath];
    
    NSString *value = @"";;
    
    xmlChar *content = NULL;
    
    if(node)
    {
        if (node->properties)
        {
            xmlAttr *attrib = node->properties;
            if (attrib->type == XML_ATTRIBUTE_NODE)
            {
                // Iterate over the available attributes
                while (attrib)
                {
                    if ((xmlStrcmp(attrib->name,(const xmlChar *) [attributeName cStringUsingEncoding:NSUTF8StringEncoding])) == 0)
                    {
                        xmlNodePtr childNode = attrib->children;
                        if (childNode->type == XML_TEXT_NODE)
                        {
                            content = xmlNodeGetContent(childNode);
                            value = [NSString stringWithCString:(const char *)content encoding:NSUTF8StringEncoding];
                        }
                        
                        break;
                    }
                    // Move to the next attribute
                    attrib = attrib->next;
                }
            }
        }
    }
    
    xmlFree(content);
    
    return value;
}

@end
