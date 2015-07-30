//
//  WSTextFieldTableViewCell.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSDropdownTableViewCell.h"
#import "WSAppSettings.h"

@interface WSDropdownTableViewCell()

@end

@implementation WSDropdownTableViewCell

CGFloat dropdownCellAnimationDuration = .25f;
CGFloat dropdownCellAnimationSpacing = 0;

- (void)awakeFromNib
{
    self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
    self.contentLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
    [self animateLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)animateLabel
{
    if (([self.contentLabel.text length] > 0 && self.labelIsSmall == YES)
        || ([self.contentLabel.text length] == 0 && self.labelIsSmall == NO))
    {
        //Label is correct
        return;
    }
    
    if ([self.contentLabel.text length] == 0)
    {
        [self enlargeLabel];
    }
    else
    {
        [self shrinkLabel];
    }
}

-(void)shrinkLabel
{    
    self.headerLabel.transform = CGAffineTransformMakeScale(1, 1);
    self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
    self.headerLabel.frame = CGRectMake(22, 16, 270, 21);
    
    if (!self.performAnimation)
    {
        self.headerLabel.transform = CGAffineTransformMakeScale(.5, .5);
        self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
        self.headerLabel.frame = CGRectMake(22, 5, 279, 21);
        self.labelIsSmall = YES;
        self.performAnimation = YES;
        return;
    }
    
    [UIView animateWithDuration:dropdownCellAnimationDuration delay:dropdownCellAnimationSpacing usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
        self.headerLabel.transform = CGAffineTransformMakeScale(.5, .5);
        self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
        self.headerLabel.frame = CGRectMake(22, 5, 279, 21);
    }
                     completion:^(BOOL finished)
     {
         self.labelIsSmall = YES;
     }];
}

-(void)enlargeLabel
{
    self.headerLabel.transform = CGAffineTransformMakeScale(.5, .5);
    self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
    self.headerLabel.frame = CGRectMake(22, 5, 279, 21);
    
    if (!self.performAnimation)
    {
        self.headerLabel.transform = CGAffineTransformMakeScale(1, 1);
        self.headerLabel.frame = CGRectMake(22, 16, 279, 21);
        self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
        self.labelIsSmall = NO;
        self.performAnimation = YES;
        return;
    }
    
    [UIView animateWithDuration:dropdownCellAnimationDuration delay:dropdownCellAnimationSpacing usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^
     {
         self.headerLabel.transform = CGAffineTransformMakeScale(1, 1);
         self.headerLabel.frame = CGRectMake(22, 16, 279, 21);
     }
                     completion:^(BOOL finished)
     {
         self.headerLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
         self.labelIsSmall = NO;
     }];
}

@end
