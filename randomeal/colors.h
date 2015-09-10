//
//  colors.h
//  randomeal
//
//  Created by Matteo Sandrin on 21/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#ifndef colors_h
#define colors_h
#endif

#define UIColorFromHEX(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BACKGROUND_COLOR 0xD73444 //#5
#define BUTTON_COLOR 0x91D4D8 //#4
#define SHADOW_COLOR 0x648CA5 //#3
#define THIRD_COLOR 0x24A597 //#2