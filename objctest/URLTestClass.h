//
// Created by PopMain on 2021/7/4.
//

#import <Foundation/Foundation.h>


@interface URLTestClass : NSObject<NSURLConnectionDataDelegate> {
    NSMutableData *responseData;
}
- (void)initiateURLConnection;
@end