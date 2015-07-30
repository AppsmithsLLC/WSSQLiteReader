//
//  WSFormSectionHeaderView.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

extern NSString *const WSFormSectionHeaderReuseIdentifier;

@class WSFormSectionHeaderView;

@protocol WSFormSectionHeaderDelegate <NSObject>

-(void)sectionHeaderDidChangeCollapsedState:(WSFormSectionHeaderView *)headerView;

@end

@interface WSFormSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UIButton *addButton;
@property (nonatomic,weak) IBOutlet UIButton *collapseButton;

@property (nonatomic) BOOL collapsed;

@property (nonatomic,weak) id<WSFormSectionHeaderDelegate> delegate;

-(void)setCollapsible:(BOOL)collapsible;

@end
