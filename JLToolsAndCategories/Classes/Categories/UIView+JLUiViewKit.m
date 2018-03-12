//
//  UIView+JLUiViewKit.m
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "UIView+JLUiViewKit.h"
#import <QuartzCore/QuartzCore.h>

#pragma GCC diagnostic ignored "-Wgnu"

@implementation UIView (JLUiViewKit)

#pragma mark - 加载、初始化视图
//@TODO:nib loading
+ (id)jl_instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner
{
    //default values
    NSString *nibName = nibNameOrNil ?: NSStringFromClass(self);
    NSBundle *bundle = bundleOrNil ?: [NSBundle mainBundle];
    
    //cache nib to prevent unnecessary filesystem access
    static NSCache *nibCache = nil;
    if (nibCache == nil)
    {
        nibCache = [[NSCache alloc] init];
    }
    NSString *pathKey = [NSString stringWithFormat:@"%@.%@", bundle.bundleIdentifier, nibName];
    UINib *nib = [nibCache objectForKey:pathKey];
    if (nib == nil)
    {
        NSString *nibPath = [bundle pathForResource:nibName ofType:@"nib"];
        if (nibPath) nib = [UINib nibWithNibName:nibName bundle:bundle];
        [nibCache setObject:nib ?: [NSNull null] forKey:pathKey];
    }
    else if ([nib isKindOfClass:[NSNull class]])
    {
        nib = nil;
    }
    
    if (nib)
    {
        //attempt to load from nib
        NSArray *contents = [nib instantiateWithOwner:owner options:nil];
        UIView *view = [contents count]? [contents objectAtIndex:0]: nil;
        NSAssert ([view isKindOfClass:self], @"First object in nib '%@' was '%@'. Expected '%@'", nibName, view, self);
        return view;
    }
    
    //return empty view
    return [[[self class] alloc] init];
}
//@TODO:
- (void)jl_loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil
{
    NSString *nibName = nibNameOrNil ?: NSStringFromClass([self class]);
    UIView *view = [UIView jl_instanceWithNibName:nibName bundle:bundleOrNil owner:self];
    if (view)
    {
        if (CGSizeEqualToSize(self.frame.size, CGSizeZero))
        {
            //if we have zero size, set size from content
            self.jl_size = view.jl_size;
        }
        else
        {
            //otherwise set content size to match our size
            view.frame = self.jl_contentBounds;
        }
        [self addSubview:view];
    }
}

#pragma mark - 获取self视图中符合条件的view或者view数组
- (UIView *)jl_viewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    for (UIView *view in self.subviews)
    {
        UIView *match = [view jl_viewMatchingPredicate:predicate];
        if (match) return match;
    }
    return nil;
}

- (UIView *)jl_viewWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self jl_viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (UIView *)jl_viewOfClass:(Class)viewClass
{
    return [self jl_viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (NSArray *)jl_viewsMatchingPredicate:(NSPredicate *)predicate
{
    NSMutableArray *matches = [NSMutableArray array];
    if ([predicate evaluateWithObject:self])
    {
        [matches addObject:self];
    }
    for (UIView *view in self.subviews)
    {
        //check for subviews
        //avoid creating unnecessary array
        if ([view.subviews count])
        {
            [matches addObjectsFromArray:[view jl_viewsMatchingPredicate:predicate]];
        }
        else if ([predicate evaluateWithObject:view])
        {
            [matches addObject:view];
        }
    }
    return matches;
}

- (NSArray *)jl_viewsWithTag:(NSInteger)tag
{
    return [self jl_viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag;
    }]];
}

- (NSArray *)jl_viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self jl_viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject tag] == tag && [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (NSArray *)jl_viewsOfClass:(Class)viewClass
{
    return [self jl_viewsMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (UIView *)jl_firstSuperviewMatchingPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return self;
    }
    return [self.superview jl_firstSuperviewMatchingPredicate:predicate];
}

- (UIView *)jl_firstSuperviewOfClass:(Class)viewClass
{
    return [self jl_firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (UIView *)jl_firstSuperviewWithTag:(NSInteger)tag
{
    return [self jl_firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag;
    }]];
}

- (UIView *)jl_firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass
{
    return [self jl_firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview.tag == tag && [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)jl_viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate
{
    if ([predicate evaluateWithObject:self])
    {
        return YES;
    }
    return [self.superview jl_viewOrAnySuperviewMatchesPredicate:predicate];
}

- (BOOL)jl_viewOrAnySuperviewIsKindOfClass:(Class)viewClass
{
    return [self jl_viewOrAnySuperviewMatchesPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return [superview isKindOfClass:viewClass];
    }]];
}

- (BOOL)jl_isSuperviewOfView:(UIView *)view
{
    return [self jl_firstSuperviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIView *superview, __unused id bindings) {
        return superview == view;
    }]] != nil;
}

