//
//  UIFont+DynamicTypeProxy.m
//  DynamicTypeDemo
//
//  Created by Zach Jaquish on 10/16/14.
//  Copyright (c) 2014 Zachary Jaquish. All rights reserved.
//

#import "UIFont+DynamicTypeProxy.h"

@implementation UIFont (DynamicTypeProxy)

+ (UIFont*)preferredFontForContextSize:(NSString*)contextSize textStyle:(NSString *)style
{
    static NSMutableDictionary *fontMap = nil;
    
    if (!fontMap) {
        fontMap = [NSMutableDictionary dictionary];
        
        fontMap[UIContentSizeCategoryExtraSmall] =
        @{ UIFontTextStyleHeadline    : @(14),
           UIFontTextStyleSubheadline : @(12),
           UIFontTextStyleBody        : @(14),
           UIFontTextStyleFootnote    : @(12),
           UIFontTextStyleCaption1    : @(11),
           UIFontTextStyleCaption2    : @(11)};
               
        fontMap[UIContentSizeCategorySmall] =
        @{ UIFontTextStyleHeadline    : @(15),
           UIFontTextStyleSubheadline : @(13),
           UIFontTextStyleBody        : @(15),
           UIFontTextStyleFootnote    : @(12),
           UIFontTextStyleCaption1    : @(11),
           UIFontTextStyleCaption2    : @(11)};
        
        fontMap[UIContentSizeCategoryMedium] =
        @{ UIFontTextStyleHeadline    : @(16),
           UIFontTextStyleSubheadline : @(14),
           UIFontTextStyleBody        : @(16),
           UIFontTextStyleFootnote    : @(12),
           UIFontTextStyleCaption1    : @(11),
           UIFontTextStyleCaption2    : @(11)};
        
        fontMap[UIContentSizeCategoryLarge] =
        @{ UIFontTextStyleHeadline    : @(17),
           UIFontTextStyleSubheadline : @(15),
           UIFontTextStyleBody        : @(17),
           UIFontTextStyleFootnote    : @(13),
           UIFontTextStyleCaption1    : @(12),
           UIFontTextStyleCaption2    : @(11)};
        
        fontMap[UIContentSizeCategoryExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(18),
           UIFontTextStyleSubheadline : @(16),
           UIFontTextStyleBody        : @(18),
           UIFontTextStyleFootnote    : @(14),
           UIFontTextStyleCaption1    : @(13),
           UIFontTextStyleCaption2    : @(12)};
        
        fontMap[UIContentSizeCategoryExtraExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(19),
           UIFontTextStyleSubheadline : @(17),
           UIFontTextStyleBody        : @(19),
           UIFontTextStyleFootnote    : @(15),
           UIFontTextStyleCaption1    : @(14),
           UIFontTextStyleCaption2    : @(13)};
        
        fontMap[UIContentSizeCategoryExtraExtraExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(20),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
        
        fontMap[UIContentSizeCategoryAccessibilityMedium] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(24),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
        
        fontMap[UIContentSizeCategoryAccessibilityLarge] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(29),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
        
        fontMap[UIContentSizeCategoryAccessibilityExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(34),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
        
        fontMap[UIContentSizeCategoryAccessibilityExtraExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(40),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
        
        fontMap[UIContentSizeCategoryAccessibilityExtraExtraExtraLarge] =
        @{ UIFontTextStyleHeadline    : @(20),
           UIFontTextStyleSubheadline : @(18),
           UIFontTextStyleBody        : @(46),
           UIFontTextStyleFootnote    : @(16),
           UIFontTextStyleCaption1    : @(15),
           UIFontTextStyleCaption2    : @(14)};
    }
    
    if ([style isEqualToString:UIFontTextStyleHeadline]) {
        return [UIFont boldSystemFontOfSize:[fontMap[contextSize][style] floatValue]];
    } else {
        return [UIFont systemFontOfSize:[fontMap[contextSize][style] floatValue]];
    }
}

@end
