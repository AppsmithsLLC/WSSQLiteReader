//
//  UIColor+Extension.h
//  HAAS
//
////////////////////////////////////////////////////////////////////////
//  Created by Stephen Johnson on 5/2/14.
////////////////////////////////////////////////////////////////////////
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 * This uses this color and returns it with the given alpha.
 * This changes the alpha rather than applying the alpha to the
 * given color.  For example if you had a color that was already 50% transparent
 * and you passed an alpha of 80% (.80) it would make the
 * returned color have an alpha of 80% and not apply the 80%
 * to the 50% and give 40%.
 */
-(UIColor*)colorWithAlpha:(CGFloat)alpha;

/*
 * Returns the this color changed to have the given brightness and alpha.
 */
-(UIColor*)colorWithBrightness:(CGFloat)brightness alpha:(CGFloat)alpha;

/*
 * Returns the this color changed to have the given saturation and alpha.
 */
-(UIColor*)colorWithSaturation:(CGFloat)saturation alpha:(CGFloat)alpha;


/*
 * Returns the this color changed to have the given brightness, saturation, and alpha.
 */
-(UIColor*)colorWithSaturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

-(UIColor*)reduceColorBrightnessByPercentage:(CGFloat)brightnessChange;
-(UIColor*)increaseColorBrightnessByPercentage:(CGFloat)brightnessChange;

@end
