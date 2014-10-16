//
//  ViewController.m
//  DynamicTypeDemo
//
//  Created by Zach Jaquish on 10/16/14.
//  Copyright (c) 2014 Zachary Jaquish. All rights reserved.
//

#import "ViewController.h"
#import "NSString+LoremIpsum.h"
#import "UIFont+DynamicTypeProxy.h"

@interface ViewController ()

@property (nonatomic) NSArray *contentSizeVisibleNames;
@property (nonatomic) NSArray *contentSizeConstantNames;
@property (nonatomic, weak) IBOutlet UISlider *contentSizeSelector;
@property (nonatomic, weak) IBOutlet UISegmentedControl *textSelector;
@property (nonatomic, weak) IBOutlet UILabel *contentNameLabel;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, weak) IBOutlet UISwitch *includeAccessibilitySizesSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *useSystemContentSize;

@end

@implementation ViewController
{
    int _loremIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentSizeVisibleNames = @[@"Extra Small",
                                     @"Small",
                                     @"Medium",
                                     @"Large",
                                     @"Extra Large",
                                     @"Extra Extra Large",
                                     @"Extra Extra Extra Large",
                                     @"Accessibility Medium",
                                     @"Accessibility Large",
                                     @"Accessibility Extra Large",
                                     @"Accessibility Extra Extra Large",
                                     @"Accessibility Extra Extra Extra Large"];
    
    self.contentSizeConstantNames = @[UIContentSizeCategoryExtraSmall,
                                      UIContentSizeCategorySmall,
                                      UIContentSizeCategoryMedium,
                                      UIContentSizeCategoryLarge,
                                      UIContentSizeCategoryExtraLarge,
                                      UIContentSizeCategoryExtraExtraLarge,
                                      UIContentSizeCategoryExtraExtraExtraLarge,
                                      UIContentSizeCategoryAccessibilityMedium,
                                      UIContentSizeCategoryAccessibilityLarge,
                                      UIContentSizeCategoryAccessibilityExtraLarge,
                                      UIContentSizeCategoryAccessibilityExtraExtraLarge,
                                      UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    
    self.textView.text = [NSString loremIpsum];
    
    [self updateText];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchIpsum:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.textView addGestureRecognizer:doubleTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateText)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

#pragma mark - Slider Control

- (IBAction)sliderValueChanged:(id)sender
{
    [self updateText];
}

- (IBAction)sliderTouchUpInside:(id)sender
{
    [self.contentSizeSelector setValue:[self sliderValue] animated:YES];
}

- (int)sliderValue
{
    return (self.contentSizeSelector.value + 0.5); // rounding
}

#pragma mark - Ipsum

- (void)switchIpsum:(id)sender
{
    _loremIndex = (_loremIndex + 1) % 4;
    [self updateText];
}

- (void)updateText
{
    if (self.useSystemContentSize.on) {
        NSString *contentSizeString = [[UIApplication sharedApplication] preferredContentSizeCategory];
        self.contentNameLabel.text = self.contentSizeVisibleNames[[self.contentSizeConstantNames indexOfObject:contentSizeString]];
    } else {
        self.contentNameLabel.text = self.contentSizeVisibleNames[[self sliderValue]];
    }
    self.textView.attributedText = [self fullText];
}

- (UIFont*)fontForTextStyle:(NSString*)style
{
    if (self.useSystemContentSize.on) {
        return [UIFont preferredFontForTextStyle:style];
    } else {
        return [UIFont preferredFontForContextSize:self.contentSizeConstantNames[[self sliderValue]] textStyle:style];
    }
}

- (IBAction)accessibilitySizesChanged:(id)sender
{
    if (self.includeAccessibilitySizesSwitch.on) {
        self.contentSizeSelector.maximumValue = 11;
    } else {
        self.contentSizeSelector.maximumValue = 6;
    }
    [self updateText];
}

- (IBAction)overrideWithSystemFontChanged:(id)sender
{
    self.contentSizeSelector.enabled = !self.useSystemContentSize.on;
    [self updateText];
}

- (NSAttributedString*)previewText
{
    NSArray *styles = @[UIFontTextStyleHeadline, UIFontTextStyleSubheadline, UIFontTextStyleBody, UIFontTextStyleFootnote, UIFontTextStyleCaption1, UIFontTextStyleCaption2];
    NSArray *summaryName = @[@"Headline", @"Subheadline", @"Body", @"Footnote", @"Caption 1", @"Caption 2"];
    
    NSMutableAttributedString *summary = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < [styles count]; i++) {
        UIFont *font = [self fontForTextStyle:styles[i]];
        NSAttributedString *line = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ / %.0fpt\n", summaryName[i], font.pointSize] attributes:@{NSFontAttributeName:font}];
        [summary appendAttributedString:line];
    }
    
    return [summary copy];
}

- (NSAttributedString*)loremText
{
    NSString *lorem;
    switch (_loremIndex) {
            case 0: lorem = [NSString loremIpsum];  break;
            case 1: lorem = [NSString baconIpsum];  break;
            case 2: lorem = [NSString pirateIpsum]; break;
            case 3: lorem = [NSString cacheIpsum];  break;
            
        default:
            break;
    }
    
    return [[NSAttributedString alloc] initWithString:lorem attributes:@{NSFontAttributeName:[self fontForTextStyle:UIFontTextStyleBody]}];
}

- (NSAttributedString*)fullText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    [text appendAttributedString:[self previewText]];
    [text appendAttributedString:[self loremText]];
    
    return text;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
