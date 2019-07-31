//
//  NoteEditorViewController.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "NoteEditorViewController.h"
#import "NoteEditorViewController+TextViewDelegate.h"

#import "Note.h"
#import "SyntaxHighlightTextStorage.h"

#import "TimeIndicatorView.h"

@interface NoteEditorViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) TimeIndicatorView *timeView;
@property (nonatomic, strong) SyntaxHighlightTextStorage *textStorage;
@property (nonatomic, strong) Note *note;

@end

@implementation NoteEditorViewController

- (instancetype)initWithCourse:(Note *)note {
    self = [super init];
    if (self) {
        self.note = note;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self p_createTextView];
    
    [self.textView setScrollEnabled:YES];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(p_keyboardDidShow:)
                                               name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(p_keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification object:nil];
    
    self.textView.adjustsFontForContentSizeCategory = YES;
    _timeView = [[TimeIndicatorView alloc] initWithDate:_note.timestamp];
    [_textView addSubview:_timeView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self p_updateTimeIndicatorFrame];
    [_textStorage update];
}

# pragma mark - Private

- (void)p_updateTimeIndicatorFrame {
    [_timeView updateSize];
    _timeView.frame = CGRectOffset(_timeView.frame, _textView.frame.size.width - _timeView.frame.size.width, 0);
    UIBezierPath *exclusionPath = [_timeView curvePathWithOrigin:_timeView.center];
    _textView.textContainer.exclusionPaths = @[exclusionPath];
}

- (void)p_createTextView {
    
    NSDictionary<NSAttributedStringKey, id> *attributes = @{
                                                            NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                                            };
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_note.contents attributes:attributes];
    self.textStorage = [SyntaxHighlightTextStorage new];
    [self.textStorage appendAttributedString:attrString];
    
    CGRect newTextViewRect = self.view.bounds;
    
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    
    CGSize containerSize = CGSizeMake(newTextViewRect.size.width, newTextViewRect.size.height);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [self.textStorage addLayoutManager:layoutManager];
    
    self.textView = [[UITextView alloc] initWithFrame:newTextViewRect textContainer:container];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.textView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              ]];
}

- (void)p_keyboardDidShow:(NSNotification *)notification {
    NSValue *rectValue = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardSize = rectValue.CGRectValue;
    
    [self p_updateTextViewSizeForKeyboardHeight:keyboardSize.size.height];
}

- (void)p_keyboardWillHide:(NSNotification *)notification {
    [self p_updateTextViewSizeForKeyboardHeight:0];
}

- (void)p_updateTextViewSizeForKeyboardHeight:(CGFloat)keyboardHeight {
    self.textView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - keyboardHeight);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
