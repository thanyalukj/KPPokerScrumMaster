//
//  MasterViewController.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "StoryViewController.h"
#import "StoryModel.h"
#import "SessionsInteractor.h"

@interface MasterViewController () <StoryViewControllerDelegate, SessionsInteracting>
@property NSMutableArray *stories;
@property (nonatomic) NSArray *sessions;
@property (nonatomic) SessionsInteractor *sessionInteractor;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentStoryViewController)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)presentStoryViewController {
    [self performSegueWithIdentifier:@"presentStory" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"presentStory"]) {
        StoryViewController *controller = (StoryViewController *)[[segue destinationViewController] topViewController];
        controller.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StoryModel *story = self.stories[(NSUInteger)indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setStory:story sessions:self.sessions];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    StoryModel *story = (StoryModel *)self.stories[(NSUInteger)indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"US [%@]", story.title];
    cell.detailTextLabel.text = [story.date description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.stories removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sessionInteractor start];
}


#pragma mark - Story View Controller

- (void)storyViewController:(StoryViewController *)viewController storyCreated:(StoryModel *)story {
    [self insertNewStory:story];
}

- (void)insertNewStory:(StoryModel *)story {
    if (!self.stories) {
        self.stories = [[NSMutableArray alloc] init];
    }
    [self.stories insertObject:story atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - sessions
- (SessionsInteractor *)sessionInteractor {
    if (!_sessionInteractor) {
        _sessionInteractor = [[SessionsInteractor alloc] initWithSessionId:@"1"];
        _sessionInteractor.delegate = self;
    }
    return _sessionInteractor;
}

- (void)setSessions:(NSArray *)sessions {
    _sessions = sessions;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

@end
