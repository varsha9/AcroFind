//
//  VarsViewController.m
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import "VarsViewController.h"
#import "Constants.h"

@interface VarsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *varsTableView;
@property (nonatomic,weak) IBOutlet UILabel *label;

@end

@implementation VarsViewController


#pragma mark - UIViewController Lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.acro.vars.count) {
        [self.varsTableView setHidden:NO];
        self.label = nil;
    }
    else{
        [self.label setHidden:NO];
        [self.label setText: [NSString stringWithFormat:NSLocalizedString(@"NoVars", @""),self.acro.results]];
        self.varsTableView = nil;
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView Datasource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acro.vars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"VariationsCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    acro *meaning = [self.acro.vars objectAtIndex:indexPath.row];
    cell.textLabel.text = meaning.results;
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Subtitle", @""),(long)meaning.since, (long)meaning.freq];
    
    
    return cell;
}

#pragma mark- UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifier = @"VariationsHeaderIdentifier";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
    
    headerView.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Vars", @""),self.acro.results];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    acro *meaning = [self.acro.vars objectAtIndex:indexPath.row];
    
    CGFloat titleHeight = [self heightForText:[meaning lForm] withFont:labelBoldTextFont];
    NSString *subTitleText = [NSString stringWithFormat:NSLocalizedString(@"Subtitle", @""),(long)meaning.since, (long)meaning.freq];
    CGFloat subtitleHeight = [self heightForText:subTitleText withFont:descriptionTextFont];
    
    return titleHeight + subtitleHeight + 2*cellVerticalPadding;
    
}

#pragma mark - Helper method


-(CGFloat) heightForText:(NSString *) text withFont:(UIFont *) font {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.varsTableView.frame.size.width-cellHorizontalWaste, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}



@end
