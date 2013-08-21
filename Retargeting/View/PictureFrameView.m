//
//  PictureFrameView.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "PictureFrameView.h"

@implementation PictureFrameView
@synthesize dataSource = _dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        roundedRectView = [[RoundedRectView alloc] initWithFrame:self.frame];
        [self addSubview:roundedRectView];
    }
    return self;
}

-(void)layoutSubviews {
    // set all subviews to center
    for (UIView * view in self.subviews) {
        if (view != roundedRectView) {
            view.frame = CGRectMake(10, 10, self.frame.size.width-2*10, self.frame.size.height-2*10);
            [view setNeedsDisplay];
        }
    }
    
    if(self.dataSource.showSaliency && self.dataSource.croppingFlag) {
        CGRect cropRect = self.dataSource.cropPreviewInnerRect;
        CGSize cropSize = self.dataSource.cropPreviewSize;
//        NSLog(@"Crop Preview Inner Rect %lf %lf %lf %lf",cropRect.origin.x,
//              cropRect.origin.y,cropRect.size.width,cropRect.size.height);
//        NSLog(@"Crop Preview Size %lf %lf",cropSize.width, cropSize.height);
        roundedRectView.frame = CGRectMake(cropRect.origin.x/cropSize.width*(self.bounds.size.width-20),
                                            (cropSize.height-cropRect.size.height-cropRect.origin.y)/cropSize.height*(self.bounds.size.height-20),
                                            cropRect.size.width/cropSize.width*(self.bounds.size.width-20)+20,
                                            cropRect.size.height/cropSize.height*(self.bounds.size.height-20)+20); // place the picture view just right under the same image part in the saliency view, such that the transition is as smooth as possible
        
    } else {
        roundedRectView.frame = self.bounds;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
