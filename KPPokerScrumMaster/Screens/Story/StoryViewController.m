//
//  CreateStoryViewController.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryModel.h"

@interface StoryViewController ()

@end

@implementation StoryViewController {
    __weak IBOutlet UITextField *_titleTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_titleTextField becomeFirstResponder];
}

- (void)dismissView:(id)sender {
    [_titleTextField resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSubmitButton:(id)sender {
    [_titleTextField resignFirstResponder];
    StoryModel *story = [[StoryModel alloc] init];
    story.title = _titleTextField.text;
    story.date = [NSDate date];
    [self.delegate storyViewController:self storyCreated:story];
    [self dismissView:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
