//
//  ViewController.m
//  ApplePayDemo
//
//  Created by zybug on 16/2/23.
//  Copyright © 2016年 zybug.com. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ViewController


// 弹出支付按钮
- (IBAction)btnClick:(UIButton *)sender {
    
    // 检测是否可以使用Apple Pay
    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        NSLog(@"设备支持Apple Pay");
        
        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
        
        PKPaymentSummaryItem *item1 = [PKPaymentSummaryItem summaryItemWithLabel:@"美女1名" amount:[NSDecimalNumber decimalNumberWithString:@"2000000.00"]];
        
        PKPaymentSummaryItem *item2 = [PKPaymentSummaryItem summaryItemWithLabel:@"iPad Pro 1台" amount:[NSDecimalNumber decimalNumberWithString:@"5688.00"]];
        
        PKPaymentSummaryItem *item3 = [PKPaymentSummaryItem summaryItemWithLabel:@"豪车1辆" amount:[NSDecimalNumber decimalNumberWithString:@"6660000.00"]];
        
        PKPaymentSummaryItem *item4 = [PKPaymentSummaryItem summaryItemWithLabel:@"豪宅1座" amount:[NSDecimalNumber decimalNumberWithString:@"20000000.00"]];
        
        PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"Pay Demo" amount:[NSDecimalNumber decimalNumberWithString:@"9999999.00"]];
        
        request.paymentSummaryItems = @[item1, item2, item3, item4, total];
        request.countryCode = @"CN";
        request.currencyCode = @"CNY";
        // 支持卡的类型
        request.supportedNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkChinaUnionPay];
        request.merchantIdentifier = @"com.zybug.applepaydemo";
        request.merchantCapabilities = PKMerchantCapabilityCredit |
                                       PKMerchantCapabilityDebit ;
        
        // 账单地址
//        request.requiredBillingAddressFields =  PKAddressFieldEmail |
//                                                PKAddressFieldPostalAddress;
//        request.requiredShippingAddressFields = PKAddressFieldAll;
        
        PKPaymentAuthorizationViewController *paymentVC = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        paymentVC.delegate = self;
        [self presentViewController:paymentVC animated:YES completion:nil];
        
    }else {
        NSLog(@"设备不支持Apple Pay");
    }
    
}

#pragma mark - Delegate

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion{
    
    NSLog(@"Payment:%@",payment);
    
    // 请求服务器获取支付结果
    BOOL paySuccess = YES;
    /*
     PKPaymentAuthorizationStatusSuccess, // Merchant auth'd (or expects to auth) the transaction successfully.
     PKPaymentAuthorizationStatusFailure, // Merchant failed to auth the transaction.
     
     PKPaymentAuthorizationStatusInvalidBillingPostalAddress,  // Merchant refuses service to this billing address.
     PKPaymentAuthorizationStatusInvalidShippingPostalAddress, // Merchant refuses service to this shipping address.
     PKPaymentAuthorizationStatusInvalidShippingContact,       // Supplied contact information is insufficient.
     
     PKPaymentAuthorizationStatusPINRequired NS_ENUM_AVAILABLE(NA, 9_2),  // Transaction requires PIN entry.
     PKPaymentAuthorizationStatusPINIncorrect NS_ENUM_AVAILABLE(NA, 9_2), // PIN was not entered correctly, retry.
     PKPaymentAuthorizationStatusPINLockout NS_ENUM_AVAILABLE(NA, 9_2)    // PIN retry limit exceeded.
     */
    if (paySuccess) {
        completion(PKPaymentAuthorizationStatusSuccess);
        NSLog(@"支付成功");
    }else{
        completion(PKPaymentAuthorizationStatusFailure);
    }
    
    
    
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    
    NSLog(@"payment finish");
    
    [controller dismissViewControllerAnimated:YES completion:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"支付完成" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定x" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:^(){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
    }];
}


/*
 contain a property 'countryCode' of type 'NSString' within '(
 AD,
 AE,
 AF,
 AG,
 AI,
 AL,
 AM,
 AO,
 AQ,
 AR,
 AS,
 AT,
 AU,
 AW,
 AX,
 AZ,
 BA,
 BB,
 BD,
 BE,
 BF,
 BG,
 BH,
 BI,
 BJ,
 BL,
 BM,
 BN,
 BO,
 BQ,
 BR,
 BS,
 BT,
 BV,
 BW,
 BY,
 BZ,
 CA,
 CC,
 CD,
 CF,
 CG,
 CH,
 CI,
 CK,
 CL,
 CM,
 CN,
 CO,
 CR,
 CU,
 CV,
 CW,
 CX,
 CY,
 CZ,
 DE,
 DJ,
 DK,
 DM,
 DO,
 DZ,
 EC,
 EE,
 EG,
 EH,
 ER,
 ES,
 ET,
 FI,
 FJ,
 FK,
 FM,
 FO,
 FR,
 GA,
 GB,
 GD,
 GE,
 GF,
 GG,
 GH,
 GI,
 GL,
 GM,
 GN,
 GP,
 GQ,
 GR,
 GS,
 GT,
 GU,
 GW,
 GY,
 HK,
 HM,
 HN,
 HR,
 HT,
 HU,
 ID,
 IE,
 IL,
 IM,
 IN,
 IO,
 IQ,
 IR,
 IS,
 IT,
 JE,
 JM,
 JO,
 JP,
 KE,
 KG,
 KH,
 KI,
 KM,
 KN,
 KP,
 KR,
 KW,
 KY,
 KZ,
 LA,
 LB,
 LC,
 LI,
 LK,
 LR,
 LS,
 LT,
 LU,
 LV,
 LY,
 MA,
 MC,
 MD,
 ME,
 MF,
 MG,
 MH,
 MK,
 ML,
 MM,
 MN,
 MO,
 MP,
 MQ,
 MR,
 MS,
 MT,
 MU,
 MV,
 MW,
 MX,
 MY,
 MZ,
 NA,
 NC,
 NE,
 NF,
 NG,
 NI,
 NL,
 NO,
 NP,
 NR,
 NU,
 NZ,
 OM,
 PA,
 PE,
 PF,
 PG,
 PH,
 PK,
 PL,
 PM,
 PN,
 PR,
 PS,
 PT,
 PW,
 PY,
 QA,
 RE,
 RO,
 RS,
 RU,
 RW,
 SA,
 SB,
 SC,
 SD,
 SE,
 SG,
 SH,
 SI,
 SJ,
 SK,
 SL,
 SM,
 SN,
 SO,
 SR,
 SS,
 ST,
 SV,
 SX,
 SY,
 SZ,
 TC,
 TD,
 TF,
 TG,
 TH,
 TJ,
 TK,
 TL,
 TM,
 TN,
 TO,
 TR,
 TT,
 TV,
 TW,
 TZ,
 UA,
 UG,
 UM,
 US,
 UY,
 UZ,
 VA,
 VC,
 VE,
 VG,
 VI,
 VN,
 VU,
 WF,
 WS,
 YE,
 YT,
 ZA,
 ZM,
 ZW
 )'"
 
 */


@end
