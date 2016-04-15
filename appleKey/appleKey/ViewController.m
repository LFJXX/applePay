//
//  ViewController.m
//  appleKey
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>
@interface ViewController ()<PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL flag = [PKPaymentAuthorizationViewController canMakePayments];
    BOOL flag1 = [PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay] capabilities:PKMerchantCapabilityEMV|PKMerchantCapability3DS];
    BOOL flag2 = [PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay]];
    
    PKPaymentRequest  *request = [[PKPaymentRequest alloc] init];
    PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"jiaxinxin" amount:[NSDecimalNumber decimalNumberWithString:@"199"]];
    
    request.paymentSummaryItems = @[total];
    request.countryCode = @"CN";
    request.currencyCode = @"CNY";
    request.supportedNetworks = @[PKPaymentNetworkChinaUnionPay];
    request.merchantIdentifier = @"merchant.com.xinyongbao.payDemo";
    request.merchantCapabilities = PKMerchantCapabilityEMV|PKMerchantCapability3DS;
    // com.xinyongbao.PayDemo
    // merchant.com.company.test
    PKPaymentAuthorizationViewController *paymentSheet = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
    if (paymentSheet) {
        [self presentViewController:paymentSheet animated:YES completion:nil];
        paymentSheet.delegate = self;
    }
    
    
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion{

    NSData *data = payment.token.paymentData;
    NSDictionary *dicFormatToken = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil];
    
    if (dicFormatToken) {
        completion(PKPaymentAuthorizationStatusSuccess);
    }
    
    
}



- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
