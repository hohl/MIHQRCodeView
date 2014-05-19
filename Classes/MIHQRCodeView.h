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

#import <UIKit/UIKit.h>

/**
 *  Enumeration for the different error correction level available for QR codes.
 */
typedef NS_ENUM(NSInteger, MIHQRErrorCorrectionLevel) {
    /**
     *  Up to 7% damage.
     */
    MIHErrorCorrectionLevelLow,
    /**
     *  Up to 15% damage.
     */
    MIHErrorCorrectionLevelMedium,
    /**
     *  Up to 25% damage.
     */
    MIHErrorCorrectionLevelQuartile,
    /**
     *  Up to 30% damage.
     */
    MIHErrorCorrectionLevelHigh
};

/**
 *  Sublcass of UIImageView which is used to display a QR code.
 *  For information about what an QR code is have a look at 
 *  <a href="http://en.wikipedia.org/wiki/QR-code)">Wikipedia</a>.
 *
 *  @author <a href="http://www.michaelhohl.net/>Michael Hohl</a>
 */
@interface MIHQRCodeView : UIImageView

/**
 *  Use this property to set the data which should get displayed in the QR code.
 */
@property (strong, nonatomic) NSData *dataValue;

/**
 *  Defines the error correction level.
 */
@property (assign, nonatomic) MIHQRErrorCorrectionLevel errorCorrectionLevel;

/**
 *  Recreateds the displayed UIImage. You should never need to call this manually.
 */
- (void)reloadData;

@end
