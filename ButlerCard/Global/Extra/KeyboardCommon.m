
#import "KeyboardCommon.h"

@implementation KeyboardCommon

+ (void)keyboardWillShow:(NSNotification *)notification view:(UIView*)aView
{
    CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; 
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
    
	aView.frame = CGRectMake(aView.bounds.origin.x, keyboardFrames.origin.y - aView.bounds.size.height-20, aView.bounds.size.width, aView.bounds.size.height);
    
	[UIView commitAnimations];    
}
+ (void)keyboardWillHide:(NSNotification *)notification view:(UIView*)aView
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
    
    aView.frame = aView.bounds;
    
	[UIView commitAnimations];    
}

+ (void)keyboardWillShow:(NSNotification *)notification target:(id)target sel:(SEL)sel
{      
//    NSLog(@"keyboardWillShow");//0627最后版本优化注销注释
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
		
    [target performSelector:sel];
    
	[UIView commitAnimations];    
}

+ (CGRect)getKeyboardRect:(NSNotification *)notification
{
    CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    return keyboardFrames;
}
+ (void)keyboardWillHide:(NSNotification *)notification target:(id)target sel:(SEL)sel
{
    NSLog(@"keyboardWillHide");
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];

    [target performSelector:sel];
	
	[UIView commitAnimations];          
}

+ (void)registerKeyboardNotification:(id)target 
                         willShowSel:(SEL)willShowSel
                         willHideSel:(SEL)willHideSel
{
    [[NSNotificationCenter defaultCenter] addObserver:target 
                                             selector:willShowSel 
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:target 
                                             selector:willHideSel 
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];
}
+ (void)unregisterKeyboardNotification:(id)target 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
