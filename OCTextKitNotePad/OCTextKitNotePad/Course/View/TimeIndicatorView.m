//
//  TimeIndicatorView.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "TimeIndicatorView.h"

@interface TimeIndicatorView ()
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UILabel *label;
@end

@implementation TimeIndicatorView

- (instancetype)initWithDate:(NSDate *)date {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _fillColor = [UIColor colorWithRed:0.329 green:0.584 blue:0.898 alpha:1];
        _label = [UILabel new];
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd\rMMMM\ryyyy";
        NSString *formattedDate = [formatter stringFromDate:date];
        
        _label.text = formattedDate.uppercaseString;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UIColor.whiteColor;
        _label.numberOfLines = 0;
        
        [self addSubview:_label];
    }
    
    return self;
}

- (void)updateSize {
    _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _label.frame = CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX);
    [_label sizeToFit];
    
    CGFloat radius = [self p_radiusToSurroundFrame:_label.frame];
    self.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    
    _label.center = self.center;
    
    CGFloat padding = 5.0;
    self.center = CGPointMake(self.center.x + _label.frame.origin.x - padding, self.center.y - _label.frame.origin.y + padding);
}

- (UIBezierPath *)curvePathWithOrigin:(CGPoint)origin {
    return [UIBezierPath bezierPathWithArcCenter:origin radius:[self p_radiusToSurroundFrame:_label.frame] startAngle:-M_PI endAngle:M_PI clockwise:YES];
}

- (CGFloat)p_radiusToSurroundFrame:(CGRect)frame {
    return (CGFloat)MAX(frame.size.width, frame.size.height);
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _fillColor.CGColor);
    
    UIBezierPath *path = [self curvePathWithOrigin:_label.center];
    [path fill];
}

@end
