//
//  CoreDataManager.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "CoreDataManager.h"




@implementation CoreDataManager{
    AppDelegate *appDelegate;
}
@synthesize managedObjectContext;


- (id)init{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}


//------------------------------------------------------ USER -------------------------------------------------------------------

-(void)addOrUpdateUserEmail:(NSString*)mail sifra:(NSString*)pass ime:(NSString*)ime prezime:(NSString*)prezime adresa:(NSString*)adresa grad:(NSString*)grad postanskiKod:(NSString*)kod telefon:(NSString*)telefon sigurnosnoPitanje:(NSString*)pitanje sigurnosniOdgovor:(NSString*)odgovor{
    
    User *user = [self getUserWithMail:mail];
    
    if (user){
        
        user.mail = mail;
        user.sifra =pass;
        user.ime = ime;
        user.prezime = prezime;
        user.adresa = adresa;
        user.grad = grad;
        user.postanskiKod = kod;
        user.telefon = telefon;
        user.sPitanje = pitanje;
        user.sOdgovor = odgovor;
        
    }else {
        
        User *user = (User*) [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY_NAME inManagedObjectContext:managedObjectContext];
        
        if (mail != nil) {
            [user setMail:mail];
        }
        if (pass != nil) {
            [user setSifra:pass];
        }
        if (ime != nil) {
            [user setIme:ime];
        }
        if (prezime != nil) {
            [user setPrezime:prezime];
        }
        if (adresa != nil) {
            [user setAdresa:adresa];
        }
        if (grad != nil) {
            [user setGrad:grad];
        }
        if (kod != nil) {
            [user setPostanskiKod:kod];
        }
        if (telefon != nil) {
            [user setTelefon:telefon];
        }
        if (pitanje != nil) {
            [user setTelefon:pitanje];
        }
        if (odgovor != nil) {
            [user setTelefon:odgovor];
        }
    }
}

-(User*)loginUser:(NSString*)email password:(NSString*)pass{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"mail == %@ && sifra == %@",email ,pass];
    [fetch setPredicate:pred];
    NSArray *users = [managedObjectContext executeFetchRequest:fetch error:nil];
    
    if (users.count!=0) {
        return [users objectAtIndex:0];
    }else{
        return nil;
    }
}


-(User*)getUserWithMail:(NSString*)email{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"mail == %@",email];
    [fetch setPredicate:pred];
    NSArray *users = [managedObjectContext executeFetchRequest:fetch error:nil];
    if (users.count!=0) {
        return [users objectAtIndex:0];
    }else{
        return nil;
    }
}

-(User*)getNewUser{
    NSEntityDescription *entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    User *newUser = [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    return newUser;
}

-(NSArray*)getAllUsers{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSArray *users = [managedObjectContext executeFetchRequest:fetch error:nil];
    return users;
}

-(void)removeUserWithMail:(NSString*)email{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"mail == %@",email];
    [fetch setPredicate:pred];
    NSArray *users = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in users) {
        [managedObjectContext deleteObject:m];
    }
    
}

//------------------------------------------------------ TRENING ----------------------------------------------------------------

