//
//  Note.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "Note.h"

@implementation Note
- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.contents = text;
        self.timestamp = [NSDate date];
    }
    
    return self;
}

- (NSString *)title {
    NSArray *lines = [self.contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return lines.firstObject;
}
@end
