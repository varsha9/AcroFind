//
//  ViewController.m
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "acro.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "WebService.h"
#import "Constants.h"
#import "VarsViewController.h"



@interface ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) acro *acronym;

@property (nonatomic, weak) IBOutlet UITableView *acroTableView;
@property (nonatomic, weak) IBOutlet UITextField *acroTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self presentView];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // view to present when user starts editing text
    
    [self presentView];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // TextField Search is disabled until user enters atleast one character.
    
    // Dismiss Keyboard on return
    
    [textField resignFirstResponder];
    
    if(![textField.text isEqualToString:@""]){
        
        [self fetchResults:textField.text];
    }
    
    return YES;
}


-(void) fetchResults: (NSString *) acronym {
    
    NSDictionary *parameters = @{@"sf": acronym};
    
    // Show Loading Indicator
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WebService sharedManager] getResponse:aBaseURL
    Parameters:parameters success:^(NSURLSessionDataTask *task, acro *acronym) {
                                                         
    [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    self.acronym = acronym;
        
    if (self.acronym && self.acronym.results.count > 0) {
    [self.acroTableView setHidden:NO];
    [self.acroTableView setContentOffset:CGPointZero animated:NO];
    [self.acroTableView reloadData];
    }
        
    else{
    // No results  alerts
        
    [self showErrorAlertWithTitle:NSLocalizedString(@"Sorry", @"") message:[NSString stringWithFormat:NSLocalizedString(@"NoResults", @""),self.acroTextField.text]];
    }
    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                         
    // error alerts
    
    [self showErrorAlertWithTitle:nil message:error.localizedDescription];
                                    }];

    }



#pragma mark- UITableView Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acronym.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    acro *meaning = [self.acronym.results objectAtIndex:indexPath.row];
    cell.textLabel.text = meaning.results;
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Subtitle", @""),(long)meaning.since, (long)meaning.freq];
    
    return cell;
}


#pragma mark- UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerIdentifier = @"HeaderIdentifier";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
    
    headerView.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Acronym", @""),self.acroTextField.text];
    
    return headerView;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Calculate height and padding
    
    acro *meaning = [self.acronym.results objectAtIndex:indexPath.row];
    
    CGFloat titleHeight = [self heightForText:[meaning lForm] withFont:labelBoldTextFont];
    
    NSString *subTitleText = [NSString stringWithFormat:NSLocalizedString(@"Subtitle", @""),(long)meaning.since, (long)meaning.freq];
    CGFloat subtitleHeight = [self heightForText:subTitleText withFont:descriptionTextFont];
    
    return titleHeight + subtitleHeight + 2 * cellVerticalPadding;
    
}

#pragma mark - Helper Methods

-(void) presentView{
    
    [self.acroTableView setHidden:NO];
    self.acronym = nil;
}

-(CGFloat) heightForText:(NSString *) text withFont:(UIFont *) font {
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.acroTableView.frame.size.width - cellHorizontalWaste, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    [self performSegueWithIdentifier:@"VariationsIdentifier" sender:nil];
}

#pragma mark - Error Handling

- (void)showErrorAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }

}

#pragma mark - Navigation

// Prepare For Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"VariationsIdentifier"]) {
        NSIndexPath *indexPath = [self.acroTableView indexPathForSelectedRow];
        VarsViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.acro = [self.acronym.results objectAtIndex:indexPath.row];
    }
    

}

@end




















