//
//  ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 26.01.2017.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "CATextLayer+ACFloatingInput.h"

@implementation CATextLayer (ACFloatingInput)

@dynamic textAlignment;

#pragma mark -
#pragma mark Access methods

- (void) setTextAlignment:(CTTextAlignment)other {

    switch (other) {
        case kCTTextAlignmentLeft:
            self.alignmentMode = kCAAlignmentLeft;
            break;
            
        case kCTTextAlignmentRight:
            self.alignmentMode = kCAAlignmentRight;
            break;
            
        case kCTTextAlignmentCenter:
            self.alignmentMode = kCAAlignmentCenter;
            break;
            
        case kCTTextAlignmentJustified:
            self.alignmentMode = kCAAlignmentJustified;
            break;

        case kCTTextAlignmentNatural:
            self.alignmentMode = kCAAlignmentNatural;
            break;
            
        default:
            break;
    }
}

- (CTTextAlignment) textAlignment {
    
    if ([self.alignmentMode isEqualToString:kCAAlignmentLeft]) {
        return kCTTextAlignmentLeft;
    }
    else if ([self.alignmentMode isEqualToString:kCAAlignmentRight]) {
        return kCTTextAlignmentRight;
    }
    else if ([self.alignmentMode isEqualToString:kCAAlignmentCenter]) {
        return kCTTextAlignmentCenter;
    }
    else if ([self.alignmentMode isEqualToString:kCAAlignmentJustified]) {
        return kCTTextAlignmentJustified;
    }
    return kCTTextAlignmentNatural;
}

@end
