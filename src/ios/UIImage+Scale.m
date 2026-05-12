#import "UIImage+Scale.h"

@implementation UIImage (scale)

-(UIImage*)scaleToSize:(CGSize)size
{
    if (size.width <= 0 || size.height <= 0) {
        return self;
    }

    UIGraphicsImageRendererFormat *rendererFormat = [UIGraphicsImageRendererFormat defaultFormat];
    rendererFormat.scale = 1.0;  // size means pixels, matching original behaviour
    rendererFormat.opaque = NO;
    
    // Force sRGB to match old behaviour exactly
    if (@available(iOS 12.0, *)) {
        rendererFormat.preferredRange = UIGraphicsImageRendererFormatRangeStandard;
    }

    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size 
                                                                               format:rendererFormat];

    UIImage *scaledImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull context) {
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    }];

    return scaledImage;
}

@end
