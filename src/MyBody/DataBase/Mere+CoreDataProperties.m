//
//  Mere+CoreDataProperties.m
//  MyBody
//
//  Created by Milovan Tomasevic on 08/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "Mere+CoreDataProperties.h"

@implementation Mere (CoreDataProperties)

+ (NSFetchRequest<Mere *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Mere"];
}

@dynamic datumMerenja;
@dynamic godine;
@dynamic ime;
@dynamic izabranaMera;
@dynamic obimButina;
@dynamic obimGrudi;
@dynamic obimKuka;
@dynamic tezina;
@dynamic userID;
@dynamic visina;
@dynamic kratkaNapomena;
@dynamic pol;
@dynamic bmi;
@dynamic user;

@end
