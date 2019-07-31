//
//  NotesListViewController.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "NotesListViewController.h"
#import "NoteEditorViewController.h"
#import "AppRouter.h"

#import "Note.h"

static NSString * const CELL_ID = @"default cell";

@interface NotesListViewController ()

@property (nonatomic, copy) NSArray *mockCourses;

@end

@implementation NotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"OCTextKitNotePad";
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:CELL_ID];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mockCourses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    UIColor *textColor = [UIColor colorWithRed:0.175 green:0.458 blue:0.831 alpha:1];
    NSDictionary<NSAttributedStringKey, id> *attributes = @{ NSForegroundColorAttributeName : textColor,
                                                             NSFontAttributeName : font,
                                                             //                                                             NSTextEffectAttributeName : NSTextEffectLetterpressStyle  // 太耗时
                                                             };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_mockCourses[indexPath.row] attributes:attributes];
    cell.textLabel.attributedText = attributedString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note *note = [[Note alloc] initWithText:self.mockCourses[indexPath.row]];
    NoteEditorViewController *noteViewController = [[NoteEditorViewController alloc] initWithCourse:note];
    [[AppRouter sharedAppRouter] showViewController:noteViewController];
}

- (NSArray *)mockCourses {
    if (!_mockCourses) {
        _mockCourses = [@[@"~Quick~", @"*工作原理*", @"-个人简介-", @"_HHKB_"] copy];
    }
    return _mockCourses;
}

@end
