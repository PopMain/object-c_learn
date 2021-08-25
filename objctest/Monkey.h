//
// Created by PopMain on 2021/6/30.
//

#import <Foundation/Foundation.h>


#import "AnimalDelegate.h"


@interface Monkey: NSObject<AnimalDelegate> {
}
-(void)eat;
@end