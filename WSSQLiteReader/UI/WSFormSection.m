//
//  WSFormSection.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSFormSection.h"
#import "WSFormSectionHeaderView.h"
#import "WSAppSettings.h"

#pragma mark - WSAttributeFormSection

@interface WSFormSection() <WSFormSectionHeaderDelegate>


@end

@implementation WSFormSection

+ (instancetype)sectionWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self){
        _title = title;
        _height = 30;
        _rows = [NSMutableArray array];
        
        _collapsible = YES;
        _showSectionHeader = YES;
    }
    return self;
}

-(WSFormSectionHeaderView *)headerView:(UITableView *)tableView
{
    WSFormSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"WSFormSectionHeaderView"
                                                                         owner:self
                                                                       options:nil] firstObject];
    
    WSAppSettings *settings = [WSAppSettings sharedSettings];
    headerView.layer.backgroundColor = [settings.theme tintColor].CGColor;
    headerView.titleLabel.textColor = [settings.theme alternateButtonTintColor];
    headerView.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    headerView.titleLabel.text = self.title;
    
    headerView.addButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    headerView.addButton.titleLabel.textColor = [UIColor whiteColor];
    headerView.addButton.tintColor = [settings.theme alternateButtonTintColor];
    
    [headerView.addButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    if (self.addBlock) {
        [headerView.addButton setHidden:NO];
        [headerView.addButton addTarget:self action:@selector(addRow:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [headerView.addButton setHidden:YES];
    }
    
    [headerView setCollapsible:self.collapsible];
    headerView.collapsed = self.collapsed;
    headerView.delegate = self;
    
    return headerView;
}

-(CGFloat)height
{
    if (self.showSectionHeader && self.title.length > 0) {
        return 40;
    } else {
        return 0;
    }
}

-(IBAction)addRow:(id)sender
{
    if (self.addBlock) {
        self.addBlock();
    }
}

-(void)setCollapsed:(BOOL)collapsed
{
    BOOL update = (_collapsed != collapsed);
    
    _collapsed = collapsed;
    
    if (update) {
        
        if ([self.delegate respondsToSelector:@selector(formSectionDidChangeCollapsedState:)]) {
            [self.delegate formSectionDidChangeCollapsedState:self];
        }
    }
}

-(void)sectionHeaderDidChangeCollapsedState:(WSFormSectionHeaderView *)headerView
{
    self.collapsed = headerView.collapsed;
}
@end


