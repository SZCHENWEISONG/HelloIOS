//
//  ViewController.m
//  HelloIOS
//
//  Created by Tony Chen on 15/2/25.
//  Copyright (c) 2015年 KLCL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *tableData;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * simpleTable=@"SimpleTableItem";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable ];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTable];
    }
    cell.textLabel.text=[tableData objectAtIndex:indexPath.row];
    return cell;
    
}
- (void)viewDidLoad {
   // _authed=YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    
    
    
#pragma mark
    tableData=[NSArray arrayWithObjects:@"Egg Beneciy",@"QQ", nil];
#pragma mark
    
    [webView setUserInteractionEnabled:YES];//是否支持交互
  
    //[webView setDelegate:self];
    
    webView.delegate=self;
   
    [webView setOpaque:NO];//opaque是不透明的意思
   
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
 
 
    
  
    //加载网页的方式
 
    //1.创建并加载远程网页
   
    NSURL *url = [NSURL URLWithString:@"http://192.168.89.61/APPs/Sps/MyPaper2/Index/28?T=T001"];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
   
    //2.加载本地文件资源
   
    /* NSURL *url = [NSURL fileURLWithPath:filePath];
     34.
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     35.
     [webView loadRequest:request];*/
    
    //3.读入一个HTML，直接写入一个HTML代码
    
    //NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"webapp/loadar.html"];
    
    //NSString *htmlString = [NSString stringWithContentsOfURL:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    
    //[webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
  
//    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
//   
//    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
//    
//    [activityIndicatorView setCenter:opaqueView.center];
//  
//    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    
//    [opaqueView setBackgroundColor:[UIColor blackColor]];
//
//    [opaqueView setAlpha:0.6];
//    
//    [self.view addSubview:opaqueView];
//    
//    [opaqueView addSubview:activityIndicatorView];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

{
    
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authed);
    
    
    
    if (!_authed) {
        
        _authed = NO;
        
        /* pretty sure i'm leaking here, leave me alone... i just happen to leak sometimes */
        
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        return NO;
        
    }
    
    return YES;
    
}



-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"got auth challange");
//    
//    if ([challenge previousFailureCount] == 0) {
//        _authed = YES;
//        /* SET YOUR credentials, i'm just hard coding them in, tweak as necessary */
//        [[challenge sender] useCredential:[NSURLCredential credentialWithUser:@"username" password:@"password" persistence:NSURLCredentialPersistencePermanent] forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//    }
     [[challenge sender] useCredential:[NSURLCredential credentialWithUser:@"TONY.CHEN@KEPPELLANDCHINA.COM" password:@"Klcl2015~" persistence:NSURLCredentialPersistencePermanent] forAuthenticationChallenge:challenge];
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"received response via nsurlconnection");
    
    /** THIS IS WHERE YOU SET MAKE THE NEW REQUEST TO UIWebView, which will use the new saved auth info **/
    _authed = YES;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.89.61/APPs/Sps/MyPaper2/Index/28?T=T001"]];
    
    [webView loadRequest:urlRequest];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
{
    return NO;
}


//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//   
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    
//    if ((([httpResponse statusCode]/100) == 2)) {
//       
//        // self.earthquakeData = [NSMutableData data];
//      
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//       
//        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
//       
//        webView.delegate = self;
//       
//    } else {
//       
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
//                                  
//                                  NSLocalizedString(@"HTTP Error",
//                                                    
//                                                    @"Error message displayed when receving a connection error.")
//                                  
//                                                             forKey:NSLocalizedDescriptionKey];
//       
//        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
//       
//        
//        if ([error code] == 404) {
//          
//            NSLog(@"xx");
//           
//            webView.hidden = YES;
//            
//        }
//       
//    }
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
-(void)keyboardDidShow:(NSNotification *)ns
{
    NSLog(@"Keyboard did show");
}
-(void)keyboardDidHide:(NSNotification*)ns
{
    NSLog(@"Keyboard did hide");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    
//    return YES;
//}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return YES;
//    }
//    return YES;
//}
- (IBAction)testClick:(id)sender {
    UIAlertView *helloWorld=[[UIAlertView alloc]initWithTitle:@"My First App" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [helloWorld show];
}


@end
