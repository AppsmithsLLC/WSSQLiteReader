//
//  WSToggleSwitchTableViewCell.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

// A simple table view cell that allows switching between ON/OFF state with a UISwitch
// To handle updates, use a standard target/selector approach in a view controller
//
@interface WSToggleSwitchTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UISwitch *toggleSwitch;
@property (nonatomic,weak) IBOutlet UILabel *label;

@end
