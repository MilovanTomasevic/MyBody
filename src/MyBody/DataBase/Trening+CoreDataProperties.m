//
//  Trening+CoreDataProperties.m
//  MyBody
//
//  Created by Milovan Tomasevic on 09/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "Trening+CoreDataProperties.h"

@implementation Trening (CoreDataProperties)

+ (NSFetchRequest<Trening *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Trening"];
}

@dynamic datumUnosa;
@dynamic ime;
@dynamic izabraniTrening;
@dynamic t1Sadrzaj;
@dynamic t2Sadrzaj;
@dynamic t3Sadrzaj;
@dynamic t4Sadrzaj;
@dynamic t5Sadrzaj;
@dynamic t6Sadrzaj;
@dynamic t7Sadrzaj;
@dynamic userID;
@dynamic t1Fokus;
@dynamic t2Fokus;
@dynamic t3Fokus;
@dynamic t4Fokus;
@dynamic t5Fokus;
@dynamic t6Fokus;
@dynamic t7Fokus;
@dynamic user;

@end
