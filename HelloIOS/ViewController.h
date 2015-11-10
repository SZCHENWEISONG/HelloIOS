//
//  ViewController.h
//  HelloIOS
//
//  Created by Tony Chen on 15/2/25.
//  Copyright (c) 2015年 KLCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIWebViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource>

{
    

    __weak IBOutlet UIWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;

    UIView *opaqueView;
    bool _authed;
    
    
    
    
}




@end

