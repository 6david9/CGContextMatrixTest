//
//  CBView.m
//  test
//
//  Created by ly on 14-2-1.
//  Copyright (c) 2014年 ly. All rights reserved.
//

#import "CBView.h"
@import CoreText;

@implementation CBView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw background
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, self.bounds);
    
    // Translate CTM
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    CGContextTranslateCTM(context, w/2.0, h/2.0);
    
    // Draw coordinate
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextMoveToPoint(context, -w/2.0, 0.0);
    CGContextAddLineToPoint(context, w/2.0, 0.0);
    CGContextMoveToPoint(context, 0.0, -h/2.0);
    CGContextAddLineToPoint(context, 0.0, h/2.0);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
    
    // Draw Rect
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, CGRectMake(10, 10, 10, 10));
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    CGContextFillRect(context, CGRectMake(20, 20, 10, 10));
    
    // Draw normal text
    CGContextSetTextPosition(context, 0, 0);
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"line 1"
                                                               attributes:@{NSFontAttributeName:[self suggestedFont]}];
    CTLineRef line1 = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)str1);
    CTLineDraw(line1, context);
    
    CGFloat ascent1 = 0.0, descent1 = 0.0, leading1 = 0.0;
    CTLineGetTypographicBounds(line1, &ascent1, &descent1, &leading1);
    CGContextSetTextPosition(context, 0, ascent1+descent1+leading1);       // move text position

    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"line 2"
                                                               attributes:@{NSFontAttributeName:[self suggestedFont]}];
    CTLineRef line2 = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)str2);
    CTLineDraw(line2, context);
    
    CFRelease(line1);
    CFRelease(line2);
    
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    
    // Draw Scaled text
    CGAffineTransform textTransform = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(context, textTransform);
    
    CGContextSetTextPosition(context, 70, 0);
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"line 3"
                                                               attributes:@{NSFontAttributeName:[self suggestedFont]}];
    CTLineRef line3 = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)str3);
    CTLineDraw(line3, context);
    
    CGFloat ascent2 = 0.0, descent2 = 0.0, leading2 = 0.0;
    CTLineGetTypographicBounds(line3, &ascent2, &descent2, &leading2);
    CGContextSetTextPosition(context, 70, ascent2+descent2+leading2);       // move text position
    
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"line 4"
                                                               attributes:@{NSFontAttributeName:[self suggestedFont]}];
    CTLineRef line4 = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)str4);
    CTLineDraw(line4, context);
    
    CFRelease(line3);
    CFRelease(line4);
    
    CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextFillRect(context, CGRectMake(30, 30, 10, 10));
    
    CGContextRestoreGState(context);
}
                                
- (UIFont *)suggestedFont
{
    return [UIFont systemFontOfSize:30.0];      // fixed width font
}

@end
