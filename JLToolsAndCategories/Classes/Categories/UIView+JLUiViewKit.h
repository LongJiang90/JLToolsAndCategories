//
//  UIView+JLUiViewKit.h
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JLUiViewKit)
#pragma mark - 加载、初始化视图
///通过Nib加载视图
+ (id)jl_instanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner;
- (void)jl_loadContentsWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil;

#pragma mark - 获取self视图中符合条件的view或者view数组
///获取self中符合条件的view
- (UIView *)jl_viewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)jl_viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (UIView *)jl_viewOfClass:(Class)viewClass;
- (NSArray *)jl_viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)jl_viewsWithTag:(NSInteger)tag;
- (NSArray *)jl_viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray *)jl_viewsOfClass:(Class)viewClass;
///获取self最开始的SuperView
- (UIView *)jl_firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)jl_firstSuperviewOfClass:(Class)viewClass;
- (UIView *)jl_firstSuperviewWithTag:(NSInteger)tag;
- (UIView *)jl_firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)jl_viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)jl_viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)jl_isSuperviewOfView:(UIView *)view;
- (BOOL)jl_isSubviewOfView:(UIView *)view;

///响应链 获取当前的VC、第一响应者
- (UIViewController *)jl_firstViewController;
- (UIView *)jl_firstResponder;

#pragma mark - frame 相关属性
@property (nonatomic, assign) CGPoint jl_origin;
@property (nonatomic, assign) CGSize jl_size;
@property (nonatomic, assign) CGFloat jl_top;           /**< 顶部Y值 */
@property (nonatomic, assign) CGFloat jl_left;          /**< 左边X值 */
@property (nonatomic, assign) CGFloat jl_bottom;        /**< 底部Y值 */
@property (nonatomic, assign) CGFloat jl_right;         /**< 右边X值 */
@property (nonatomic, assign) CGFloat jl_width;         /**< 宽度 */
@property (nonatomic, assign) CGFloat jl_height;        /**< 高度 */
@property (nonatomic, assign) CGFloat jl_x;             /**< 左上角顶点x坐标 */
@property (nonatomic, assign) CGFloat jl_y;             /**< 左上角顶点y坐标 */
@property (nonatomic, assign) CGFloat jl_centerX;       /**< 中心点x坐标 */
@property (nonatomic, assign) CGFloat jl_centerY;       /**< 中心点y坐标 */

#pragma mark - bounds 相关属性
@property (nonatomic, assign) CGSize jl_boundsSize;
@property (nonatomic, assign) CGFloat jl_boundsWidth;
@property (nonatomic, assign) CGFloat jl_boundsHeight;

#pragma mark - content get方法
@property (nonatomic, readonly) CGRect jl_contentBounds;
@property (nonatomic, readonly) CGPoint jl_contentCenter;

#pragma mark - 根据给定的条件变化view的frame
- (void)jl_setLeft:(CGFloat)left right:(CGFloat)right;
- (void)jl_setWidth:(CGFloat)width right:(CGFloat)right;
- (void)jl_setTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)jl_setHeight:(CGFloat)height bottom:(CGFloat)bottom;

#pragma mark - animation
- (void)jl_crossfadeWithDuration:(NSTimeInterval)duration;
- (void)jl_crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;

@end
