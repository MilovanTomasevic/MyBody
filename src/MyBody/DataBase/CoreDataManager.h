//
//  CoreDataManager.h
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "User+CoreDataClass.h"
#import "Trening+CoreDataClass.h"
#import "Ishrana+CoreDataClass.h"
#import "Mere+CoreDataClass.h"

#define USER_ENTITY_NAME @"User"
#define TRENING_ENTITY_NAME @"Trening"
#define ISHRANA_ENTITY_NAME @"Ishrana"
#define MERE_ENTITY_NAME @"Mere"

@interface CoreDataManager : NSObject

@property(nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain,readonly) NSManagedObjectModel *managedObjectModel;





//********************************************************* USER METHOD ************************************//

-(void)addOrUpdateUserEmail:(NSString*)mail sifra:(NSString*)pass ime:(NSString*)ime prezime:(NSString*)prezime adresa:(NSString*)adresa grad:(NSString*)grad postanskiKod:(NSString*)kod telefon:(NSString*)telefon sigurnosnoPitanje:(NSString*)pitanje sigurnosniOdgovor:(NSString*)odgovor;
-(User*)loginUser:(NSString*)email password:(NSString*)pass;
-(User*)getUserWithMail:(NSString*)email;
-(User*)getNewUser;
-(NSArray*)getAllUsers;
-(void)removeUserWithMail:(NSString*)email;



//********************************************************* TRENING METHOD ************************************//

-(void)addOrUpdateTreningName:(NSString*)ime forUserEmail:(NSString*)userMail datumUnosa:(NSString*)datum t1:(NSString*)t1 t2:(NSString*)t2 t3:(NSString*)t3 t4:(NSString*)t4 t5:(NSString*)t5 t6:(NSString*)t6 t7:(NSString*)t7 f1:(NSString*)f1 f2:(NSString*)f2 f3:(NSString*)f3 f4:(NSString*)f4 f5:(NSString*)f5 f6:(NSString*)f6 f7:(NSString*)f7 izabran:(BOOL)izabran;
-(Trening*)getTreningForName:(NSString*)name;
-(Trening*)getNewTrening;
-(NSArray*)getAllTreninge;
-(NSArray*)getAllTreningeForUserEmail:(NSString*)userEmail;
-(Trening*)getIzabraniTreningForUserEmail:(NSString *)userEmail;
-(void)removeTreningForUser:(NSString*)userEmail;
-(void)removeTreningWithName:(NSString*)name;


//********************************************************* ISHRANA METHOD ************************************//
-(void)addOrUpdateInshranaName:(NSString*)ime forUserEmail:(NSString*)userMail datumUnosa:(NSString*)datum vremeDorucka:(NSString*)dVreme vremeUzine:(NSString*)uVreme vremeRucka:(NSString*)rVreme vremeDrugeUzine:(NSString*)drUzina vremeVecere:(NSString*)vVreme pDorucak:(NSString*)pDorucak pUzina:(NSString*)pUzina pRucak:(NSString*)pRucak pUzina2:(NSString*)pUzina2 pVecera:(NSString*)pVecera uDorucak:(NSString*)uDorucak uUzina:(NSString*)uUzina uRucak:(NSString*)uRucak uUzina2:(NSString*)uUzina2 uVecera:(NSString*)uVecera sDorucak:(NSString*)sDorucak sUzina:(NSString*)sUzina sRucak:(NSString*)sRucak sUzina2:(NSString*)sUzina2 sVecera:(NSString*)sVecera cDorucak:(NSString*)cDorucak cUzina:(NSString*)cUzina cRucak:(NSString*)cRucak cUzina2:(NSString*)cUzina2 cVecera:(NSString*)cVecera peDorucak:(NSString*)peDorucak peUzina:(NSString*)peUzina peRucak:(NSString*)peRucak peUzina2:(NSString*)peUzina2 peVecera:(NSString*)peVecera suDorucak:(NSString*)suDorucak suUzina:(NSString*)suUzina suRucak:(NSString*)suRucak suUzina2:(NSString*)suUzina2 suVecera:(NSString*)suVecera nDorucak:(NSString*)nDorucak nUzina:(NSString*)nUzina nRucak:(NSString*)nRucak nUzina2:(NSString*)nUzina2 nVecera:(NSString*)nVecera izabrana:(BOOL)izabrana;
-(Ishrana*)getIshranaForName:(NSString*)name;
-(Ishrana*)getNewIshrana;
-(NSArray*)getAllIshrane;
-(NSArray*)getAllIshraneForUserEmail:(NSString*)userEmail;
-(Ishrana*)getIzabranaIshranaForUserEmail:(NSString *)userEmail;
-(void)removeIshranaForUser:(NSString*)userEmail;
-(void)removeIshranaWithName:(NSString*)name;


//********************************************************* MERE METHOD ************************************//

-(void)addOrUpdateMerenjeName:(NSString*)ime forUserEmail:(NSString*)userMail datumMerenja:(NSString*)datum pol:(NSString*)pol godine:(NSString*)godine visina:(NSString*)visina tezina:(NSString*)tezina obimKuka:(NSString*)obimKuka obimGrudi:(NSString*)obimGrudi obimButina:(NSString*)obimButina bmi:(NSString*)bmi izabranaMera:(BOOL)izabrana;
-(Mere*)getMereForName:(NSString*)name;
-(Mere*)getNewMere;
-(NSArray*)getAllMere;
-(NSArray*)getAllMereForUserEmail:(NSString*)userEmail;
-(Mere*)getIzabranaMeraForUserEmail:(NSString *)userEmail;
-(void)removeMereForUser:(NSString*)userEmail;
-(void)removeMereWithName:(NSString*)name;



@end

