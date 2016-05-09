//
//  ViewController.m
//  MHWAlertToLink
//
//  Created by 橋本学 on 2016/05/09.
//  Copyright © 2016年 MANABU HASHIMOTO WORKS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onReturn:(id)sender {
    [sender resignFirstResponder];
    [self alertToLink];
}

- (IBAction)onViewTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onAlertToLink:(id)sender {
    [self alertToLink];
}

- (IBAction)onOpenDirectToLink:(id)sender {
    [self openDirectToLink];
}

- (void)alertToLink {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@""
                                        message:[NSString stringWithFormat:@"%@ へ遷移しますか？", self.urlTextField.text]
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:
     [UIAlertAction actionWithTitle:@"いいえ"
                              style:UIAlertActionStyleDefault // Boldにしない
                            handler:nil]];
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"はい"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
#if 0   // Error
                                [self openDirectToLink];
#else
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self openDirectToLink];
                                });
#endif
                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)openDirectToLink {
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    [[UIApplication sharedApplication] openURL:url];
}

@end
