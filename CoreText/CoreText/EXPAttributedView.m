//
//  EXPAttributedView.m
//  CoreText
//
//  Created by iwashita jiro on 13/01/31.
//  Copyright (c) 2013年 jiroiwas. All rights reserved.
//
#import <CoreText/CoreText.h>

#import "EXPAttributedView.h"

@implementation EXPAttributedView {
    UIFont *_font;
    NSMutableAttributedString *_attrText;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    _font = [UIFont fontWithName:@"HiraMinProN-W3" size:14.0f];
    _text = @"";
    _keyword = @"";
}

- (void)drawRect:(CGRect)rect
{
//    [self drawTextCF];
    [self drawTextNS];
//    [self drawText3];
}

// デフォルトの属性情報の取得
- (NSMutableDictionary *)normalAttributes
{
    
    // CTFontRefの設定
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
    
    // 属性情報の作成
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:(__bridge id)fontRef forKey:(id)kCTFontAttributeName];
    CFRelease(fontRef);
    
    // 縦書き
    [attributes setObject:[NSNumber numberWithBool:YES] forKey:(id)kCTVerticalFormsAttributeName];
    
    return attributes;
}

// 強調文字の属性情報の取得
- (NSMutableDictionary *)strongAttributes
{
    
    // CTFontRefの設定
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
    
    // 属性情報の作成
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:(__bridge id)fontRef forKey:(id)kCTFontAttributeName];
    [attributes setObject:(__bridge id)[UIColor blueColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    [attributes setObject:[NSNumber numberWithInt:(int)kCTUnderlineStyleSingle|kCTUnderlinePatternDot] forKey:(id)kCTUnderlineStyleAttributeName];
    [attributes setObject:[NSNumber numberWithFloat:6.0] forKey:(id)kCTStrokeWidthAttributeName];
    
    // 縦書き
    [attributes setObject:[NSNumber numberWithBool:YES] forKey:(id)kCTVerticalFormsAttributeName];
    
    CFRelease(fontRef);
    
    return attributes;
   
}

- (void)drawTextNS
{
    // 属性付き文字列の作成
    if (!_text) _text = @"";
    NSMutableDictionary *normalAttributes = [self normalAttributes];
    _attrText = [[NSMutableAttributedString alloc] initWithString:_text
                                                       attributes:normalAttributes];
    
    // 強調文字の属性情報取得
    NSMutableDictionary *strongAttributes = [self strongAttributes];
    
    // 正規表現で検索して強調文字の属性を追加
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:_keyword options:NSRegularExpressionCaseInsensitive error:nil];
    
    id proc = ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange matchRange = [result rangeAtIndex:0];
        [_attrText addAttributes:strongAttributes range:matchRange];
    };
    
    [regexp enumerateMatchesInString:_text
                             options:0
                               range:NSMakeRange(0, [_text length])
                          usingBlock:proc];
    
    
    // コンテクスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 現在の座標系の保存（もとに戻すため）
    CGContextSaveGState(context);
    
    // 座標の反転
//    CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(self.bounds));
//    CGContextConcatCTM(context, transform);
    CGContextTranslateCTM(context, 0, CGRectGetHeight(self.bounds));
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    // 文字列の描画
    [self drawByCTFrame:context];
//    [self drawByCTFrameLoop:context];
//    [self drawByCTLine:context];
    
    // もとの座標系の復元
    CGContextRestoreGState(context);
    
}

- (void)drawByCTFrame:(CGContextRef)context
{
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attrText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // RTL（右から左へ）
    NSDictionary *frameAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCTFrameProgressionRightToLeft] forKey:(id)kCTFrameProgressionAttributeName];
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(
                                                   frameSetter,
                                                   CFRangeMake(0, [_attrText length]),
                                                   path,
                                                   (__bridge CFDictionaryRef)frameAttributes
                                                   );
    CTFrameDraw(frameRef, context);
    CFRelease(frameSetter);
    CFRelease(frameRef);
    
}

- (void)drawByCTFrameLoop:(CGContextRef)context
{
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attrText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height));
    
    // RTL（右から左へ）
    NSDictionary *frameAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCTFrameProgressionRightToLeft] forKey:(id)kCTFrameProgressionAttributeName];
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(
                                frameSetter,
                                CFRangeMake(0, [_attrText length]),
                                path,
                                (__bridge CFDictionaryRef)frameAttributes
                        );
    
    CFArrayRef linesRef = CTFrameGetLines(frameRef);
    NSMutableArray *lines = [NSMutableArray arrayWithArray:(__bridge id)linesRef];
    CGPoint *origins = malloc(sizeof(CGPoint) * [lines count]);
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);
    for (int i = 0; i < [lines count]; ++i) {
        CGPoint origin = origins[i];
        CGContextSetTextPosition(context, origin.x, origin.y);
        CTLineRef lineRef = (__bridge CTLineRef)[lines objectAtIndex:i];
        CTLineDraw(lineRef, context);
    }
    free(origins);
    
    CFRelease(frameSetter);
    CFRelease(frameRef);
    
    
}

- (void)drawByCTLine:(CGContextRef)context
{
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)_attrText);
    CGContextSetTextPosition(context, 10, 20);
    CTLineDraw(line, context);
    CFRelease(line);
    
}

- (void)drawTextCF
{

    // コンテクスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // CTFontRefの設定
    CFStringRef name = CFSTR("Helvetica");
    CGFloat size = 30.0f;
    CTFontRef font = CTFontCreateWithName(name, size, nil);
    
    CFStringRef string = CFSTR("hoge");
    
    // 属性付き文字列の作成
    CFStringRef keys[] = {kCTFontNameAttribute};
    CFTypeRef values[] = {font};
    
    CFDictionaryRef attributes = CFDictionaryCreate(kCFAllocatorDefault, (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    CFAttributedStringRef attrString = CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
    
    CFRelease(string);
    CFRelease(attributes);
    
    // 現在の座標系の保存（もとに戻すため）
    CGContextSaveGState(context);
    
    // 座標の反転
    CGRect bounds = self.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    // 文字列の描画
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSetTextPosition(context, 10, 20);
    CTLineDraw(line, context);
    
    // もとの座標系の復元
    CGContextRestoreGState(context);
    
    CFRelease(line);
    CFRelease(attrString);
    CFRelease(font);

}

- (void)drawText3
{
	// create a font, quasi systemFontWithSize:24.0
	CTFontRef sysUIFont = CTFontCreateUIFontForLanguage(kCTFontSystemFontType,
                                                        48.0, NULL);
    
	// create a naked string
	NSString *string = @"Some Text";
    
	// blue
	CGColorRef color = [UIColor blueColor].CGColor;
    
	// single underline
	NSNumber *underline = [NSNumber numberWithInt:kCTUnderlineStyleSingle];
    
	// pack it into attributes dictionary
	NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)sysUIFont, (id)kCTFontAttributeName,
                                    color, (id)kCTForegroundColorAttributeName,
                                    underline, (id)kCTUnderlineStyleAttributeName, nil];
    
	// make the attributed string
	NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
                                                                       attributes:attributesDict];
    
	// now for the actual drawing
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	// flip the coordinate system
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
	// draw
	CTLineRef line = CTLineCreateWithAttributedString(
                                                      (__bridge CFAttributedStringRef)stringToDraw);
	CGContextSetTextPosition(context, 10.0, 10.0);
	CTLineDraw(line, context);
    
	// clean up
	CFRelease(line);
	CFRelease(sysUIFont);
    
}

@end
