//
//  NoteEditorViewController+TextViewDelegate.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "NoteEditorViewController+TextViewDelegate.h"
#import "Note.h"

@interface NoteEditorViewController ()
@property (nonatomic, strong) Note *note;
@end

@implementation NoteEditorViewController (TextViewDelegate)
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.note.contents = textView.text;
}
@end
