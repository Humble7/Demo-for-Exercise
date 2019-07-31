//
//  NoteEditorViewController.h
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

NS_ASSUME_NONNULL_BEGIN

@interface NoteEditorViewController : UIViewController

- (instancetype)initWithCourse:(Note *)course;

@end

NS_ASSUME_NONNULL_END
