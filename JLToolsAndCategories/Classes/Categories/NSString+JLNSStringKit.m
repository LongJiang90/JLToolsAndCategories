//
//  NSString+JLNSStringKit.m
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "NSString+JLNSStringKit.h"

#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation NSString (JLNSStringKit)


#pragma mark - 拼音
//@TODO:汉字转拼音
- (NSString *)jl_pinyinWithPhoneticSymbol
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

//@TODO:汉字转拼音
- (NSString *)jl_pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self jl_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

//@TODO:汉字转拼音数组
- (NSArray *)jl_pinyinArray
{
    NSArray *array = [[self jl_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

//@TODO:汉字转拼音去空格
- (NSString *)jl_pinyinWithoutBlank
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self jl_pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

//@TODO:所有汉字的首写字母数组
- (NSArray *)jl_pinyinInitialsArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self jl_pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

//@TODO:所有汉字的首写字母字符串
- (NSString *)jl_pinyinInitialsString
{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self jl_pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

#pragma mark - 字符串SIZE
//@TODO:计算文字的大小
- (CGSize)jl_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

//@TODO:计算文字的大小(约束宽度)
- (CGSize)jl_sizeForFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

//@TODO:计算文字的大小(约束高度)
- (CGSize)jl_sizeForFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

//@TODO:计算文字的宽度
- (CGFloat)jl_widthForFont:(UIFont *)font
{
    CGSize size = [self jl_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

//@TODO:计算文字的宽度（约束高度）
- (CGFloat)jl_widthForFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}

//@TODO:计算文字的高度
- (CGFloat)jl_heightForFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self jl_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

#pragma mark - 验证
//@TODO:正则表达式验证
- (BOOL)jl_matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options
{
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

//@TODO:正则表达式验证后BLOCK操作
- (void)jl_enumerateRegexMatches:(NSString *)regex
                         options:(NSRegularExpressionOptions)options
                      usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block
{
    if (regex.length == 0 || !block) return;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regex) return;
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

//@TODO:获得字符串中符合正则表达式的字符串
- (NSString *)jl_stringByReplacingRegex:(NSString *)regex
                                options:(NSRegularExpressionOptions)options
                             withString:(NSString *)replacement;
{
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

//@TODO:是否为空字符串
- (BOOL)jl_isEmptyString
{
    if (self == nil || self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([self jl_trimmingWhitespaceAndNewlines].length < 1) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Emoji
//@TODO:是否包含Emoji
- (BOOL)jl_containsEmoji
{
    return [self jl_containsEmojiForSystemVersion:kSystemVersion];
}

//@TODO:是否包含Emoji（根据系统版本）
- (BOOL)jl_containsEmojiForSystemVersion:(float)systemVersion
{
    // If detected, it MUST contains emoji; otherwise it MAY not contains emoji.
    static NSMutableCharacterSet *minSet8_3, *minSetOld;
    // If detected, it may contains emoji; otherwise it MUST NOT contains emoji.
    static NSMutableCharacterSet *maxSet;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        minSetOld = [NSMutableCharacterSet new];
        [minSetOld addCharactersInString:@"u2139\u2194\u2195\u2196\u2197\u2198\u2199\u21a9\u21aa\u231a\u231b\u23e9\u23ea\u23eb\u23ec\u23f0\u23f3\u24c2\u25aa\u25ab\u25b6\u25c0\u25fb\u25fc\u25fd\u25fe\u2600\u2601\u260e\u2611\u2614\u2615\u261d\u261d\u263a\u2648\u2649\u264a\u264b\u264c\u264d\u264e\u264f\u2650\u2651\u2652\u2653\u2660\u2663\u2665\u2666\u2668\u267b\u267f\u2693\u26a0\u26a1\u26aa\u26ab\u26bd\u26be\u26c4\u26c5\u26ce\u26d4\u26ea\u26f2\u26f3\u26f5\u26fa\u26fd\u2702\u2705\u2708\u2709\u270a\u270b\u270c\u270c\u270f\u2712\u2714\u2716\u2728\u2733\u2734\u2744\u2747\u274c\u274e\u2753\u2754\u2755\u2757\u2764\u2795\u2796\u2797\u27a1\u27b0\u27bf\u2934\u2935\u2b05\u2b06\u2b07\u2b1b\u2b1c\u2b50\u2b55\u3030\u303d\u3297\u3299\U0001f004\U0001f0cf\U0001f170\U0001f171\U0001f17e\U0001f17f\U0001f18e\U0001f191\U0001f192\U0001f193\U0001f194\U0001f195\U0001f196\U0001f197\U0001f198\U0001f199\U0001f19a\U0001f201\U0001f202\U0001f21a\U0001f22f\U0001f232\U0001f233\U0001f234\U0001f235\U0001f236\U0001f237\U0001f238\U0001f239\U0001f23a\U0001f250\U0001f251\U0001f300\U0001f301\U0001f302\U0001f303\U0001f304\U0001f305\U0001f306\U0001f307\U0001f308\U0001f309\U0001f30a\U0001f30b\U0001f30c\U0001f30d\U0001f30e\U0001f30f\U0001f310\U0001f311\U0001f312\U0001f313\U0001f314\U0001f315\U0001f316\U0001f317\U0001f318\U0001f319\U0001f31a\U0001f31b\U0001f31c\U0001f31d\U0001f31e\U0001f31f\U0001f320\U0001f330\U0001f331\U0001f332\U0001f333\U0001f334\U0001f335\U0001f337\U0001f338\U0001f339\U0001f33a\U0001f33b\U0001f33c\U0001f33d\U0001f33e\U0001f33f\U0001f340\U0001f341\U0001f342\U0001f343\U0001f344\U0001f345\U0001f346\U0001f347\U0001f348\U0001f349\U0001f34a\U0001f34b\U0001f34c\U0001f34d\U0001f34e\U0001f34f\U0001f350\U0001f351\U0001f352\U0001f353\U0001f354\U0001f355\U0001f356\U0001f357\U0001f358\U0001f359\U0001f35a\U0001f35b\U0001f35c\U0001f35d\U0001f35e\U0001f35f\U0001f360\U0001f361\U0001f362\U0001f363\U0001f364\U0001f365\U0001f366\U0001f367\U0001f368\U0001f369\U0001f36a\U0001f36b\U0001f36c\U0001f36d\U0001f36e\U0001f36f\U0001f370\U0001f371\U0001f372\U0001f373\U0001f374\U0001f375\U0001f376\U0001f377\U0001f378\U0001f379\U0001f37a\U0001f37b\U0001f37c\U0001f380\U0001f381\U0001f382\U0001f383\U0001f384\U0001f385\U0001f386\U0001f387\U0001f388\U0001f389\U0001f38a\U0001f38b\U0001f38c\U0001f38d\U0001f38e\U0001f38f\U0001f390\U0001f391\U0001f392\U0001f393\U0001f3a0\U0001f3a1\U0001f3a2\U0001f3a3\U0001f3a4\U0001f3a5\U0001f3a6\U0001f3a7\U0001f3a8\U0001f3a9\U0001f3aa\U0001f3ab\U0001f3ac\U0001f3ad\U0001f3ae\U0001f3af\U0001f3b0\U0001f3b1\U0001f3b2\U0001f3b3\U0001f3b4\U0001f3b5\U0001f3b6\U0001f3b7\U0001f3b8\U0001f3b9\U0001f3ba\U0001f3bb\U0001f3bc\U0001f3bd\U0001f3be\U0001f3bf\U0001f3c0\U0001f3c1\U0001f3c2\U0001f3c3\U0001f3c4\U0001f3c6\U0001f3c7\U0001f3c8\U0001f3c9\U0001f3ca\U0001f3e0\U0001f3e1\U0001f3e2\U0001f3e3\U0001f3e4\U0001f3e5\U0001f3e6\U0001f3e7\U0001f3e8\U0001f3e9\U0001f3ea\U0001f3eb\U0001f3ec\U0001f3ed\U0001f3ee\U0001f3ef\U0001f3f0\U0001f400\U0001f401\U0001f402\U0001f403\U0001f404\U0001f405\U0001f406\U0001f407\U0001f408\U0001f409\U0001f40a\U0001f40b\U0001f40c\U0001f40d\U0001f40e\U0001f40f\U0001f410\U0001f411\U0001f412\U0001f413\U0001f414\U0001f415\U0001f416\U0001f417\U0001f418\U0001f419\U0001f41a\U0001f41b\U0001f41c\U0001f41d\U0001f41e\U0001f41f\U0001f420\U0001f421\U0001f422\U0001f423\U0001f424\U0001f425\U0001f426\U0001f427\U0001f428\U0001f429\U0001f42a\U0001f42b\U0001f42c\U0001f42d\U0001f42e\U0001f42f\U0001f430\U0001f431\U0001f432\U0001f433\U0001f434\U0001f435\U0001f436\U0001f437\U0001f438\U0001f439\U0001f43a\U0001f43b\U0001f43c\U0001f43d\U0001f43e\U0001f440\U0001f442\U0001f443\U0001f444\U0001f445\U0001f446\U0001f447\U0001f448\U0001f449\U0001f44a\U0001f44b\U0001f44c\U0001f44d\U0001f44e\U0001f44f\U0001f450\U0001f451\U0001f452\U0001f453\U0001f454\U0001f455\U0001f456\U0001f457\U0001f458\U0001f459\U0001f45a\U0001f45b\U0001f45c\U0001f45d\U0001f45e\U0001f45f\U0001f460\U0001f461\U0001f462\U0001f463\U0001f464\U0001f465\U0001f466\U0001f467\U0001f468\U0001f469\U0001f46a\U0001f46b\U0001f46c\U0001f46d\U0001f46e\U0001f46f\U0001f470\U0001f471\U0001f472\U0001f473\U0001f474\U0001f475\U0001f476\U0001f477\U0001f478\U0001f479\U0001f47a\U0001f47b\U0001f47c\U0001f47d\U0001f47e\U0001f47f\U0001f480\U0001f481\U0001f482\U0001f483\U0001f484\U0001f485\U0001f486\U0001f487\U0001f488\U0001f489\U0001f48a\U0001f48b\U0001f48c\U0001f48d\U0001f48e\U0001f48f\U0001f490\U0001f491\U0001f492\U0001f493\U0001f494\U0001f495\U0001f496\U0001f497\U0001f498\U0001f499\U0001f49a\U0001f49b\U0001f49c\U0001f49d\U0001f49e\U0001f49f\U0001f4a0\U0001f4a1\U0001f4a2\U0001f4a3\U0001f4a4\U0001f4a5\U0001f4a6\U0001f4a7\U0001f4a8\U0001f4a9\U0001f4aa\U0001f4ab\U0001f4ac\U0001f4ad\U0001f4ae\U0001f4af\U0001f4b0\U0001f4b1\U0001f4b2\U0001f4b3\U0001f4b4\U0001f4b5\U0001f4b6\U0001f4b7\U0001f4b8\U0001f4b9\U0001f4ba\U0001f4bb\U0001f4bc\U0001f4bd\U0001f4be\U0001f4bf\U0001f4c0\U0001f4c1\U0001f4c2\U0001f4c3\U0001f4c4\U0001f4c5\U0001f4c6\U0001f4c7\U0001f4c8\U0001f4c9\U0001f4ca\U0001f4cb\U0001f4cc\U0001f4cd\U0001f4ce\U0001f4cf\U0001f4d0\U0001f4d1\U0001f4d2\U0001f4d3\U0001f4d4\U0001f4d5\U0001f4d6\U0001f4d7\U0001f4d8\U0001f4d9\U0001f4da\U0001f4db\U0001f4dc\U0001f4dd\U0001f4de\U0001f4df\U0001f4e0\U0001f4e1\U0001f4e2\U0001f4e3\U0001f4e4\U0001f4e5\U0001f4e6\U0001f4e7\U0001f4e8\U0001f4e9\U0001f4ea\U0001f4eb\U0001f4ec\U0001f4ed\U0001f4ee\U0001f4ef\U0001f4f0\U0001f4f1\U0001f4f2\U0001f4f3\U0001f4f4\U0001f4f5\U0001f4f6\U0001f4f7\U0001f4f9\U0001f4fa\U0001f4fb\U0001f4fc\U0001f500\U0001f501\U0001f502\U0001f503\U0001f504\U0001f505\U0001f506\U0001f507\U0001f508\U0001f509\U0001f50a\U0001f50b\U0001f50c\U0001f50d\U0001f50e\U0001f50f\U0001f510\U0001f511\U0001f512\U0001f513\U0001f514\U0001f515\U0001f516\U0001f517\U0001f518\U0001f519\U0001f51a\U0001f51b\U0001f51c\U0001f51d\U0001f51e\U0001f51f\U0001f520\U0001f521\U0001f522\U0001f523\U0001f524\U0001f525\U0001f526\U0001f527\U0001f528\U0001f529\U0001f52a\U0001f52b\U0001f52c\U0001f52d\U0001f52e\U0001f52f\U0001f530\U0001f531\U0001f532\U0001f533\U0001f534\U0001f535\U0001f536\U0001f537\U0001f538\U0001f539\U0001f53a\U0001f53b\U0001f53c\U0001f53d\U0001f550\U0001f551\U0001f552\U0001f553\U0001f554\U0001f555\U0001f556\U0001f557\U0001f558\U0001f559\U0001f55a\U0001f55b\U0001f55c\U0001f55d\U0001f55e\U0001f55f\U0001f560\U0001f561\U0001f562\U0001f563\U0001f564\U0001f565\U0001f566\U0001f567\U0001f5fb\U0001f5fc\U0001f5fd\U0001f5fe\U0001f5ff\U0001f600\U0001f601\U0001f602\U0001f603\U0001f604\U0001f605\U0001f606\U0001f607\U0001f608\U0001f609\U0001f60a\U0001f60b\U0001f60c\U0001f60d\U0001f60e\U0001f60f\U0001f610\U0001f611\U0001f612\U0001f613\U0001f614\U0001f615\U0001f616\U0001f617\U0001f618\U0001f619\U0001f61a\U0001f61b\U0001f61c\U0001f61d\U0001f61e\U0001f61f\U0001f620\U0001f621\U0001f622\U0001f623\U0001f624\U0001f625\U0001f626\U0001f627\U0001f628\U0001f629\U0001f62a\U0001f62b\U0001f62c\U0001f62d\U0001f62e\U0001f62f\U0001f630\U0001f631\U0001f632\U0001f633\U0001f634\U0001f635\U0001f636\U0001f637\U0001f638\U0001f639\U0001f63a\U0001f63b\U0001f63c\U0001f63d\U0001f63e\U0001f63f\U0001f640\U0001f645\U0001f646\U0001f647\U0001f648\U0001f649\U0001f64a\U0001f64b\U0001f64c\U0001f64d\U0001f64e\U0001f64f\U0001f680\U0001f681\U0001f682\U0001f683\U0001f684\U0001f685\U0001f686\U0001f687\U0001f688\U0001f689\U0001f68a\U0001f68b\U0001f68c\U0001f68d\U0001f68e\U0001f68f\U0001f690\U0001f691\U0001f692\U0001f693\U0001f694\U0001f695\U0001f696\U0001f697\U0001f698\U0001f699\U0001f69a\U0001f69b\U0001f69c\U0001f69d\U0001f69e\U0001f69f\U0001f6a0\U0001f6a1\U0001f6a2\U0001f6a3\U0001f6a4\U0001f6a5\U0001f6a6\U0001f6a7\U0001f6a8\U0001f6a9\U0001f6aa\U0001f6ab\U0001f6ac\U0001f6ad\U0001f6ae\U0001f6af\U0001f6b0\U0001f6b1\U0001f6b2\U0001f6b3\U0001f6b4\U0001f6b5\U0001f6b6\U0001f6b7\U0001f6b8\U0001f6b9\U0001f6ba\U0001f6bb\U0001f6bc\U0001f6bd\U0001f6be\U0001f6bf\U0001f6c0\U0001f6c1\U0001f6c2\U0001f6c3\U0001f6c4\U0001f6c5"];
        
        maxSet = minSetOld.mutableCopy;
        [maxSet addCharactersInRange:NSMakeRange(0x20e3, 1)]; // Combining Enclosing Keycap (multi-face emoji)
        [maxSet addCharactersInRange:NSMakeRange(0xfe0f, 1)]; // Variation Selector
        [maxSet addCharactersInRange:NSMakeRange(0x1f1e6, 26)]; // Regional Indicator Symbol Letter
        
        minSet8_3 = minSetOld.mutableCopy;
        [minSet8_3 addCharactersInRange:NSMakeRange(0x1f3fb, 5)]; // Color of skin
    });
    
    // 1. Most of string does not contains emoji, so test the maximum range of charset first.
    if ([self rangeOfCharacterFromSet:maxSet].location == NSNotFound) return NO;
    
    // 2. If the emoji can be detected by the minimum charset, return 'YES' directly.
    if ([self rangeOfCharacterFromSet:((systemVersion < 8.3) ? minSetOld : minSet8_3)].location != NSNotFound) return YES;
    
    // 3. The string contains some characters which may compose an emoji, but cannot detected with charset.
    // Use a regular expression to detect the emoji. It's slower than using charset.
    static NSRegularExpression *regexOld, *regex8_3, *regex9_0;
    static dispatch_once_t onceTokenRegex;
    dispatch_once(&onceTokenRegex, ^{
        regexOld = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇨🇳|🇩🇪|🇪🇸|🇫🇷|🇬🇧|🇮🇹|🇯🇵|🇰🇷|🇷🇺|🇺🇸)" options:kNilOptions error:nil];
        regex8_3 = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇦🇺|🇦🇹|🇧🇪|🇧🇷|🇨🇦|🇨🇱|🇨🇳|🇨🇴|🇩🇰|🇫🇮|🇫🇷|🇩🇪|🇭🇰|🇮🇳|🇮🇩|🇮🇪|🇮🇱|🇮🇹|🇯🇵|🇰🇷|🇲🇴|🇲🇾|🇲🇽|🇳🇱|🇳🇿|🇳🇴|🇵🇭|🇵🇱|🇵🇹|🇵🇷|🇷🇺|🇸🇦|🇸🇬|🇿🇦|🇪🇸|🇸🇪|🇨🇭|🇹🇷|🇬🇧|🇺🇸|🇦🇪|🇻🇳)" options:kNilOptions error:nil];
        regex9_0 = [NSRegularExpression regularExpressionWithPattern:@"(©️|®️|™️|〰️|🇦🇫|🇦🇽|🇦🇱|🇩🇿|🇦🇸|🇦🇩|🇦🇴|🇦🇮|🇦🇶|🇦🇬|🇦🇷|🇦🇲|🇦🇼|🇦🇺|🇦🇹|🇦🇿|🇧🇸|🇧🇭|🇧🇩|🇧🇧|🇧🇾|🇧🇪|🇧🇿|🇧🇯|🇧🇲|🇧🇹|🇧🇴|🇧🇶|🇧🇦|🇧🇼|🇧🇻|🇧🇷|🇮🇴|🇻🇬|🇧🇳|🇧🇬|🇧🇫|🇧🇮|🇰🇭|🇨🇲|🇨🇦|🇨🇻|🇰🇾|🇨🇫|🇹🇩|🇨🇱|🇨🇳|🇨🇽|🇨🇨|🇨🇴|🇰🇲|🇨🇬|🇨🇩|🇨🇰|🇨🇷|🇨🇮|🇭🇷|🇨🇺|🇨🇼|🇨🇾|🇨🇿|🇩🇰|🇩🇯|🇩🇲|🇩🇴|🇪🇨|🇪🇬|🇸🇻|🇬🇶|🇪🇷|🇪🇪|🇪🇹|🇫🇰|🇫🇴|🇫🇯|🇫🇮|🇫🇷|🇬🇫|🇵🇫|🇹🇫|🇬🇦|🇬🇲|🇬🇪|🇩🇪|🇬🇭|🇬🇮|🇬🇷|🇬🇱|🇬🇩|🇬🇵|🇬🇺|🇬🇹|🇬🇬|🇬🇳|🇬🇼|🇬🇾|🇭🇹|🇭🇲|🇭🇳|🇭🇰|🇭🇺|🇮🇸|🇮🇳|🇮🇩|🇮🇷|🇮🇶|🇮🇪|🇮🇲|🇮🇱|🇮🇹|🇯🇲|🇯🇵|🇯🇪|🇯🇴|🇰🇿|🇰🇪|🇰🇮|🇰🇼|🇰🇬|🇱🇦|🇱🇻|🇱🇧|🇱🇸|🇱🇷|🇱🇾|🇱🇮|🇱🇹|🇱🇺|🇲🇴|🇲🇰|🇲🇬|🇲🇼|🇲🇾|🇲🇻|🇲🇱|🇲🇹|🇲🇭|🇲🇶|🇲🇷|🇲🇺|🇾🇹|🇲🇽|🇫🇲|🇲🇩|🇲🇨|🇲🇳|🇲🇪|🇲🇸|🇲🇦|🇲🇿|🇲🇲|🇳🇦|🇳🇷|🇳🇵|🇳🇱|🇳🇨|🇳🇿|🇳🇮|🇳🇪|🇳🇬|🇳🇺|🇳🇫|🇲🇵|🇰🇵|🇳🇴|🇴🇲|🇵🇰|🇵🇼|🇵🇸|🇵🇦|🇵🇬|🇵🇾|🇵🇪|🇵🇭|🇵🇳|🇵🇱|🇵🇹|🇵🇷|🇶🇦|🇷🇪|🇷🇴|🇷🇺|🇷🇼|🇧🇱|🇸🇭|🇰🇳|🇱🇨|🇲🇫|🇻🇨|🇼🇸|🇸🇲|🇸🇹|🇸🇦|🇸🇳|🇷🇸|🇸🇨|🇸🇱|🇸🇬|🇸🇰|🇸🇮|🇸🇧|🇸🇴|🇿🇦|🇬🇸|🇰🇷|🇸🇸|🇪🇸|🇱🇰|🇸🇩|🇸🇷|🇸🇯|🇸🇿|🇸🇪|🇨🇭|🇸🇾|🇹🇼|🇹🇯|🇹🇿|🇹🇭|🇹🇱|🇹🇬|🇹🇰|🇹🇴|🇹🇹|🇹🇳|🇹🇷|🇹🇲|🇹🇨|🇹🇻|🇺🇬|🇺🇦|🇦🇪|🇬🇧|🇺🇸|🇺🇲|🇻🇮|🇺🇾|🇺🇿|🇻🇺|🇻🇦|🇻🇪|🇻🇳|🇼🇫|🇪🇭|🇾🇪|🇿🇲|🇿🇼)" options:kNilOptions error:nil];
    });
    
    NSRange regexRange = [(systemVersion < 8.3 ? regexOld : systemVersion < 9.0 ? regex8_3 : regex9_0) rangeOfFirstMatchInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    return regexRange.location != NSNotFound;
}

//@TODO:删除字符串中包含的Emoji
- (NSString *)jl_removedEmojiString
{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring jl_containsEmoji])? @"": substring];
                          }];
    
    return buffer;
}

#pragma mark - MIME
//@TODO:根据文件url 返回对应的MIMEType
- (NSString *)jl_MIMEType
{
    return [[self class] jl_MIMETypeForExtension:[self pathExtension]];
}

//@TODO:根据文件url后缀 返回对应的MIMEType
+ (NSString *)jl_MIMETypeForExtension:(NSString *)extension
{
    return [[self jl_MIMEDict] valueForKey:[extension lowercaseString]];
}

//@TODO:常见MIME集合
+ (NSDictionary *)jl_MIMEDict
{
    NSDictionary * MIMEDict;
    // Lazy loads the MIME type dictionary.
    if (!MIMEDict) {
        
        // ???: Should I have these return an array of MIME types? The first element would be the preferred MIME type.
        
        // ???: Should I have a couple methods that return the MIME media type name and the MIME subtype name?
        
        // Values from http://www.w3schools.com/media/media_mimeref.asp
        // There are probably values missed, but this is a good start.
        // A few more have been added that weren't included on the original list.
        MIMEDict = [NSDictionary dictionaryWithObjectsAndKeys:
                    // Key      // Value
                    @"",        @"application/octet-stream",
                    @"323",     @"text/h323",
                    @"acx",     @"application/internet-property-stream",
                    @"ai",      @"application/postscript",
                    @"aif",     @"audio/x-aiff",
                    @"aifc",    @"audio/x-aiff",
                    @"aiff",    @"audio/x-aiff",
                    @"asf",     @"video/x-ms-asf",
                    @"asr",     @"video/x-ms-asf",
                    @"asx",     @"video/x-ms-asf",
                    @"au",      @"audio/basic",
                    @"avi",     @"video/x-msvideo",
                    @"axs",     @"application/olescript",
                    @"bas",     @"text/plain",
                    @"bcpio",   @"application/x-bcpio",
                    @"bin",     @"application/octet-stream",
                    @"bmp",     @"image/bmp",
                    @"c",       @"text/plain",
                    @"cat",     @"application/vnd.ms-pkiseccat",
                    @"cdf",     @"application/x-cdf",
                    @"cer",     @"application/x-x509-ca-cert",
                    @"class",   @"application/octet-stream",
                    @"clp",     @"application/x-msclip",
                    @"cmx",     @"image/x-cmx",
                    @"cod",     @"image/cis-cod",
                    @"cpio",    @"application/x-cpio",
                    @"crd",     @"application/x-mscardfile",
                    @"crl",     @"application/pkix-crl",
                    @"crt",     @"application/x-x509-ca-cert",
                    @"csh",     @"application/x-csh",
                    @"css",     @"text/css",
                    @"dcr",     @"application/x-director",
                    @"der",     @"application/x-x509-ca-cert",
                    @"dir",     @"application/x-director",
                    @"dll",     @"application/x-msdownload",
                    @"dms",     @"application/octet-stream",
                    @"doc",     @"application/msword",
                    @"docx",    @"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                    @"dot",     @"application/msword",
                    @"dvi",     @"application/x-dvi",
                    @"dxr",     @"application/x-director",
                    @"eps",     @"application/postscript",
                    @"etx",     @"text/x-setext",
                    @"evy",     @"application/envoy",
                    @"exe",     @"application/octet-stream",
                    @"fif",     @"application/fractals",
                    @"flr",     @"x-world/x-vrml",
                    @"gif",     @"image/gif",
                    @"gtar",    @"application/x-gtar",
                    @"gz",      @"application/x-gzip",
                    @"h",       @"text/plain",
                    @"hdf",     @"application/x-hdf",
                    @"hlp",     @"application/winhlp",
                    @"hqx",     @"application/mac-binhex40",
                    @"hta",     @"application/hta",
                    @"htc",     @"text/x-component",
                    @"htm",     @"text/html",
                    @"html",    @"text/html",
                    @"htt",     @"text/webviewhtml",
                    @"ico",     @"image/x-icon",
                    @"ief",     @"image/ief",
                    @"iii",     @"application/x-iphone",
                    @"ins",     @"application/x-internet-signup",
                    @"isp",     @"application/x-internet-signup",
                    @"jfif",    @"image/pipeg",
                    @"jpe",     @"image/jpeg",
                    @"jpeg",    @"image/jpeg",
                    @"jpg",     @"image/jpeg",
                    @"js",      @"application/x-javascript",
                    @"json",    @"application/json",   // According to RFC 4627  // Also application/x-javascript text/javascript text/x-javascript text/x-json
                    @"latex",   @"application/x-latex",
                    @"lha",     @"application/octet-stream",
                    @"lsf",     @"video/x-la-asf",
                    @"lsx",     @"video/x-la-asf",
                    @"lzh",     @"application/octet-stream",
                    @"m",       @"text/plain",
                    @"m13",     @"application/x-msmediaview",
                    @"m14",     @"application/x-msmediaview",
                    @"m3u",     @"audio/x-mpegurl",
                    @"man",     @"application/x-troff-man",
                    @"mdb",     @"application/x-msaccess",
                    @"me",      @"application/x-troff-me",
                    @"mht",     @"message/rfc822",
                    @"mhtml",   @"message/rfc822",
                    @"mid",     @"audio/mid",
                    @"mny",     @"application/x-msmoney",
                    @"mov",     @"video/quicktime",
                    @"movie",   @"video/x-sgi-movie",
                    @"mp2",     @"video/mpeg",
                    @"mp3",     @"audio/mpeg",
                    @"mpa",     @"video/mpeg",
                    @"mpe",     @"video/mpeg",
                    @"mpeg",    @"video/mpeg",
                    @"mpg",     @"video/mpeg",
                    @"mpp",     @"application/vnd.ms-project",
                    @"mpv2",    @"video/mpeg",
                    @"ms",      @"application/x-troff-ms",
                    @"mvb",     @"	application/x-msmediaview",
                    @"nws",     @"message/rfc822",
                    @"oda",     @"application/oda",
                    @"p10",     @"application/pkcs10",
                    @"p12",     @"application/x-pkcs12",
                    @"p7b",     @"application/x-pkcs7-certificates",
                    @"p7c",     @"application/x-pkcs7-mime",
                    @"p7m",     @"application/x-pkcs7-mime",
                    @"p7r",     @"application/x-pkcs7-certreqresp",
                    @"p7s",     @"	application/x-pkcs7-signature",
                    @"pbm",     @"image/x-portable-bitmap",
                    @"pdf",     @"application/pdf",
                    @"pfx",     @"application/x-pkcs12",
                    @"pgm",     @"image/x-portable-graymap",
                    @"pko",     @"application/ynd.ms-pkipko",
                    @"pma",     @"application/x-perfmon",
                    @"pmc",     @"application/x-perfmon",
                    @"pml",     @"application/x-perfmon",
                    @"pmr",     @"application/x-perfmon",
                    @"pmw",     @"application/x-perfmon",
                    @"png",     @"image/png",
                    @"pnm",     @"image/x-portable-anymap",
                    @"pot",     @"application/vnd.ms-powerpoint",
                    @"vppm",    @"image/x-portable-pixmap",
                    @"pps",     @"application/vnd.ms-powerpoint",
                    @"ppt",     @"application/vnd.ms-powerpoint",
                    @"pptx",    @"application/vnd.openxmlformats-officedocument.presentationml.presentation",
                    @"prf",     @"application/pics-rules",
                    @"ps",      @"application/postscript",
                    @"pub",     @"application/x-mspublisher",
                    @"qt",      @"video/quicktime",
                    @"ra",      @"audio/x-pn-realaudio",
                    @"ram",     @"audio/x-pn-realaudio",
                    @"ras",     @"image/x-cmu-raster",
                    @"rgb",     @"image/x-rgb",
                    @"rmi",     @"audio/mid",
                    @"roff",    @"application/x-troff",
                    @"rtf",     @"application/rtf",
                    @"rtx",     @"text/richtext",
                    @"scd",     @"application/x-msschedule",
                    @"sct",     @"text/scriptlet",
                    @"setpay",  @"application/set-payment-initiation",
                    @"setreg",  @"application/set-registration-initiation",
                    @"sh",      @"application/x-sh",
                    @"shar",    @"application/x-shar",
                    @"sit",     @"application/x-stuffit",
                    @"snd",     @"audio/basic",
                    @"spc",     @"application/x-pkcs7-certificates",
                    @"spl",     @"application/futuresplash",
                    @"src",     @"application/x-wais-source",
                    @"sst",     @"application/vnd.ms-pkicertstore",
                    @"stl",     @"application/vnd.ms-pkistl",
                    @"stm",     @"text/html",
                    @"svg",     @"image/svg+xml",
                    @"sv4cpio", @"application/x-sv4cpio",
                    @"sv4crc",  @"application/x-sv4crc",
                    @"swf",     @"application/x-shockwave-flash",
                    @"t",       @"application/x-troff",
                    @"tar",     @"application/x-tar",
                    @"tcl",     @"application/x-tcl",
                    @"tex",     @"application/x-tex",
                    @"texi",    @"application/x-texinfo",
                    @"texinfo", @"application/x-texinfo",
                    @"tgz",     @"application/x-compressed",
                    @"tif",     @"image/tiff",
                    @"tiff",    @"image/tiff",
                    @"tr",      @"application/x-troff",
                    @"trm",     @"application/x-msterminal",
                    @"tsv",     @"text/tab-separated-values",
                    @"txt",     @"text/plain",
                    @"uls",     @"text/iuls",
                    @"ustar",   @"application/x-ustar",
                    @"vcf",     @"text/x-vcard",
                    @"vrml",    @"x-world/x-vrml",
                    @"wav",     @"audio/x-wav",
                    @"wcm",     @"application/vnd.ms-works",
                    @"wdb",     @"application/vnd.ms-works",
                    @"wks",     @"application/vnd.ms-works",
                    @"wmf",     @"application/x-msmetafile",
                    @"wps",     @"application/vnd.ms-works",
                    @"wri",     @"application/x-mswrite",
                    @"wrl",     @"x-world/x-vrml",
                    @"wrz",     @"x-world/x-vrml",
                    @"xaf",     @"x-world/x-vrml",
                    @"xbm",     @"image/x-xbitmap",
                    @"xla",     @"application/vnd.ms-excel",
                    @"xlc",     @"application/vnd.ms-excel",
                    @"xlm",     @"application/vnd.ms-excel",
                    @"xls",     @"application/vnd.ms-excel",
                    @"xlsx",    @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    @"xlt",     @"application/vnd.ms-excel",
                    @"xlw",     @"application/vnd.ms-excel",
                    @"xml",     @"text/xml",   // According to RFC 3023   // Also application/xml
                    @"xof",     @"x-world/x-vrml",
                    @"xpm",     @"image/x-xpixmap",
                    @"xwd",     @"image/x-xwindowdump",
                    @"z",       @"application/x-compress",
                    @"zip",     @"application/zip",
                    nil];
    }
    
    return MIMEDict;
}

#pragma mark - 类型转换
//@TODO:NSInteger型转为字符串
+ (NSString *)jl_stringWithIntegerValue:(NSInteger)value
{
#if TARGET_OS_IPHONE
    return [self stringWithFormat:@"%ld", (long)value];
#else
    return [self stringWithFormat:@"%ld", value];
#endif
}

//@TODO:CGFloat型转为小数点后places位的字符串
+ (NSString *)jl_stringWithFloatValue:(CGFloat)value places:(NSInteger)places
{
#if TARGET_OS_IPHONE
    NSString *format = [self stringWithFormat:@"%%.%ldf", (long)places];
#else
    NSString *format = [self stringWithFormat:@"%%.%ldf", places];
#endif
    
    return [self stringWithFormat:format, value];
}

//@TODO:
+ (NSString *)jl_stringWithTruncatedFloatValue:(CGFloat)value
{
    NSMutableString *mutie = [[self stringWithFormat:@"%f", value] mutableCopy];
    
    while ([mutie hasSuffix:@"0"])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    if ([mutie hasSuffix:@"."])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    return mutie;
}

//@TODO:
+ (NSString *)jl_stringWithFloatValue:(CGFloat)value
                                 zero:(NSString *)zero
                             singluar:(NSString *)singular
                               plural:(NSString *)plural;
{
    if (!value && zero)
        return zero;
    else if ((value == 1.0 || value == -1.0) && singular)
        return singular;
    else
        return plural;
}

//@TODO:Unicode编码的字符串转成NSString
- (NSString *)jl_makeUnicodeToString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (char)charValue
{
    return self.jl_numberValue.charValue;
}

- (unsigned char)unsignedCharValue
{
    return self.jl_numberValue.unsignedCharValue;
}

- (short)shortValue
{
    return self.jl_numberValue.shortValue;
}

- (unsigned short)unsignedShortValue
{
    return self.jl_numberValue.unsignedShortValue;
}

- (unsigned int)unsignedIntValue
{
    return self.jl_numberValue.unsignedIntValue;
}

- (long)longValue
{
    return self.jl_numberValue.longValue;
}

- (unsigned long)unsignedLongValue
{
    return self.jl_numberValue.unsignedLongValue;
}

- (unsigned long long)unsignedLongLongValue
{
    return self.jl_numberValue.unsignedLongLongValue;
}

- (NSUInteger)unsignedIntegerValue
{
    return self.jl_numberValue.unsignedIntegerValue;
}

//@TODO:NSString转NSNumber
- (NSNumber *)jl_numberValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [numberFormatter numberFromString:self];
}

