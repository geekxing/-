//
//  ParseJSON.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/1.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import Foundation


class ParseJSON  {
    
    func loadJSONData(data: NSData) -> [JSONResult] {
        if let dict = parseJSON(data) {
            let jsonResults = parseDictionary(dict)
            return jsonResults
        } else {
            return []
        }
    }
    
    private func parseJSON(data: NSData) -> [String: AnyObject]? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
        } catch {
            print("JSON ERROR: \(error)")
            return nil
        }
    }
    
    private func parseDictionary(dictionary: [String: AnyObject]) -> [JSONResult] {
        guard let array = dictionary["feed"] as? [AnyObject] else {
            return []
        }
        var jsonResults = [JSONResult]()
        for resultDict in array {
            if let resultDict = resultDict as? [String: AnyObject] {
                var jsonResult: JSONResult?
                
                jsonResult = parseResult(resultDict)
                if let result = jsonResult {
                    jsonResults.append(result)
                }
            }
        }
        return jsonResults
    }
    
    private func parseResult(dictionary: [String: AnyObject]) -> JSONResult {
        let jsonResult = JSONResult()
        jsonResult.title = dictionary["title"] as! String
        jsonResult.content = dictionary["content"] as! String
        jsonResult.username = dictionary["username"] as! String
        jsonResult.time = dictionary["time"] as! String
        jsonResult.imageName = dictionary["imageName"] as! String
        return jsonResult
    }
    
}