//
//  SyntaxHighlightTextStorage.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "SyntaxHighlightTextStorage.h"

@interface SyntaxHighlightTextStorage ()
@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, strong) NSDictionary *replacements;
@end

@implementation SyntaxHighlightTextStorage

- (NSString *)string {
    return self.backingStore.string;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _backingStore = [NSMutableAttributedString new];
        [self p_createHighlightPatterns];
    }
    return self;
}

- (NSDictionary<NSAttributedStringKey, id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range {
    return [self.backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)processEditing {
    [self p_performReplacementsForRange:self.editedRange];
    [super processEditing];
}

- (NSDictionary<NSAttributedStringKey, id> *)p_createAttributesForFontStyle:(UIFontTextStyle)style withTrait:(UIFontDescriptorSymbolicTraits)trait {
    
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
    UIFontDescriptor *descriptorWithTrait = [fontDescriptor fontDescriptorWithSymbolicTraits:trait];
    UIFont *font = [UIFont fontWithDescriptor:descriptorWithTrait size:0];
    return @{NSFontAttributeName : font};
}

- (void)applyStylesToRange:(NSRange)searchRange {
    
    NSDictionary<NSAttributedStringKey, id> *normalAttrs = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    [self addAttributes:normalAttrs range:searchRange];
    
    [self.replacements enumerateKeysAndObjectsUsingBlock:^(NSString *pattern, NSDictionary<NSAttributedStringKey, id> *attributes, BOOL * _Nonnull stop) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        [regex enumerateMatchesInString:self.backingStore.string options:0 range:searchRange usingBlock:^(NSTextCheckingResult * _Nullable match, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            NSRange matchRange = [match rangeAtIndex:1];
            [self addAttributes:attributes range:matchRange];
            NSUInteger maxRange = matchRange.location + matchRange.length;
            if (maxRange + 1 < self.length) {
                [self addAttributes:normalAttrs range:NSMakeRange(maxRange, 1)];
            }
            
        }];
    }];
    
}

- (void)p_createHighlightPatterns {
    UIFontDescriptor *scriptFontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{ UIFontDescriptorFamilyAttribute : @"Zapfino" }];
    UIFontDescriptor *bodyFontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    NSNumber *bodyFontSize = @([bodyFontDescriptor pointSize]);
    UIFont *scriptFont = [UIFont fontWithDescriptor:scriptFontDescriptor size:(CGFloat)bodyFontSize.floatValue];
    
    NSDictionary<NSAttributedStringKey, id> *boldAttributes = [self p_createAttributesForFontStyle:UIFontTextStyleBody withTrait:UIFontDescriptorTraitBold];
    NSDictionary<NSAttributedStringKey, id> *italicAttributes = [self p_createAttributesForFontStyle:UIFontTextStyleBody withTrait:UIFontDescriptorTraitItalic];
    
    NSDictionary<NSAttributedStringKey, id> *strikeThroughAttributes = @{ NSStrikethroughStyleAttributeName : @1 };
    NSDictionary<NSAttributedStringKey, id> *scriptAttributes = @{ NSFontAttributeName : scriptFont };
    NSDictionary<NSAttributedStringKey, id> *redTextAttributes = @{ NSForegroundColorAttributeName : UIColor.redColor };
    
    self.replacements = @{
                          @"(\\*\\w+(\\s\\w+)*\\*)" : boldAttributes,
                          @"(_\\w+(\\s\\w+)*_)": italicAttributes,
                          @"([0-9]+\\.)\\s": boldAttributes,
                          @"(-\\w+(\\s\\w+)*-)": strikeThroughAttributes,
                          @"(~\\w+(\\s\\w+)*~)": scriptAttributes,
                          @"\\s([A-Z]{3,})\\s": redTextAttributes
                          };
}

- (void)p_performReplacementsForRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [[NSString stringWithString:self.backingStore.string] lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[NSString stringWithString:self.backingStore.string] lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    
    [self applyStylesToRange:extendedRange];
}

- (void)update {
    NSDictionary<NSAttributedStringKey, id> *bodyFont = @{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody] };
    [self addAttributes:bodyFont range:NSMakeRange(0, self.length)];
    
    [self p_createHighlightPatterns];
    [self applyStylesToRange:NSMakeRange(0, self.length)];
}

@end
