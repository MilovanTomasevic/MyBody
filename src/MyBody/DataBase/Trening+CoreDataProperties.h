//
//  Trening+CoreDataProperties.h
//  MyBody
//
//  Created by Milovan Tomasevic on 09/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//
//

#import "Trening+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Trening (CoreDataProperties)

+ (NSFetchRequest<Trening *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *datumUnosa;
@property (nullable, nonatomic, copy) NSString *ime;
@property (nonatomic) BOOL izabraniTrening;
@property (nullable, nonatomic, copy) NSString *t1Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t2Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t3Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t4Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t5Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t6Sadrzaj;
@property (nullable, nonatomic, copy) NSString *t7Sadrzaj;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *t1Fokus;
@property (nullable, nonatomic, copy) NSString *t2Fokus;
@property (nullable, nonatomic, copy) NSString *t3Fokus;
@property (nullable, nonatomic, copy) NSString *t4Fokus;
@property (nullable, nonatomic, copy) NSString *t5Fokus;
@property (nullable, nonatomic, copy) NSString *t6Fokus;
@property (nullable, nonatomic, copy) NSString *t7Fokus;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
