//
//  WSPropertyFormItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"
#import "WSAppSettings.h"
#import <CoreText/CTStringAttributes.h>

#pragma mark - WSFormItem

@implementation WSFormItem

-(UITableViewCell *)tableViewCell
{
    return nil;
}

-(CGFloat)rowHeight
{
    return 0;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#pragma mark - WSPropertyFormItem

@implementation WSPropertyFormItem

+ (instancetype)formWithModel:(id)model attribute:(NSString *)attribute
{
    return [[self alloc] initWithModel:model attribute:attribute];
}

// Default initializer
//
- (instancetype)initWithModel:(id)model attribute:(NSString *)attribute
{
    self = [super init];
    if (self) {
        // NSAssert(attribute != nil, @"An attribute property must be provided");
        
        _attribute = attribute;
        _model = model;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title model:(id)model attribute:(NSString *)attribute
{
    self = [self initWithModel:model attribute:attribute];
    if (self) {
        _title = title;
    }
    return self;
}

- (void)setValue:(id)value forAttribute:(NSString *)attribute
{
    if (attribute) {
        [self.model setValue:value forKey:attribute];
    }
    
    // Always callback to the delegate to notify that the value has changed.
    // This is in place to support scenarios where a cell is not actually updating a value
    // but it used for different purposes
    //
    if ([self.delegate respondsToSelector:@selector(didUpdateValueForItem:)]) {
        [self.delegate didUpdateValueForItem:self];
    }
}

- (NSString *)attributeAsString:(NSString *)attribute
{
    if (!attribute) {
        return nil;
    }
    
    id attributeValue = [self.model valueForKey:attribute];
    if ([attributeValue isKindOfClass:[NSString class]]) {
        return attributeValue;
    }
    // Primitive types will be boxed as NSNumber so we can reliably use
    // the stringValue method on NSNumber
    //
    else if ([attributeValue isKindOfClass:[NSNumber class]]) {
        
        if (((NSNumber *)attributeValue).doubleValue == 0) {
            return nil;
        } else if (isnan(((NSNumber *)attributeValue).doubleValue)) {
            return nil;
        } else {
            
            if (self.decimalPrecision > 0) {
                
                NSString *formatString = [NSString stringWithFormat:@"%%.%luf",(unsigned long)self.decimalPrecision];
                return [NSString stringWithFormat:formatString,[attributeValue doubleValue]];
                
            } else {
                
                return [attributeValue stringValue];
            }
        }
    } else if ([attributeValue isKindOfClass:[NSDate class]]) {
        
        NSDateFormatter *dateFormatter  =[[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        return [dateFormatter stringFromDate:attributeValue];
        
    } else {
        return nil;
    }
}

@end
