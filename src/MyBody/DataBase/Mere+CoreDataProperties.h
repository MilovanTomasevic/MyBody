//
//  Mere+CoreDataProperties.h
//  MyBody
//
//  Created by Milovan Tomasevic on 08/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "Mere+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Mere (CoreDataProperties)

+ (NSFetchRequest<Mere *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *datumMerenja;
@property (nullable, nonatomic, copy) NSString *godine;
@property (nullable, nonatomic, copy) NSString *ime;
@property (nonatomic) BOOL izabranaMera;
@property (nullable, nonatomic, copy) NSString *obimButina;
@property (nullable, nonatomic, copy) NSString *obimGrudi;
@property (nullable, nonatomic, copy) NSString *obimKuka;
@property (nullable, nonatomic, copy) NSString *tezina;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *visina;
@property (nullable, nonatomic, copy) NSString *kratkaNapomena;
@property (nullable, nonatomic, copy) NSString *pol;
@property (nullable, nonatomic, copy) NSString *bmi;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
