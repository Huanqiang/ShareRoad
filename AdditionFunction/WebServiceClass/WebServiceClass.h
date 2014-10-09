//
//  WebServiceClass.h
//  WebServerTest
//
//  Created by 枫叶 on 14-7-12.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//
/*
 协议示例：
 URL：http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx?op=getMobileCodeInfo
 SOAP12:
 <?xml version="1.0" encoding="utf-8"?>
 <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
 <soap12:Body>
 <getMobileCodeInfo xmlns="http://WebXml.com.cn/">(1)
 <mobileCode>string</mobileCode> （2）
 <userID>string</userID>
 </getMobileCodeInfo>
 </soap12:Body>
 </soap12:Envelope>
 
 参数示例：
 WebURL:            URL中的 http://webservice.webxml.com.cn
 webServiceFile:    URL中的 /WebServices/MobileCodeWS.asmx
 xmlNameSpace:      SAOP12中的(1)处的 http://WebXml.com.cn/
 webServiceName:    SAOP12中的(1)处的 getMobileCodeInfo
 wsParameters:      SAOP12中的(2)处的 键值，形式为[参数1名称，参数1值，参数2名称，参数2值⋯⋯]，如果没有调用参数，此参数为nil
 */

#import <Foundation/Foundation.h>


typedef void (^ dealWithDataBlock) (NSData *, NSError *);
typedef void (^ dealWithDownloadDataBlock) (NSURL *, NSURLResponse *);
typedef void (^ dealWithLoadDataBlock) (NSData *, NSURLResponse *);

@interface WebServiceClass : NSObject<NSXMLParserDelegate>
{
    NSMutableString *soapResults;
    BOOL recordResults;
}

+ (id)shareInstance;
/*********************************************************************************/
#pragma mark - WebService网络请求

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
                                       failure:(void(^)(NSError *error)) failure;

- (NSMutableURLRequest *)createRequest:(NSString *) webURL
                        webServiceFile:(NSString *) wsFile
                          xmlNameSpace:(NSString *) xmlNS
                        webServiceName:(NSString *) wsName
                          wsParameters:(NSMutableArray *) wsParas;

#pragma mark - NSURLSession网络请求
/*
 方法：获取http响应的状态码
 参数介绍：
 response:    网络请求反应
 */
- (NSInteger)getResponseCode:(NSURLResponse *)response;

/*
 方法：移动文件
 参数介绍：
 fileName:    文件名称
 location:    原来的地址
 */
- (NSString *)moveFile:(NSString *)fileName AndOldURL:(NSURL *)location;

/*********************************************************************************/
//#pragma mark - GDataXML Delegate Methods
///**
// 方法：解析webservice返回的XML成一个NSDictionary
// 参数：content:       要解析的数据
// 参数：path:          要解析的XML数据一个根节点
// 返回：NSDictionary
// */
//- (NSDictionary *)getWebServiceXMLResult:(NSString *)content xpath:(NSString *)path;

/*********************************************************************************/
#pragma mark - XML解析(未完)
//使用自带的NSXMLParserDelegate协议
- (NSString *)startXMLParser:(NSData *)webData AndElementName:(NSString *)elementName;

@end
