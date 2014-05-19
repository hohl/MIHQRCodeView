//
// Copyright (C) 2014 Michael Hohl <http://www.michaelhohl.net/>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
// Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
// OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MIHQRCodeView.h"

@interface MIHQRCodeView ()
- (NSString *)convertErrorCorrectionLevelToString:(MIHQRErrorCorrectionLevel)errorCorrectionLevel;
@end

@implementation MIHQRCodeView

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Init and NSCopying
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataValue = [aDecoder decodeObjectForKey:@"_dataValue"];
        _errorCorrectionLevel = [aDecoder decodeIntegerForKey:@"_errorCorrectionLevel"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_dataValue forKey:@"_dataValue"];
    [aCoder encodeInteger:_errorCorrectionLevel forKey:@"_errorCorrectionLevel"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Public methods and properties
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)reloadData
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSString *errorCorrectionLevelString = [self convertErrorCorrectionLevelToString:self.errorCorrectionLevel];
    [filter setValue:self.dataValue forKey:@"inputMessage"];
    [filter setValue:errorCorrectionLevelString forKey:@"inputCorrectionLevel"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1
                                   orientation:UIImageOrientationUp];
    
	CGFloat width = image.size.width * 10;
	CGFloat height = image.size.height * 10;
    
	UIGraphicsBeginImageContext(CGSizeMake(width, height));
	CGContextRef cgContext = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
	[image drawInRect:CGRectMake(0, 0, width, height)];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    self.image = image;
}

- (void)setDataValue:(NSData *)dataValue
{
    _dataValue = dataValue;
    [self reloadData];
}

- (void)setErrorCorrectionLevel:(MIHQRErrorCorrectionLevel)errorCorrectionLevel
{
    _errorCorrectionLevel = errorCorrectionLevel;
    [self reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Purivat methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)convertErrorCorrectionLevelToString:(MIHQRErrorCorrectionLevel)errorCorrectionLevel
{
    switch(errorCorrectionLevel) {
        case MIHErrorCorrectionLevelLow:
            return @"L";
        case MIHErrorCorrectionLevelMedium:
            return @"M";
        case MIHErrorCorrectionLevelQuartile:
            return @"Q";
        case MIHErrorCorrectionLevelHigh:
            return @"H";
        default:
            return @"unknown";
    }
}

@end
