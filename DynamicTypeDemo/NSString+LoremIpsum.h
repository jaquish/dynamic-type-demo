//
//  NSString+LoremIpsum.h
//  DynamicTypeDemo
//
//  Created by Zach Jaquish on 10/16/14.
//  Copyright (c) 2014 Zachary Jaquish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LoremIpsum)

+ (NSString*)loremIpsum;
+ (NSString*)cacheIpsum;
+ (NSString*)baconIpsum;
+ (NSString*)pirateIpsum;

@end
