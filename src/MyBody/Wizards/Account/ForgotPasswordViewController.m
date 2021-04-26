//
//  ForgotPasswordViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 06/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController (){
    NSString  *mailString, *brTelString, *sOdgovorString, *passString;
}

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.user = [self.coreDataManager getNewUser];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Recovery",nil)
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(recoveryPass)];
    
    CGFloat sirinaPolja = self.view.frame.size.width * 0.7;
    int visinaPolja = 45;
    
    
    self.mailField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.navigationController.navigationBar.frame)+kMarginDefault, sirinaPolja, visinaPolja)];
    
    self.brojTelField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.mailField.frame)+kMarginDefault/2, sirinaPolja, visinaPolja)];
    
    self.sPitanjeField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.brojTelField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];
    
    self.sOdgovorField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.sPitanjeField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];
    
    [self.mailField customizeFansyField:self.mailField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_1a",nil) border:YES radius:YES changeColoc:YES];
    [self.brojTelField customizeFansyField:self.brojTelField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_4a",nil) border:YES radius:YES changeColoc:YES];
    
    [self.sPitanjeField customizeFansyField:self.sPitanjeField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_4c",nil) border:YES radius:YES changeColoc:YES];
    self.sPitanjeField.userInteractionEnabled = NO;
    
    [self.sOdgovorField customizeFansyField:self.sOdgovorField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_4b",nil) border:YES radius:YES changeColoc:YES];
    
    self.mailField.tag = 1;
    self.mailField.delegate = self;
    
    self.brojTelField.tag = 2;
    self.brojTelField.delegate = self;
    
    self.sPitanjeField.tag = 3;
    self.sPitanjeField.delegate = self;
    
    self.sOdgovorField.tag = 4;
    self.sOdgovorField.delegate = self;
}

-(void)recoveryPass
{
    LogI(@"recoveryPass button clicked");
    
    mailString    = self.mailField.text;
    mailString    = [mailString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    brTelString  = self.brojTelField.text;
    brTelString    = [brTelString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    sOdgovorString  = self.sOdgovorField.text;
    sOdgovorString    = [sOdgovorString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];

    self.user = [self.coreDataManager getUserWithMail:mailString];
    
    if (![MTSupport validateEmail:mailString]) {
        [ALERT_PRESENTER presentAlertWithTitle:@"Error" message:@"Uneta adresa nije dobrog formata."];
        return;
    }
    
    if(self.user == nil){
        [ALERT_PRESENTER presentAlertWithTitle:@"Error" message:@"Ne postoji korisnik sa unetom adresom"];
        return;
    }
    
    if(![brTelString isEqualToString:self.user.telefon]){
        [ALERT_PRESENTER presentAlertWithTitle:@"Error" message:@"Broj koji ste uneli je pogresan."];
        return;
    }
    
    if(![sOdgovorString isEqualToString:self.user.sOdgovor]){
        [ALERT_PRESENTER presentAlertWithTitle:@"Error" message:@"Odgovor je netacan!!!"];
        return;
    }
    
    
    passString  = [NSString stringWithFormat:NSLocalizedString(@"Vasa lozinka je: %@", nil), self.user.sifra ];
    
    [ALERT_PRESENTER presentAlertWithTitle:@"Oporavak lozinke" message:passString];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textFieldDidEndEditing:(MTFansyTextField *)textField
{
    if(textField.tag==2) // textfield 1
    {
        mailString    = self.mailField.text;
        mailString    = [mailString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        brTelString  = self.brojTelField.text;
        brTelString    = [brTelString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        self.user = [self.coreDataManager getUserWithMail:mailString];

        if (!(self.user == nil) && [self.user.telefon isEqualToString:brTelString]) {
            self.sPitanjeField.text = self.user.sPitanje;
            self.sPitanjeField.backgroundColor = [UIColor lightGrayColor];
        }
    }
}


@end