//@TODO:NSString转NSData
- (NSData *)jl_dataValue
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

//@TODO:NSString转NSData[针对特殊编码]
- (NSData *)jl_dataValueWithEncoding:(NSStringEncoding)encoding
{
    NSData *data = [self dataUsingEncoding:encoding];
    return data;
}

//@TODO:NSString转Byte集合
- (Byte *)jl_Byte
{
    Byte *byte = (Byte *)[[self jl_dataValue] bytes];
    return byte;
}

//@TODO:NSString转Byte集合[针对特殊编码]
- (Byte *)jl_byteWithEncoding:(NSStringEncoding)encoding
{
    Byte *byte = (Byte *)[[self jl_dataValueWithEncoding:encoding] bytes];
    return byte;
}

//@TODO:获得NSString的NSRange
- (NSRange)jl_rangeOfAll
{
    return NSMakeRange(0, self.length);
}

#pragma mark - 字符串处理
//@TODO:是否包含中文
- (BOOL)jl_isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

//@TODO:字符串中是否包含另一个字符串
- (BOOL)jl_containsaString:(NSString *)string
{
    NSRange rang = [self rangeOfString:string];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

//@TODO:是否包含空格
- (BOOL)jl_isContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//@TODO:判断字符串是否全为数字 不能包含小数点这些
-(BOOL)jl_isPureNumandCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }else{
        return YES;
    }
}
//@TODO:判断字符串是否为浮点型
- (BOOL)jl_isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

