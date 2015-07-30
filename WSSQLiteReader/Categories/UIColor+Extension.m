//
//  UIColor+Extension.m
//  HAAS
//
////////////////////////////////////////////////////////////////////////
//  Created by Stephen Johnson on 5/2/14.
////////////////////////////////////////////////////////////////////////
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

-(UIColor*)colorWithAlpha:(CGFloat)alpha;
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s brightness:b alpha:alpha];
}


-(UIColor*)colorWithBrightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s brightness:brightness alpha:alpha];
}

-(UIColor*)colorWithSaturation:(CGFloat)saturation alpha:(CGFloat)alpha
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:saturation brightness:b alpha:alpha];
}

-(UIColor*)colorWithSaturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:saturation brightness:brightness alpha:alpha];
}

-(UIColor*)reduceColorBrightnessByPercentage:(CGFloat)brightnessChange
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    CGFloat brightness = b * (1.0 - brightnessChange);
    return [UIColor colorWithHue:h saturation:s brightness:brightness alpha:a];
}

-(UIColor*)increaseColorBrightnessByPercentage:(CGFloat)brightnessChange
{
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    CGFloat brightness = b * (1.0 + brightnessChange);
    return [UIColor colorWithHue:h saturation:s brightness:brightness alpha:a];
}


@end