-(void)addOrUpdateTreningName:(NSString*)ime forUserEmail:(NSString*)userMail datumUnosa:(NSString*)datum t1:(NSString*)t1 t2:(NSString*)t2 t3:(NSString*)t3 t4:(NSString*)t4 t5:(NSString*)t5 t6:(NSString*)t6 t7:(NSString*)t7 f1:(NSString*)f1 f2:(NSString*)f2 f3:(NSString*)f3 f4:(NSString*)f4 f5:(NSString*)f5 f6:(NSString*)f6 f7:(NSString*)f7 izabran:(BOOL)izabran {
    
    Trening *trening = [self getTreningForName:ime];

    
    if(trening){
        trening.ime = ime;
        trening.userID = userMail;
        trening.datumUnosa = datum;
        trening.t1Sadrzaj = t1;
        trening.t2Sadrzaj = t2;
        trening.t3Sadrzaj = t3;
        trening.t4Sadrzaj = t4;
        trening.t5Sadrzaj = t5;
        trening.t6Sadrzaj = t6;
        trening.t7Sadrzaj = t7;
        trening.t1Fokus = f1;
        trening.t2Fokus = f2;
        trening.t3Fokus = f3;
        trening.t4Fokus = f4;
        trening.t5Fokus = f5;
        trening.t6Fokus = f6;
        trening.t7Fokus = f7;
        trening.izabraniTrening = [NSNumber numberWithBool:izabran];
    }else{
        Trening *trening = (Trening*) [NSEntityDescription insertNewObjectForEntityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
        if (ime != nil) {
            [trening setIme:ime];
        }
        if (userMail != nil) {
            [trening setUserID:userMail];
        }
        if (datum != nil) {
            [trening setDatumUnosa:datum];
        }
        if (t1 != nil) {
            [trening setT1Sadrzaj:t1];
        }
        if (t2 != nil) {
            [trening setT2Sadrzaj:t2];
        }
        if (t3 != nil) {
            [trening setT3Sadrzaj:t3];
        }
        if (t4 != nil) {
            [trening setT4Sadrzaj:t4];
        }
        if (t5 != nil) {
            [trening setT5Sadrzaj:t5];
        }
        if (t6 != nil) {
            [trening setT6Sadrzaj:t6];
        }
        if (t7 != nil) {
            [trening setT7Sadrzaj:t7];
        }
        if (f1 != nil) {
            [trening setT1Fokus:f1];
        }
        if (f2 != nil) {
            [trening setT2Fokus:f2];
        }
        if (f3 != nil) {
            [trening setT3Fokus:f3];
        }
        if (f4 != nil) {
            [trening setT4Fokus:f4];
        }
        if (f5 != nil) {
            [trening setT5Fokus:f5];
        }
        if (f6 != nil) {
            [trening setT6Fokus:f6];
        }
        if (f7 != nil) {
            [trening setT7Fokus:f7];
        }
        if (izabran) {
            [trening setIzabraniTrening:izabran];
        }
    }
}


-(Trening*)getTreningForName:(NSString*)name{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *trening = [managedObjectContext executeFetchRequest:fetch error:nil];
    if (trening.count!=0) {
        return [trening objectAtIndex:0];
    }else{
        return nil;
    }
}


-(Trening*)getNewTrening{
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    Trening *newTrening = [[Trening alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    return newTrening;
}


-(NSArray*)getAllTreninge{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSArray *treninzi = [managedObjectContext executeFetchRequest:fetch error:nil];
    return treninzi;
}

-(NSArray*)getAllTreningeForUserEmail:(NSString*)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    //    //sort gateway by serial ID
    //    NSArray *sortDescriptors = @[
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"isAvailableInLocal" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"deviceStatus" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"serialID" ascending:YES]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    //[fetch setSortDescriptors:sortDescriptors];
    NSArray *treninzi = [managedObjectContext executeFetchRequest:fetch error:nil];
    return treninzi;
}



-(Trening*)getIzabraniTreningForUserEmail:(NSString *)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@ && izabraniTrening == %@",userEmail, [NSNumber numberWithBool:YES]];
    [fetch setPredicate:pred];
    NSArray *treninzi = [managedObjectContext executeFetchRequest:fetch error:nil];
    Trening *t;
    if (treninzi.count != 0) {
        t=[treninzi objectAtIndex:0];
    }
    return t;
}


-(void)removeTreningForUser:(NSString*)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    NSArray *trening = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in trening) {
        [managedObjectContext deleteObject:m];
    }
}

-(void)removeTreningWithName:(NSString*)name{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TRENING_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *trening = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in trening) {
        [managedObjectContext deleteObject:m];
    }
}



//------------------------------------------------------ ISHRANA -------------------------------------------------------------------