//@TODO:判断是否是正确的身份证号
- (BOOL)jl_validateIdentityCard:(NSString *)identityCard
{
    NSString *pattern = @"(^(\\d{6})(18|19|20)?(\\d{2})([01]\\d)([0123]\\d)(\\d{3})(\\d|[xX])?$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCard];
    return isMatch;
}

//@TODO:字符串去空格
- (NSString *)jl_stringByTrim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

//@TODO:去除字符串与空行
- (NSString *)jl_trimmingWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//@TODO:清除html标签
- (NSString *)jl_stringByStrippingHTML
{
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

//@TODO:清除js脚本
- (NSString *)jl_stringByRemovingScriptsAndStrippingHTML
{
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString jl_stringByStrippingHTML];
}

//@TODO:获取字符数量
- (int)jl_wordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++)
    {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}
//@TODO:截取字符串中的对应字节数字符
- (NSString *)jl_cutByteBytesCount:(int)count
{
    if (self.length == 0) return self;
    
    int k = 0;
    int j = 0;
    
    for(int i=0; i< [self length];i++){
        NSRange range = NSMakeRange(i, 1);
        
        NSString *subStr = [self substringWithRange:range];
        
        const char * cString = [subStr UTF8String];
        
        if (strlen(cString) == 3) {
            if (k+2 > count) {
                break;
            } else {
                k += 2;
            }
        } else {
            if (k+1 > count) {
                break;
            } else {
                k += 1;
            }
            
        }
        j = i;
    }
    
    NSString *newStr = [self substringWithRange:NSMakeRange(0, j + 1)];return newStr;
}
//@TODO:将电话号码中间4位变为*号
- (NSString *)jl_changeMobileNumber
{
    NSMutableString *phoneText = [NSMutableString string];
    [phoneText appendString:self];
    [phoneText replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return [phoneText copy];
}

#pragma mark - UUID(唯一性验证)
//@TODO:获取随机 UUID
+ (NSString *)jl_stringWithUUID
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)
    {
        return  [[NSUUID UUID] UUIDString];
    }
    else
    {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        return (__bridge_transfer NSString *)uuid;
    }
}

