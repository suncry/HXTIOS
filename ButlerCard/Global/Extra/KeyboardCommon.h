
#import <Foundation/Foundation.h>

@interface KeyboardCommon : NSObject

+ (void)registerKeyboardNotification:(id)target 
                         willShowSel:(SEL)willShowSel
                         willHideSel:(SEL)willHideSel;
+ (void)unregisterKeyboardNotification:(id)target;

+ (CGRect)getKeyboardRect:(NSNotification *)notification;

+ (void)keyboardWillShow:(NSNotification *)notification view:(UIView*)aView;
+ (void)keyboardWillHide:(NSNotification *)notification view:(UIView*)aView;

@end
