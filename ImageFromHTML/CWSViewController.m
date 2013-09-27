//
//  CWSViewController.m
//  ImageFromHTML
//
//  Created by Cleber Santos on 26/09/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import "CWSViewController.h"

@interface CWSViewController ()

@end

@implementation CWSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // somente 1 imagem
    //_texto.text = @"<p>Eu:</p> <p><img alt=\"image\" src=\"http://media.tumblr.com/d3e8e6cb0f85d83676de7945fcdceb02/tumblr_inline_mnujg06JKu1qz4rgp.gif\" width=\"300\"/></p>";
    
    // mais de 1 imagem
    _texto.text= @"<p>Começa a subir:</p> <p><img alt=\"image\" src=\"http://media.tumblr.com/tumblr_mb8kvl3AQN1qgt8sq.gif\" title=\"Para com isso! PARAAAA!\"/></p> <p>Começa a cair:</p> <p><img alt=\"image\" src=\"http://31.media.tumblr.com/cef02921bc49b5362d4d296aa45ca4dd/tumblr_msxzx2mAGD1ql5yr7o2_250.gif\" title=\"Eu sou rica.\"/><img alt=\"image\" src=\"http://25.media.tumblr.com/239bab1e39ade9d3ed61fecc10bfcd2c/tumblr_msxzx2mAGD1ql5yr7o1_250.gif\"/></p> <p>Aproveita que o dólar tá dando uma trégua pra marcar o seu intercâmbio na IE. Dá uma olhada nas opções de destinos: <a href=\"http://www.ieintercambio.com.br/\"><a href=\"http://www.ieintercambio.com.br/\">http://www.ieintercambio.com.br/</a></a></p>";
    
}




/**
 *  Retorna todas as imagens dentro de um conteudo HTML
 *
 *  @param html HTML a ser procurado em formato NSString
 *  @return Lista de imagens em um NSArray
 */
- (NSArray *)getImagesFromHTML:(NSString *)html
{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"src=\"(.*?)\""//@"<img[^>]*>"
                                                                           options: NSRegularExpressionCaseInsensitive
                                                                             error: nil];
    
    NSInteger offset = 0;
    for (NSTextCheckingResult* result in [regex matchesInString: html
                                                        options: 0
                                                          range: NSMakeRange(0, [html length])]) {
        
        NSString *match = [regex replacementStringForResult: result
                                                   inString: html
                                                     offset: offset
                                                   template: @"$0"];
        
        match = [match stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        match = [match stringByReplacingOccurrencesOfString:@"src=" withString:@""];
        
        if (![match isEqualToString:@""]) {
            [images addObject: match];
        }
    }
    return images;
}



- (IBAction)extrair:(id)sender
{
    NSString *html = _texto.text;
    NSArray *images = [self getImagesFromHTML: html];
    NSLog(@"imagens encontradas: %@", images);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