-(void)addOrUpdateInshranaName:(NSString*)ime forUserEmail:(NSString*)userMail datumUnosa:(NSString*)datum vremeDorucka:(NSString*)dVreme vremeUzine:(NSString*)uVreme vremeRucka:(NSString*)rVreme vremeDrugeUzine:(NSString*)drUzinaVreme vremeVecere:(NSString*)vVreme pDorucak:(NSString*)pDorucak pUzina:(NSString*)pUzina pRucak:(NSString*)pRucak pUzina2:(NSString*)pUzina2 pVecera:(NSString*)pVecera uDorucak:(NSString*)uDorucak uUzina:(NSString*)uUzina uRucak:(NSString*)uRucak uUzina2:(NSString*)uUzina2 uVecera:(NSString*)uVecera sDorucak:(NSString*)sDorucak sUzina:(NSString*)sUzina sRucak:(NSString*)sRucak sUzina2:(NSString*)sUzina2 sVecera:(NSString*)sVecera cDorucak:(NSString*)cDorucak cUzina:(NSString*)cUzina cRucak:(NSString*)cRucak cUzina2:(NSString*)cUzina2 cVecera:(NSString*)cVecera peDorucak:(NSString*)peDorucak peUzina:(NSString*)peUzina peRucak:(NSString*)peRucak peUzina2:(NSString*)peUzina2 peVecera:(NSString*)peVecera suDorucak:(NSString*)suDorucak suUzina:(NSString*)suUzina suRucak:(NSString*)suRucak suUzina2:(NSString*)suUzina2 suVecera:(NSString*)suVecera nDorucak:(NSString*)nDorucak nUzina:(NSString*)nUzina nRucak:(NSString*)nRucak nUzina2:(NSString*)nUzina2 nVecera:(NSString*)nVecera izabrana:(BOOL)izabrana{
    
    Ishrana *ish = [self getIshranaForName:ime];
    
    
    if(ish){
        ish.ime = ime;
        ish.userID = userMail;
        ish.datumUnosa = datum;
        
        ish.vremeDorucka = dVreme;
        ish.vremeUzine = uVreme;
        ish.vremeRucka = rVreme;
        ish.vremeUzine2 = drUzinaVreme;
        ish.vremeVecere = vVreme;
        
        ish.pDorucak = pDorucak;
        ish.pUzina = pUzina;
        ish.pRucak = pRucak;
        ish.pUzina2 = pUzina2;
        ish.pVecera = pVecera;

        ish.uDorucak = uDorucak;
        ish.uUzina = uUzina;
        ish.uRucak = uRucak;
        ish.uUzina2 = uUzina2;
        ish.uVecera = uVecera;
        
        ish.sDorucak = sDorucak;
        ish.sUzina = sUzina;
        ish.sRucak = sRucak;
        ish.sUzina2 = sUzina2;
        ish.sVecera = sVecera;
        
        ish.cDorucak = cDorucak;
        ish.cUzina = cUzina;
        ish.cRucak = cRucak;
        ish.cUzina2 = cUzina2;
        ish.cVecera = cVecera;
        
        ish.petDorucak = peDorucak;
        ish.petUzina = peUzina;
        ish.petRucak = peRucak;
        ish.petUzina2 = peUzina2;
        ish.petVecera = peVecera;
        
        ish.subDorucak = suDorucak;
        ish.subUzina = suUzina;
        ish.subRucak = suRucak;
        ish.subUzina2 = suUzina2;
        ish.subVecera = suVecera;
        
        ish.nDorucak = nDorucak;
        ish.nUzina = nUzina;
        ish.nRucak = nRucak;
        ish.nUzina2 = nUzina2;
        ish.nVecera = nVecera;
        ish.izabranaIshrana = [NSNumber numberWithBool:izabrana];
    }else{
        Ishrana *ish = (Ishrana*) [NSEntityDescription insertNewObjectForEntityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
        if (ime != nil) {
            [ish setIme:ime];
        }
        if (userMail != nil) {
            [ish setUserID:userMail];
        }
        if (datum != nil) {
            [ish setDatumUnosa:datum];
        }
        
        if (dVreme != nil) {
            [ish setVremeDorucka:dVreme];
        }
        if (uVreme != nil) {
            [ish setVremeUzine:uVreme];
        }
        if (rVreme != nil) {
            [ish setVremeDorucka:rVreme];
        }
        if (drUzinaVreme != nil) {
            [ish setVremeUzine2:drUzinaVreme];
        }
        if (vVreme != nil) {
            [ish setVremeVecere:vVreme];
        }

        
        if (pDorucak != nil) {
            [ish setPDorucak:pDorucak];
        }
        if (pUzina != nil) {
            [ish setPUzina:pUzina];
        }
        if (pRucak != nil) {
            [ish setPRucak:pRucak];
        }
        if (pUzina2 != nil) {
            [ish setPUzina2:pUzina2];
        }
        if (pVecera != nil) {
            [ish setPVecera:pVecera];
        }
        
        if (uDorucak != nil) {
            [ish setUDorucak:uDorucak];
        }
        if (uUzina != nil) {
            [ish setUUzina:uUzina];
        }
        if (uRucak != nil) {
            [ish setURucak:uRucak];
        }
        if (uUzina2 != nil) {
            [ish setUUzina2:uUzina2];
        }
        if (uVecera != nil) {
            [ish setUVecera:uVecera];
        }
        
        if (sDorucak != nil) {
            [ish setSDorucak:sDorucak];
        }
        if (sUzina != nil) {
            [ish setSUzina:sUzina];
        }
        if (sRucak != nil) {
            [ish setSRucak:sRucak];
        }
        if (sUzina2 != nil) {
            [ish setSUzina2:sUzina2];
        }
        if (sVecera != nil) {
            [ish setSVecera:sVecera];
        }
        
        if (cDorucak != nil) {
            [ish setCDorucak:cDorucak];
        }
        if (cUzina != nil) {
            [ish setCUzina:cUzina];
        }
        if (cRucak != nil) {
            [ish setCRucak:cRucak];
        }
        if (cUzina2 != nil) {
            [ish setCUzina2:cUzina2];
        }
        if (cVecera != nil) {
            [ish setCVecera:cVecera];
        }

        if (peDorucak != nil) {
            [ish setPetDorucak:peDorucak];
        }
        if (peUzina != nil) {
            [ish setPetUzina:peUzina];
        }
        if (peRucak != nil) {
            [ish setPetRucak:peRucak];
        }
        if (peUzina2 != nil) {
            [ish setPetUzina2:peUzina2];
        }
        if (peVecera != nil) {
            [ish setPetVecera:peVecera];
        }
        
        if (suDorucak != nil) {
            [ish setSubDorucak:suDorucak];
        }
        if (suUzina != nil) {
            [ish setSubUzina:suUzina];
        }
        if (suRucak != nil) {
            [ish setSubRucak:suRucak];
        }
        if (suUzina2 != nil) {
            [ish setSubUzina2:suUzina2];
        }
        if (suVecera != nil) {
            [ish setSubVecera:suVecera];
        }
        
        if (nDorucak != nil) {
            [ish setNDorucak:nDorucak];
        }
        if (nUzina != nil) {
            [ish setNUzina:nUzina];
        }
        if (nRucak != nil) {
            [ish setNRucak:nRucak];
        }
        if (nUzina2 != nil) {
            [ish setNUzina2:nUzina2];
        }
        if (nVecera != nil) {
            [ish setNVecera:nVecera];
        }
        
        if (izabrana) {
            [ish setIzabranaIshrana:izabrana];
        }
    }
}


-(Ishrana*)getIshranaForName:(NSString*)name{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *ishrana = [managedObjectContext executeFetchRequest:fetch error:nil];
    if (ishrana.count!=0) {
        return [ishrana objectAtIndex:0];
    }else{
        return nil;
    }
}

-(Ishrana*)getNewIshrana{
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    Ishrana *newIshrana = [[Ishrana alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    return newIshrana;
}

-(NSArray*)getAllIshrane{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSArray *ishrane = [managedObjectContext executeFetchRequest:fetch error:nil];
    return ishrane;
}

-(NSArray*)getAllIshraneForUserEmail:(NSString*)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    //    //sort gateway by serial ID
    //    NSArray *sortDescriptors = @[
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"isAvailableInLocal" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"deviceStatus" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"serialID" ascending:YES]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    //[fetch setSortDescriptors:sortDescriptors];
    NSArray *ishrane = [managedObjectContext executeFetchRequest:fetch error:nil];
    return ishrane;
}

//-(NSArray *)getIzabranaIshrana{
//    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
//    [fetch setEntity:entity];
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"izabranaIshrana == %@",[NSNumber numberWithBool:YES]];
//    [fetch setPredicate:pred];
//    NSArray *ishrana = [managedObjectContext executeFetchRequest:fetch error:nil];
//    if (ishrana.count != 0) {
//        return [ishrana objectAtIndex:0];
//    }else{
//        return nil;
//    }
//}

