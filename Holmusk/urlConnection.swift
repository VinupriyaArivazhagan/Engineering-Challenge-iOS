//
//  urlConnection.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit

typealias completionClosure = (arrResult: NSArray?,error: NSError?) -> ()
private let foodSearchUrl = "http://test.holmusk.com/food/search?q="


class urlConnection: NSObject {
    var receivedData = NSMutableData()
    var objCompletionClosure : completionClosure!

    func serviceCall(foodName: String!, compClosure:completionClosure!)
    {
        objCompletionClosure = compClosure
        let url = foodSearchUrl + foodName
        var request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.timeoutInterval = 20.0
        
        var connection : NSURLConnection = NSURLConnection  (request: request, delegate: self, startImmediately:true)!
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        objCompletionClosure(arrResult: nil, error: error)
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        receivedData.length = 0
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        receivedData.appendData(conData)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var error : NSError?
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error == nil)
        {
            if (jsonObject != nil)
            {
              if let arrResult = jsonObject as? NSArray
              {
                objCompletionClosure(arrResult: arrResult, error: nil)
              }
              else
              {
                objCompletionClosure(arrResult: nil, error:NSError(domain: "http", code: -1, userInfo: nil))
              }
            }
            else
            {
              objCompletionClosure(arrResult: nil, error:error)
            }
        }
        else
        {
            objCompletionClosure(arrResult: nil, error:NSError(domain: "http", code: -1, userInfo: nil))
        }
    }
}
