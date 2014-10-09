//
//  WebServiceClass.m
//  WebServerTest
//
//  Created by 枫叶 on 14-7-12.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "WebServiceClass.h"

@implementation WebServiceClass
{
    NSString *xPath;
}
static WebServiceClass *instnce;

//使外部文件可以直接访问UesrDB内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}


#pragma mark - WebService异步请求
- (NSDictionary *)stringToDictionary:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
/*
 方法：WebService异步访问
 参数介绍：
 参数 webURL： 远程WebService的地址，不含*.asmx
 参数 webServiceFile： 远程WebService的访问文件名，如service.asmx
 参数 xmlNameSpace： 远程WebService的命名空间
 参数 webServiceName： 远程WebService的名称
 参数 wsParameters： 调用参数数组，形式为[参数1名称，参数1值，参数2名称，参数2值⋯⋯]，如果没有调用参数，此参数为nil
 参数 success： 添加网络操作成功的代码段（最好返回主线程操作）
 参数 failure： 添加网络操作失败的代码段（最好返回主线程操作）
 */
-(void)createAsynchronousRequestWithWebService:(NSString *) webURL
                                webServiceFile:(NSString *) wsFile
                                  xmlNameSpace:(NSString *) xmlNS
                                webServiceName:(NSString *) wsName
                                  wsParameters:(NSMutableArray *) wsParas
                                       success:(void(^)(NSDictionary *dic)) success
                                       failure:(void(^)(NSError *error)) failure
{
    NSMutableURLRequest *request = [self createRequest:webURL webServiceFile:wsFile xmlNameSpace:xmlNS webServiceName:wsName wsParameters:wsParas];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
        if ([data length] > 0 && connectionError == nil) {
            NSString *result = [[WebServiceClass shareInstance] startXMLParser:data AndElementName:[NSString stringWithFormat:@"%@Result", wsName]];
            NSDictionary *dic = [self stringToDictionary:result];
            success(dic);
        }else if (connectionError != nil) {
            failure(connectionError);
        }
    }];
}

/*
 方法：创建Request
 参数 webURL： 远程WebService的地址，不含*.asmx
 参数 webServiceFile： 远程WebService的访问文件名，如service.asmx
 参数 xmlNS： 远程WebService的命名空间
 参数 webServiceName： 远程WebService的名称
 参数 wsParameters： 调用参数数组，形式为[参数1名称，参数1值，参数2名称，参数2值⋯⋯]，如果没有调用参数，此参数为nil
*/
- (NSMutableURLRequest *)createRequest:(NSString *) webURL
                        webServiceFile:(NSString *) wsFile
                          xmlNameSpace:(NSString *) xmlNS
                        webServiceName:(NSString *) wsName
                          wsParameters:(NSMutableArray *) wsParas {
    NSString *soapMsgStart = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                              "<soap12:Body>"
                              "<%@ xmlns=\"%@\">\n", wsName, xmlNS];
    NSString *soapMsgEnd = [NSString stringWithFormat:
                            @"</%@>"
                            "</soap12:Body>"
                            "</soap12:Envelope>",wsName];
    
    //2、生成SOAP调用参数
    //soapParas = [[NSString alloc] init];
    NSString *soapMsgBody = @"";
    if (![wsParas isEqual:nil]) {
        int i = 0;
        for (i = 0; i < [wsParas count]; i = i + 2) {
            soapMsgBody = [soapMsgBody stringByAppendingFormat:@"<%@>%@</%@>\n",
                           [wsParas objectAtIndex:i],
                           [wsParas objectAtIndex:i+1],
                           [wsParas objectAtIndex:i]];
        }
    }
    
    NSString *soapMessage = [NSString stringWithFormat:@"%@%@%@",soapMsgStart, soapMsgBody, soapMsgEnd];
	//请求发送到的路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", webURL, wsFile]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	//以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[request addValue: @"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}


#pragma mark - NSURLSession网络请求

/*
 方法：获取http响应的状态码
 参数介绍：
 response:    网络请求反应
 */
- (NSInteger)getResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    return responseStatusCode;
}

/*
 方法：移动文件
 参数介绍：
 fileName:    文件名称
 location:    原来的地址
 */
- (NSString *)moveFile:(NSString *)fileName AndOldURL:(NSURL *)location {
    // 设置文件的存放目标路径
    NSString *documentsPath = [self getDocumentsPath];
    NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
    
    // 如果该路径下文件已经存在，就要先将其移除，在移动文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
        [fileManager removeItemAtURL:fileURL error:NULL];
    }
    
    //移动文件
    [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
    
    return [[NSString alloc] initWithFormat:@"%@",fileURL];
}

/*
 方法：获取Documents文件夹的路径
 */
- (NSString *)getDocumentsPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    return documentsPath;
}

//#pragma mark - GDataXML Delegate Methods
///**
// 解析webservice返回的XML成一个NSDictionary
// 参数：content ,要解析的数据
// 参数：path ,要解析的XML数据一个根节点
// 返回：NSDictionary
// */
//- (NSDictionary *)getWebServiceXMLResult:(NSString *) content xpath:(NSString *)path {
//    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
//    content = [content stringByReplacingOccurrencesOfString:@"<" withString:@"<"];
//    content = [content stringByReplacingOccurrencesOfString:@">" withString:@">"];
//    content = [content stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNSxml"];
//    NSError *docError = nil;
//    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:&docError];
//    if(!docError)
//    {
//        NSArray *children = nil;
//        children = [document nodesForXPath:[NSString stringWithFormat:@"//%@",path] error:&docError];
//        if(!docError)
//        {
//            if(children && [children count]>0)
//            {
//                GDataXMLElement *rootElement = (GDataXMLElement *)[children objectAtIndex:0];
//                NSArray *nodearr = [rootElement children];
//                for (int i = 0; i<[nodearr count]; i++) {
//                    GDataXMLElement *element = (GDataXMLElement *)[nodearr objectAtIndex:i];
//                    [resultDict setObject:[element stringValue] forKey:[element name]];
//                }
//            }
//        }
//    }
//    return resultDict;
//}


#pragma mark - XML Parser Delegate Methods
- (NSString *)startXMLParser:(NSData *)webData AndElementName:(NSString *)elementName {
    soapResults = [[NSMutableString alloc] init];
    xPath = [elementName copy];
    recordResults = NO;
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    
    //先将xml解析完了再返回[xmlParser parse]的结果，所以此时soapResults已经有值了
    if ([xmlParser parse]) {
        return soapResults;
    }else {
        return nil;
    }
}

// 解析整个文件开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
	NSLog(@"-------------------start------------------");
}

//开始XML解析
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName attributes: (NSDictionary *)attributeDict
{
    if( [elementName isEqualToString:xPath]) {
		if(!soapResults) {
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = YES;
	}
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(recordResults)
	{
		[soapResults appendString: string];
	}
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if( [elementName isEqualToString:@"xPath"])
	{
		
		NSLog(@"hoursOffset result:%@",[NSString stringWithFormat:@"%@", soapResults]);
	}
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser{
	NSLog(@"-------------------end--------------");
}

@end