-(Ishrana*)getIzabranaIshranaForUserEmail:(NSString *)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@ && izabranaIshrana == %@",userEmail, [NSNumber numberWithBool:YES]];
    [fetch setPredicate:pred];
    NSArray *ishrane = [managedObjectContext executeFetchRequest:fetch error:nil];
    Ishrana *ish;
    if (ishrane.count != 0) {
        ish=[ishrane objectAtIndex:0];
    }
    return ish;
}


-(void)removeIshranaForUser:(NSString*)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    NSArray *ishrana = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in ishrana) {
        [managedObjectContext deleteObject:m];
    }
}

-(void)removeIshranaWithName:(NSString*)name{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ISHRANA_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in mere) {
        [managedObjectContext deleteObject:m];
    }
}



//------------------------------------------------------ MERE -------------------------------------------------------------------



-(void)addOrUpdateMerenjeName:(NSString*)ime forUserEmail:(NSString*)userMail datumMerenja:(NSString*)datum pol:(NSString*)pol godine:(NSString*)godine visina:(NSString*)visina tezina:(NSString*)tezina obimKuka:(NSString*)obimKuka obimGrudi:(NSString*)obimGrudi obimButina:(NSString*)obimButina bmi:(NSString*)bmi izabranaMera:(BOOL)izabrana{
    
    Mere *m = [self getMereForName:ime];
    
    
    if(m){
        m.ime = ime;
        m.userID = userMail;
        m.datumMerenja = datum;
        m.pol = pol;
        m.godine = godine;
        m.visina = visina;
        m.tezina = tezina;
        m.obimKuka = obimKuka;
        m.obimGrudi = obimGrudi;
        m.obimButina = obimButina;
        m.bmi = bmi;
        m.izabranaMera = [NSNumber numberWithBool:izabrana];
    }else{
        Mere *mera = (Mere*) [NSEntityDescription insertNewObjectForEntityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
        if (ime != nil) {
            [mera setIme:ime];
        }
        if (userMail != nil) {
            [mera setUserID:userMail];
        }
        if (datum != nil) {
            [mera setDatumMerenja:datum];
        }
        if (pol != nil) {
            [mera setPol:pol];
        }
        if (godine != nil) {
            [mera setGodine:godine];
        }
        if (visina != nil) {
            [mera setVisina:visina];
        }
        if (tezina != nil) {
            [mera setTezina:tezina];
        }
        if (obimKuka != nil) {
            [mera setObimKuka:obimKuka];
        }
        if (obimGrudi != nil) {
            [mera setObimGrudi:obimGrudi];
        }
        if (obimButina != nil) {
            [mera setObimButina:obimButina];
        }
        if (bmi != nil) {
            [mera setBmi:bmi];
        }
        if (izabrana) {
            [mera setIzabranaMera:izabrana];
        }
    }
}



-(Mere*)getMereForName:(NSString*)name{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    if (mere.count!=0) {
        return [mere objectAtIndex:0];
    }else{
        return nil;
    }
}

-(Mere*)getNewMere{
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    Mere *newMere = [[Mere alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    return newMere;
}

-(NSArray*)getAllMere{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    return mere;
}

-(NSArray*)getAllMereForUserEmail:(NSString*)userEmail{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    //    //sort gateway by serial ID
    //    NSArray *sortDescriptors = @[
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"isAvailableInLocal" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"deviceStatus" ascending:NO],
    //                                 [NSSortDescriptor sortDescriptorWithKey:@"serialID" ascending:YES]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    //[fetch setSortDescriptors:sortDescriptors];
    NSArray *merenja = [managedObjectContext executeFetchRequest:fetch error:nil];
    return merenja;
}



-(Mere*)getIzabranaMeraForUserEmail:(NSString *)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@ && izabranaMera == %@",userEmail, [NSNumber numberWithBool:YES]];
    [fetch setPredicate:pred];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    Mere *m;
    if (mere.count != 0) {
         m=[mere objectAtIndex:0];
    }
    return m;
}

-(void)removeMereForUser:(NSString*)userEmail{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"userID == %@",userEmail];
    [fetch setPredicate:pred];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in mere) {
        [managedObjectContext deleteObject:m];
    }
}

-(void)removeMereWithName:(NSString*)name{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:MERE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
    [fetch setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ime == %@",name];
    [fetch setPredicate:pred];
    NSArray *mere = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (NSManagedObject *m in mere) {
        [managedObjectContext deleteObject:m];
    }
}



@end

