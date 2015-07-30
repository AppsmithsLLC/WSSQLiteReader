//
//  WSTextViewTableViewCell.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@class WSTextViewTableViewCell;

@protocol WSTextViewTableViewCellDelegate <NSObject>

- (void)wsTextViewCell:(WSTextViewTableViewCell*)cell textDidChange:(NSString*)newText;
- (void)wsTextViewCell:(WSTextViewTableViewCell*)cell textDidBeginEditing:(NSString*)newText;

@end

@interface WSTextViewTableViewCell : UITableViewCell  <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textViewLabel;


//Delegate
@property (weak) id<WSTextViewTableViewCellDelegate> delegate;

@end
