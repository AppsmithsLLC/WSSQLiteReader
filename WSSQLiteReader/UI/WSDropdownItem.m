//
//  WSDropdownItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/28/15.
//  Copyright (c) 2015 Websmiths, LLC. All rights reserved.
//

#import "WSDropdownItem.h"
#import "WSDropdownTableViewCell.h"
#import "WSAppSettings.h"

@interface WSDropdownItem()
{
    UITableViewCell *_tableViewCell;
}

@property (nonatomic,readonly) UITableViewCellStyle style;

@end

@implementation WSDropdownItem

- (instancetype)initWithTitle:(NSString *)title
                        model:(id)model
                    attribute:(NSString *)attribute
                    cellStyle:(UITableViewCellStyle)style
{
    self = [super initWithTitle:title model:model attribute:attribute];
    if (self) {
        _style = style;
        _accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super initWithTitle:title model:nil attribute:nil];
    if (self) {
//        _subTitle = content;
    }
    return self;
}

- (UITableViewCell *)tableViewCell
{
    if (_tableViewCell) {
        return _tableViewCell;
    }
    
    _tableViewCell = [[UITableViewCell alloc] initWithStyle:self.style reuseIdentifier:nil];
    _tableViewCell.accessoryType = self.accessoryType;
    _tableViewCell.textLabel.text = self.title;
    _tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _tableViewCell;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.tableViewCell.textLabel.text = title;
}

- (NSString *)subtitle
{
    return self.tableViewCell.detailTextLabel.text;
}

-(void)setSubtitle:(NSString *)subtitle
{
    self.tableViewCell.detailTextLabel.text = subtitle;
}

-(void)setAccesoryType:(UITableViewCellAccessoryType)accesoryType
{
    _accessoryType = accesoryType;
    
    if (_tableViewCell) {
        _tableViewCell.accessoryType = accesoryType;
    }
}

- (UITableViewCellAccessoryType)accesoryType
{
    return _accessoryType;
}

- (CGFloat)rowHeight
{
    return kHeightForStandardRow;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        if ([self.delegate respondsToSelector:@selector(didSelectCellForItem:)]) {
            [self.delegate didSelectCellForItem:self];
        }
    }
}

@end
