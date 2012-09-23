//
//  Model.h
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
{
@public
    NSString *name;
    NSString *description;
    void *vVerts;
    void *vNorms;
    void *vText;
    void *uiIndexes;
    int cIndexes;
    bool free;
    const int count;
}

@end
