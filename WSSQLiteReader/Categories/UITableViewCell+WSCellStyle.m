//
//  UITableViewCell+WSCellStyle.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import "UITableViewCell+WSCellStyle.h"
#import "WSAppSettings.h"

@implementation UITableViewCell (WSCellStyle)

-(void)styleCellWithSettings
{
    self.tintColor = [WSAppSettings sharedSettings].theme.textColor;
    self.textLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
    self.textLabel.font = [WSAppSettings sharedSettings].theme.tableViewCellTitleFont;
    
    self.detailTextLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
    self.detailTextLabel.font = [WSAppSettings sharedSettings].theme.tableViewCellDetailsFont;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.backgroundView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.selectedBackgroundView.backgroundColor = [WSAppSettings sharedSettings].theme.selectedStateTintColor;
}

@end