- (BOOL)jl_isSubviewOfView:(UIView *)view
{
    return [view jl_isSuperviewOfView:self];
}

//响应链
- (UIViewController *)jl_firstViewController
{
    id responder = self;
    while ((responder = [responder nextResponder]))
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
    }
    return nil;
}

- (UIView *)jl_firstResponder
{
    return [self jl_viewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isFirstResponder];
    }]];
}

#pragma mark - frame 相关属性
- (CGPoint)jl_origin
{
    return self.frame.origin;
}

-(void)setJl_origin:(CGPoint)jl_origin
{
    CGRect frame = self.frame;
    frame.origin = jl_origin;
    self.frame = frame;
}

- (CGSize)jl_size
{
    return self.frame.size;
}

- (void)setJl_size:(CGSize)jl_size
{
    CGRect frame = self.frame;
    frame.size = jl_size;
    self.frame = frame;
}

- (CGFloat)jl_top
{
    return self.jl_origin.y;
}

- (void)setJl_top:(CGFloat)jl_top
{
    CGRect frame = self.frame;
    frame.origin.y = jl_top;
    self.frame = frame;
}

- (CGFloat)jl_left
{
    return self.jl_origin.x;
}

- (void)setJl_left:(CGFloat)jl_left
{
    CGRect frame = self.frame;
    frame.origin.x = jl_left;
    self.frame = frame;
}

- (CGFloat)jl_right
{
    return self.jl_left + self.jl_width;
}

- (void)setJl_right:(CGFloat)jl_right
{
    CGRect frame = self.frame;
    frame.origin.x = jl_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)jl_bottom
{
    return self.jl_top + self.jl_height;
}

- (void)setJl_bottom:(CGFloat)jl_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = jl_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)jl_width
{
    return self.jl_size.width;
}

- (void)setJl_width:(CGFloat)jl_width
{
    CGRect frame = self.frame;
    frame.size.width = jl_width;
    self.frame = frame;
}

- (CGFloat)jl_height
{
    return self.jl_size.height;
}

- (void)setJl_height:(CGFloat)jl_height
{
    CGRect frame = self.frame;
    frame.size.height = jl_height;
    self.frame = frame;
}

- (CGFloat)jl_x
{
    return self.jl_origin.x;
}

- (void)setJl_x:(CGFloat)jl_x
{
    self.center = CGPointMake(jl_x, self.center.y);
}

- (CGFloat)jl_y
{
    return self.jl_origin.y;
}

- (void)setJl_y:(CGFloat)jl_y
{
    self.center = CGPointMake(self.center.x, jl_y);
}

- (CGFloat)jl_centerX
{
    return self.center.x;
}

- (void)setJl_centerX:(CGFloat)jl_centerX
{
    self.center = CGPointMake(jl_centerX, self.center.y);
}

- (CGFloat)jl_centerY
{
    return self.center.y;
}

- (void)setJl_centerY:(CGFloat)jl_centerY
{
    self.center = CGPointMake(self.center.x, jl_centerY);
}

#pragma mark - bounds 相关属性
- (CGSize)jl_boundsSize
{
    return self.bounds.size;
}

- (void)setJl_boundsSize:(CGSize)jl_boundsSize
{
    CGRect bounds = self.bounds;
    bounds.size = jl_boundsSize;
    self.bounds = bounds;
}

- (CGFloat)jl_boundsWidth
{
    return self.jl_boundsSize.width;
}

- (void)setJl_boundsWidth:(CGFloat)jl_boundsWidth
{
    CGRect bounds = self.bounds;
    bounds.size.width = jl_boundsWidth;
    self.bounds = bounds;
}

- (CGFloat)jl_boundsHeight
{
    return self.jl_boundsSize.height;
}

- (void)setJl_boundsHeight:(CGFloat)jl_boundsHeight
{
    CGRect bounds = self.bounds;
    bounds.size.height = jl_boundsHeight;
    self.bounds = bounds;
}

#pragma mark - content get方法
- (CGRect)jl_contentBounds
{
    return CGRectMake(0.0f, 0.0f, self.jl_boundsWidth, self.jl_boundsHeight);
}

- (CGPoint)jl_contentCenter
{
    return CGPointMake(self.jl_boundsWidth/2.0f, self.jl_boundsHeight/2.0f);
}

#pragma mark - 根据给定的条件变化view的frame
- (void)jl_setLeft:(CGFloat)left right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = right - left;
    self.frame = frame;
}

- (void)jl_setWidth:(CGFloat)width right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - width;
    frame.size.width = width;
    self.frame = frame;
}

- (void)jl_setTop:(CGFloat)top bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (void)jl_setHeight:(CGFloat)height bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - height;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - animation
- (void)jl_crossfadeWithDuration:(NSTimeInterval)duration
{
    //jump through a few hoops to avoid QuartzCore framework dependency
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)jl_crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion
{
    [self jl_crossfadeWithDuration:duration];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

@end
