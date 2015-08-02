//
//  urlConnection.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit

typealias completionClosure = (arrResult: NSArray?, dictResult: NSDictionary!, error: NSError?) -> ()
private let foodSearchUrl = "http://test.holmusk.com/food/search?q=" //Holmusk food search url
private let kiminoAPIUrl = "https://www.kimonolabs.com/api/egqqke8q?apikey=UZ1jvPU2FiczkJ5xIea95O3hQMATrdv0" //kiminoApI Url

class urlConnection: NSObject {
    var receivedData = NSMutableData()
    var objCompletionClosure : completionClosure!
    var ISkiminoCall : Bool!
    
    func serviceCall(foodName: String!, isKiminoCall:Bool!, compClosure:completionClosure!)
    {
        objCompletionClosure = compClosure
        ISkiminoCall = isKiminoCall
        
        var url : String!
        if isKiminoCall == true
        {
            url = kiminoAPIUrl
        }
        else
        {
            url = foodSearchUrl + foodName.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }
        var request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.timeoutInterval = 20.0
        
        var connection : NSURLConnection = NSURLConnection  (request: request, delegate: self, startImmediately:true)!
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        objCompletionClosure(arrResult: nil,dictResult: nil, error: error)
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
                if ISkiminoCall == true
                {
                  if let dictResult = jsonObject as? NSDictionary
                  {
                    objCompletionClosure(arrResult: nil, dictResult:dictResult ,error: nil)
                  }
                  else
                  {
                    objCompletionClosure(arrResult: nil,dictResult: nil, error:NSError(domain: "http", code: -1, userInfo: nil))
                  }
                }
                else
                {
                    if let arrResult = jsonObject as? NSArray
                    {
                        objCompletionClosure(arrResult: arrResult, dictResult: nil, error: nil)
                    }
                    else
                    {
                        objCompletionClosure(arrResult: nil, dictResult: nil, error:NSError(domain: "http", code: -1, userInfo: nil))
                    }
                }
            }
            else
            {
                objCompletionClosure(arrResult: nil, dictResult: nil, error:error)
            }

        }
        else
        {
            objCompletionClosure(arrResult: nil, dictResult: nil, error:NSError(domain: "http", code: -1, userInfo: nil))
        }
    }
}
