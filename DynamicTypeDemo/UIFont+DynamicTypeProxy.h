//
//  UIFont+DynamicTypeProxy.h
//  DynamicTypeDemo
//
//  Created by Zach Jaquish on 10/16/14.
//  Copyright (c) 2014 Zachary Jaquish. All rights reserved.
//

#import <UIKit/UIKit.h>

// Separate category here, fake changing context size in-app, instead
// of having to pop out to iOS settings.
@interface UIFont (DynamicTypeProxy)

+ (UIFont*)preferredFontForContextSize:(NSString*)contextSize textStyle:(NSString *)style;

@end
