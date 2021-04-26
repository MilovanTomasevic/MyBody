//
//  User+CoreDataProperties.m
//  MyBody
//
//  Created by Milovan Tomasevic on 06/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic adresa;
@dynamic grad;
@dynamic ime;
@dynamic mail;
@dynamic postanskiKod;
@dynamic prezime;
@dynamic sifra;
@dynamic telefon;
@dynamic sPitanje;
@dynamic sOdgovor;
@dynamic ishrane;
@dynamic merenja;
@dynamic treninzi;

@end
