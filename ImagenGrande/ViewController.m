//
//  ViewController.m
//  ImagenGrande
//
//  Created by cice on 22/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vistaImagen;
@property (weak, nonatomic) IBOutlet UIProgressView *barraProgreso;

@property (nonatomic) NSURLSessionDataTask *descargaImagen;

@property (nonatomic) NSTimer *timerBarraProgreso;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://i.pinimg.com/originals/d5/d5/ee/d5d5ee51e6da495d3615018c64b4f3fc.jpg"];
    
    
    /////////////////////
    // TODO ESTO NO TIENE NINGUN SENTIDO. SON SOLO MÉTODOS ILUSTRATIVOS DE COMO FUNCIONARÍAN LAS PETICIONES
    /////////////////////
    /*NSMutableURLRequest *peticionURL = [NSMutableURLRequest requestWithURL:url];
    peticionURL.HTTPMethod = @"GET"; //"GET" "PUT" "POST" "DELETE"
    
    peticionURL.HTTPBody = [@"Hola mundo" dataUsingEncoding:NSUTF8StringEncoding];
    peticionURL.allHTTPHeaderFields = @{@"Authorization:" : @"Basic nvkdsnvklsdnvldsnlvndsvnsdvnds=="};*/
    
    /// PARA GESTIÓN DE LA SESIÓN A MANO
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    config.URLCache = nil;
    config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    self.descargaImagen = [session dataTaskWithURL:url
                                                      completionHandler:^(NSData * _Nullable data,
                                                                          NSURLResponse * _Nullable response,
                                                                          NSError * _Nullable error)
                           {
                               if(error == nil)
                               {
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       self.vistaImagen.image = [UIImage imageWithData:data];
                                   }];
                               }
                           }];
    
    
    /// SESIÓN POR DEFECTO.
    /*self.descargaImagen = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                      completionHandler:^(NSData * _Nullable data,
                                                                          NSURLResponse * _Nullable response,
                                                                          NSError * _Nullable error)
    {
            if(error == nil)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.vistaImagen.image = [UIImage imageWithData:data];
                }];
            }
    }];*/
    
    [self.descargaImagen resume];
    
    self.timerBarraProgreso = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                              repeats:true
                                                                block:^(NSTimer * _Nonnull timer) {
                                                                    self.barraProgreso.progress = self.descargaImagen.progress.fractionCompleted;
                                                                }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
