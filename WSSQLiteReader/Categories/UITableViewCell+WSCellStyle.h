//
//  UITableViewCell+WSCellStyle.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (WSCellStyle)

/**
 I created this category method to give me a simple way to make all of my UITableViewCells
 share a consistent look and feel.  I tend to use categories frequently to cut down on boilerplate code.
 */
-(void)styleCellWithSettings;

@end
