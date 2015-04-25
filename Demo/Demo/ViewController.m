//
//  ViewController.m
//  Demo
//
//  Created by Sebastián Gómez on 25/04/15.
//  Copyright (c) 2015 Sebastián Gómez. All rights reserved.
//

#import "ViewController.h"
#import "ContactsManager/KTSContactsManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [KTSContactsManager importContacts:^(NSArray *contacts)
    {
        self.tableData = contacts;
        [self.tableView reloadData];
        NSLog(@"contacts: %@",contacts);
    }];
}

#pragma mark - TableView Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
    }
    
    NSDictionary *contact = [self.tableData objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    NSString *firstName = contact[@"firstName"];
    nameLabel.text = [firstName stringByAppendingString:[NSString stringWithFormat:@" %@", contact[@"lastName"]]];
    
    UILabel *phoneNumber = (UILabel *)[cell viewWithTag:2];
    NSArray *phones = contact[@"phones"];
    
    if ([phones count] > 0) {
        NSDictionary *phoneItem = phones[0];
        phoneNumber.text = phoneItem[@"value"];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

@end
