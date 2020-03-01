//
//  UIView+Frame.m
//  Coding_iOS
//
//  Created by pan Shiyu on 15/7/16.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "UIView+Frame.h"
#define kTagLineView 10101010879
#define KTagLineLeftRigth 10101010878
@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setTop:(CGFloat)t
{
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b
{
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l
{
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r
{
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}


- (void)cornerRadius:(UIRectCorner)corner cgsize:(CGSize)radiusSize
{
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radiusSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)addLineLeft:(BOOL)IsAdd LineRigth:(BOOL)IsRigthAdd color:(UIColor*)color space:(CGFloat)space
{
    [self removeLeftRigthViewWithTag:KTagLineLeftRigth];
    if(IsAdd)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(space);
            make.bottom.mas_equalTo(-space);
            make.width.mas_equalTo(1);
        }];
    }
    
    if(IsRigthAdd)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(space);
            make.bottom.mas_equalTo(-space);
            make.width.mas_equalTo(1);
        }];
    }
}


+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, SCREENWIDE - leftSpace*2, 1.0)];
    lineView.backgroundColor = color;
    return lineView;
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color space:(CGFloat)space{
    
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:space];
        upView.tag = kTagLineView;
        [self addSubview:upView];
        
        [upView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-space);
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:self.height-1.0 andColor:color andLeftSpace:space];
        downView.tag = kTagLineView;
        [self addSubview:downView];
        
        [downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-space);
            make.left.mas_equalTo(space);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    
    [self addLineUp:hasUp andDown:hasDown andColor:color space:0];
}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)removeLeftRigthViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)removeUpDownLine
{
    UIView *view = [self viewWithTag:kTagLineView];
    if(view)
        [view removeFromSuperview];
}
@end

