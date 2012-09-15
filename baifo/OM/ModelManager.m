//
//  ModelManager.m
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "ModelManager.h"
#import "GLESmodel1.h"
#import "GLESmodel2.h"

const int MAX_MODEL = 2;

@implementation ModelManager

Model*models[MAX_MODEL];


+(int) modelIndexMax
{
    return MAX_MODEL;
}

+(Model*) initModel1
{
    Model* model = [[Model alloc]init];
    model->name = @"财神爷";
    model->description = @"财神爷的说明";
    model->screenShot = @"fo1.png";
    model->vVerts = vVerts_1;
    model->vNorms = vNorms_1;
    model->vText = vText_1;
    model->uiIndexes = uiIndexes_1;
    model->cIndexes = sizeof(uiIndexes_1)/sizeof(uiIndexes_1[0]);
    model->free = true;
    return model;
}
+(Model*) initModel2
{
    Model*model=[[Model alloc]init];
    model->name = @" 如来佛";
    model->description = @"如来佛的说明";
    model->screenShot = @"fo2.png";
    model->vVerts = vVerts_2;
    model->vNorms = vNorms_2;
    model->vText = vText_2;
    model->uiIndexes = uiIndexes_2;
    model->cIndexes = sizeof(uiIndexes_2)/sizeof(uiIndexes_2[0]);
    model->free = false;
    return model;
}

+(void) initModels
{
    models[0] = [self initModel1];
    models[1] = [self initModel2];
}

+(Model*) getModel:(int) index
{
    if (index<0 || index>=MAX_MODEL)
    {
        return nil;
    }
    else
    {
        return models[index];
    }
}
@end
