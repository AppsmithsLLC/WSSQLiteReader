//
//  WSDynamicForm.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import "WSBaseForm.h"

@interface WSDynamicForm : WSBaseForm

//A dictionary of WSDataObjects.
//
@property (nonatomic, readonly) NSDictionary *dataObjects;

//An array of WSSchemaObjects.
//
@property (nonatomic, readonly) NSArray *schemaObjects;

//Container for form title.
@property (nonatomic) NSString *formTitle;

//Flag representing if this form data will be editable.
//
@property (nonatomic) BOOL editMode;

-(instancetype)initWithDataObjects:(NSDictionary*)dataObjects
                      andFormTitle:(NSString*)formTitle;

-(instancetype)initWithSchemaObjects:(NSArray*)schemaObjects
                        andFormTitle:(NSString*)formTitle;

@end
