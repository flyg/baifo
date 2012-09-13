//
//  ModelManager.h
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface ModelManager : NSObject
+(int) modelIndexMax;
+(void) initModels;
+(Model*) getModel:(int) index;
@end
