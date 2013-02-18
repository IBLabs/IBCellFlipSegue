//
//  MainMenuViewController.m
//  CellFlip
//
//  Created by Itamar Biton on 1/25/13.
//  Copyright (c) 2013 IBlabs. All rights reserved.
//

#import "Globals.h"

#import "IBCellFlipSegue.h"

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Storyboard Delegate Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue isMemberOfClass:[IBCellFlipSegue class]])
    {
        IBCellFlipSegue *cellFlipSegue = (IBCellFlipSegue *)segue;
        cellFlipSegue.selectedCell = sender;
        cellFlipSegue.flipAxis = FlipAxisHorizontal;
    }
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainMenuCellIdentifier = @"MainMenuCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background.jpg"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSegueDetails sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (IBAction)didClickedShowButton:(id)sender {
    // [self performSegueWithIdentifier:kSegueDetails sender:sender];
}

@end