//@TODO:毫秒时间戳
+ (NSString *)jl_UUIDTimestamp
{
    return  [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]*1000] stringValue];
}

#pragma mark - 通过文件资源获取字符串
//@TODO:通过文件名获取字符串
+ (NSString *)jl_stringWithNamed:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

#pragma mark - NSAttributedString
//@TODO:NSString 转 NSMutableAttributedString
+ (NSMutableAttributedString *)jl_attributedStringWithStrings:(NSArray <NSString *> *)strings fonts:(NSArray <UIFont *> *)fonts colours:(NSArray <UIColor *> *)colours
{
    NSAssert(fonts.count > 0 && colours.count > 0, @"Attributes arrays must contain at least one default object");
    
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    
    for(NSString *string in strings) {
        
        NSInteger index = [strings indexOfObject:string];
        UIFont *font = fonts.count > index ? [fonts objectAtIndex:index] : [fonts firstObject];
        UIColor *colour = colours.count > index ? [colours objectAtIndex:index] : [colours firstObject];
        NSDictionary *attributes = @{NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : colour};
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        
        [str appendAttributedString:attrStr];
    }
    
    return str;
}

//@TODO:返回attributedString基础的font、color属性字典
+ (NSDictionary *)jl_attributedTextDicWithFont:(UIFont *)font color:(UIColor *)color
{
    return @{
             NSFontAttributeName : font,
             NSForegroundColorAttributeName : color
             };
}


@end
