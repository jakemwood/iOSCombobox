iOSCombobox
===========

This is an iOS control that attempts to replicate the pretty `<select>` Safari web sites get by default.  This control combines the standard `UIPickerView` with some custom drawing.

## Summary
* Right now, it is only tested on the iPhone.  Ideally, the iPad version should display the UIPickerView in a popover window (which it currently does not do.)
* Probably requires iOS 5+.  It was developed against the iOS 6 SDK.
* Uses ARC.

## How to Use
1. Import `iOSCombobox.h` and `iOSCombobox.m` into your project.
2. To programatically create a combo box, put something like this in your view controller initialization routine:

	```
	CGRect myRect = CGRectMake(10.0f, 10.0f, 300.f, 32.0f);
	
	iOSCombobox *myCombo = [[iOSCombobox alloc] initWithFrame:myRect];
	[myCombo setValues:@[@"Hello", "World"]];
	[myCombo setCurrentValue:@"World"];
	[self.view addSubview:combo];
	```
3. Adding from the interface builder may also be possible.  I imagine it's as simple as adding a "view," then changing the type of the view to be iOSCombobox.  I'll be testing that soon.  I just wanted to get this readme written.

### Using with BSKeyboardControls
If you're wanting to use this with BSKeyboardControls, you'll need to make a quick addition to their code.  I've included the modified versions of BSKeyboardControls.h and BSKeyboardControls.m in this repository.  Basically, in the…

```
- (void) setFields:(NSArray *)fields
```
method, you'll need to add an additional case to the "if" block you see within the "for" loop to accomodate the fact that this combo box is not a text field or a text view.  You'll add…

```
else if ([field isKindOfClass:[iOSCombobox class]])
{
	[(iOSCombobox *)field setInputAccessoryView:self];
}
```

Another possible fix to this solution is simply asking the `field` if it responds to `setInputAccessoryView`.  That way, you won't need to expand on this method whenever you want to add a different kind of control.

## Help Wanted
* Modernizing the drawing.  I'm fairly new to iOS, but most of the example code out there is for older Core Graphics stuff.  I can't tell you how many times I encountered an accepted Stack Overflow answer with a comment of "there is now a better way to do this."  If anyone has suggestions on improving the draw method, please feel free to fork and submit a pull request.
* iPad support.  (Though I'll eventually have to do this myself)

## License
This is MIT licensed.  Have at it!
