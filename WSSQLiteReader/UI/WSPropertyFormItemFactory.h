//
//  WSPropertyFormItemFactory.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import <Foundation/Foundation.h>
#import "WSPropertyFormItem.h"
#import "WSDataObject.h"

@class WSDataObject;
@class WSSchemaObject;

@interface WSPropertyFormItemFactory : NSObject

//Factory initializer for WSDataObject fields
//
+ (id<WSPropertyFormItemDelegate>) createFormItemForDataObject:(WSDataObject*)dataObject
                                                    isEditable:(BOOL)isEditable;


//Factory initializer WSSchemaObject fields
//
+ (id<WSPropertyFormItemDelegate>) createFormItemForSchemaObject:(WSSchemaObject*)schemaObject
                                                      isEditable:(BOOL)isEditable;

@end
