//
//  WSFormSectionHeaderView.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSFormSectionHeaderView.h"
#import "WSAppSettings.h"

NSString *const WSFormSectionHeaderReuseIdentifier = @"WSFormSectionHeaderReuseIdentifier";

@interface WSFormSectionHeaderView()<UIGestureRecognizerDelegate>

@end

@implementation WSFormSectionHeaderView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setCollapsed:(BOOL)collapsed
{
    _collapsed = collapsed;

    UIImage *collapseButtonImage;
    if (_collapsed) {
        collapseButtonImage = [UIImage imageNamed:@"SearchFilterCollapse"];
    } else {
        collapseButtonImage = [UIImage imageNamed:@"SearchFilterExpand"];
    }
    [self.collapseButton setImage:collapseButtonImage forState:UIControlStateNormal];

    WSAppSettings *settings = [WSAppSettings sharedSettings];
    [self.collapseButton setTintColor:[settings.theme buttonTintColor]];
    
    if ([self.delegate respondsToSelector:@selector(sectionHeaderDidChangeCollapsedState:)]) {
        [self.delegate sectionHeaderDidChangeCollapsedState:self];
    }
}

-(void)setCollapsible:(BOOL)collapsible
{
    [self removeAllGestureRecognizers];
    if (collapsible) {
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(didTapCollapseButton:)];
        gr.delegate = self;
        [self addGestureRecognizer:gr];
    } else {
        [self.collapseButton setHidden:YES];
    }
}

- (void)removeAllGestureRecognizers
{
    NSArray *gestureRecognizers = [self.gestureRecognizers copy];
    for (UIGestureRecognizer *gr in gestureRecognizers){
        [self removeGestureRecognizer:gr];
    }
}

-(IBAction)didTapCollapseButton:(id)sender
{
    [self setCollapsed:!_collapsed];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return touch.view != self.addButton;
}


@end
