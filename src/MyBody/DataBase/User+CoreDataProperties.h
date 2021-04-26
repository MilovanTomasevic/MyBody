//
//  User+CoreDataProperties.h
//  MyBody
//
//  Created by Milovan Tomasevic on 06/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *adresa;
@property (nullable, nonatomic, copy) NSString *grad;
@property (nullable, nonatomic, copy) NSString *ime;
@property (nullable, nonatomic, copy) NSString *mail;
@property (nullable, nonatomic, copy) NSString *postanskiKod;
@property (nullable, nonatomic, copy) NSString *prezime;
@property (nullable, nonatomic, copy) NSString *sifra;
@property (nullable, nonatomic, copy) NSString *telefon;
@property (nullable, nonatomic, copy) NSString *sPitanje;
@property (nullable, nonatomic, copy) NSString *sOdgovor;
@property (nullable, nonatomic, retain) Ishrana *ishrane;
@property (nullable, nonatomic, retain) NSSet<Mere *> *merenja;
@property (nullable, nonatomic, retain) NSSet<Trening *> *treninzi;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMerenjaObject:(Mere *)value;
- (void)removeMerenjaObject:(Mere *)value;
- (void)addMerenja:(NSSet<Mere *> *)values;
- (void)removeMerenja:(NSSet<Mere *> *)values;

- (void)addTreninziObject:(Trening *)value;
- (void)removeTreninziObject:(Trening *)value;
- (void)addTreninzi:(NSSet<Trening *> *)values;
- (void)removeTreninzi:(NSSet<Trening *> *)values;

@end

NS_ASSUME_NONNULL_END
