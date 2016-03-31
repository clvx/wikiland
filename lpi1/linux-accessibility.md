Linux Accessibility
===================

Sticky/Repeat Keys and Slow/Bounce Keys Toggle
==============================================
• Slow keys are used to prevent inadvertent repeat of key presses either from shaking or slow up/down depression of keys.
    ◦ timing can be set more or less sensitive by user depending on the type of user restriction.
    ◦ To enable in ubuntu: settings -> universal access -> turn on bounce keys 

• Repeat keys control the amount of time that takes place before the same key can be pressed simultaneously and accepts as input.
• Sticky/repeat keys are used so that shift/ctl/alt or other special keys can be pressed and will remain “stuck” until after the next character is depressed.
    ◦ To enable in ubuntu: settings -> universal access -> turn on sticky keys, check in beep when a modifier key is pressed. 
        - With this if I press a key it will wait until a next key is pressed. eg. ALT + F4, it will wait for F4.

Mouse Keys and Onscreen Keyboard
================================

• Mousekeys is a setting that will enable the number pad on a standard keyboard to function as both the pointing/directional control for the mouse cursor as well as buttons on the keypad for left and right mouse click.
    ◦ System settings -> Universal Access -> Pointing and Clicking -> Mouse keys, Control the pointer using the keypad. 
• The onscreen keyboard, once activated, will pop up any time a screen or field that requires keyboard input has focus.
    ◦ Can be expanded to include function keys as well as numeric keypad as necessary with a mouse click on the appropriate setting button.
    ◦ System settings -> Universal Access -> Typing -> On screen keyboard, shows a keyboard.

Screen Reader and Screen Magnifier
==================================

• Embedded accessibility features across all Linux distributions.
• Features are typically pulled from support libraries that typically are distributed with the accessibility application Orca (see Video Six).
• Screen magnifier allows a mouse controlled windows or full screen magnification of GUI and text on the screen, in varying but controllable zoom settings, for users with sight restrictions.
    ◦ System settings -> Universal Access -> Seeing -> Zoom, enables zoom functions
• Screen reader can be activated for extreme sight restriction (or not – some just prefer the text read to them) which will allow the system to read text from any screen, menu, button or control that has focus.
    ◦ Voices are generally changeable, except Ubuntu without hacking the configuration files.
    ◦ System settings -> Universal Access -> Seeing -> Screen Reader, reads out loud in which desktop context the mouse is. 


Large Print Screen and High Contrast Desktop Themes
===================================================

• Both of these utilities are available for users with varying degrees of sight restrictions in order to increase readability and contrast of the desktop.
• Large print simply replaces all of the control and window text defaults with a larger print that makes them easier to read, can be similar to what happens in Microsoft Windows if you choose to use a higher screen DPI setting than the default for the resolution used.
    ◦  System settings -> Universal Access -> Seeing -> Large Text, increases the size of the text on the menu and the bottons.
• High contrast changes the screen, icons and common control elements to very high contrast (black on white, white on black, color to color high contrast settings) visuals that make each component and related text easily distinguishable from the background or other elements on the screen.
    ◦  System settings -> Universal Access -> Seeing -> High Contrast,  contrasts the text and icon between high contrast colors(black and white).

Braille Display and Gestures
============================

• Some of the braille management has been pulled by various distributions from the braille library typically included with Orca (see Video Six).
• Debian distributions offer the braille-console library that allows special terminal output.
• Braille device drivers are available for various USB braille output devices on all distributions.
    ◦ `apt install console-braille` 
    ◦ `apt install brltty` 
Gestures, ability to manage windows using mouse or keyboard. Dragging it to align it to the left or right side, etc.


Orca and GOK
============

• Orca – application that manages many of the now embedded accessibility features for Linux.
    ◦ magnification.
    ◦ Braille output.
    ◦ Screen reader.
    ◦ Key bindings.
    ◦ Text attributes.
• GOK – gnome onscreen keyboard
