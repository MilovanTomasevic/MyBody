//
//  Ishrana+CoreDataProperties.h
//  MyBody
//
//  Created by Milovan Tomasevic on 09/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "Ishrana+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Ishrana (CoreDataProperties)

+ (NSFetchRequest<Ishrana *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cDorucak;
@property (nullable, nonatomic, copy) NSString *cRucak;
@property (nullable, nonatomic, copy) NSString *cUzina;
@property (nullable, nonatomic, copy) NSString *cUzina2;
@property (nullable, nonatomic, copy) NSString *cVecera;
@property (nullable, nonatomic, copy) NSString *datumUnosa;
@property (nullable, nonatomic, copy) NSString *ime;
@property (nonatomic) BOOL izabranaIshrana;
@property (nullable, nonatomic, copy) NSString *nDorucak;
@property (nullable, nonatomic, copy) NSString *nRucak;
@property (nullable, nonatomic, copy) NSString *nUzina;
@property (nullable, nonatomic, copy) NSString *nUzina2;
@property (nullable, nonatomic, copy) NSString *nVecera;
@property (nullable, nonatomic, copy) NSString *pDorucak;
@property (nullable, nonatomic, copy) NSString *petDorucak;
@property (nullable, nonatomic, copy) NSString *petRucak;
@property (nullable, nonatomic, copy) NSString *petUzina;
@property (nullable, nonatomic, copy) NSString *petUzina2;
@property (nullable, nonatomic, copy) NSString *petVecera;
@property (nullable, nonatomic, copy) NSString *pRucak;
@property (nullable, nonatomic, copy) NSString *pUzina;
@property (nullable, nonatomic, copy) NSString *pUzina2;
@property (nullable, nonatomic, copy) NSString *pVecera;
@property (nullable, nonatomic, copy) NSString *sDorucak;
@property (nullable, nonatomic, copy) NSString *sRucak;
@property (nullable, nonatomic, copy) NSString *subDorucak;
@property (nullable, nonatomic, copy) NSString *subRucak;
@property (nullable, nonatomic, copy) NSString *subUzina;
@property (nullable, nonatomic, copy) NSString *subUzina2;
@property (nullable, nonatomic, copy) NSString *subVecera;
@property (nullable, nonatomic, copy) NSString *sUzina;
@property (nullable, nonatomic, copy) NSString *sUzina2;
@property (nullable, nonatomic, copy) NSString *sVecera;
@property (nullable, nonatomic, copy) NSString *uDorucak;
@property (nullable, nonatomic, copy) NSString *uRucak;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *uUzina;
@property (nullable, nonatomic, copy) NSString *uUzina2;
@property (nullable, nonatomic, copy) NSString *uVecera;
@property (nullable, nonatomic, copy) NSString *vremeDorucka;
@property (nullable, nonatomic, copy) NSString *vremeRucka;
@property (nullable, nonatomic, copy) NSString *vremeUzine;
@property (nullable, nonatomic, copy) NSString *vremeUzine2;
@property (nullable, nonatomic, copy) NSString *vremeVecere;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
