//
//  WSTextFieldTableViewCell.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@interface WSDropdownTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property BOOL labelIsSmall;
@property BOOL performAnimation;
- (void)animateLabel;

@end
