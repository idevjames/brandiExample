//
//  KakaoAPIManager.swift
//  brandiExample
//
//  Created by HooGi on 2021/11/17.
//

import Foundation
import Alamofire
import SwiftyJSON

enum SortType: String {
    case accuracy = "accuracy"
    case recency  = "recency"
}

struct KakaoAPI {
    static let baseURL = "https://dapi.kakao.com/v2/search/image"
    static let restAPIKey = "c648f890de0fd3fef1e5adae41437637"
}

final class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    // MARK: - Handlers
    typealias resultHandler = (_ error: AFError?, _ models: [ImageModel]?, _ isEnd: Bool?) -> (Void)
    
    private init() {}
    
    // MARK: - Methods
    public func requestAPI(search: String, sort: SortType? = nil, page: Int? = nil, size: Int? = nil, completion: @escaping resultHandler) {
        let headers: [String:String] = [
            "Content-Type": "application/json",
            "Accept": "applcation/json",
            "Authorization": "KakaoAK \(KakaoAPI.restAPIKey)"
        ]
        
        let params: [String:Any] = [
            "query": search,
            "sort": sort?.rawValue ?? SortType.accuracy,
            "page": page ?? 1,
            "size": size ?? 30
        ]
        print(params)
        AF.request(KakaoAPI.baseURL,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(headers)).responseJSON { (response) in
            
            switch response.result {
            case .success(let object):
                let json = JSON(object)
                print(json)
                
                if let array = json["documents"].array {
                    let models = array.map({ ImageModel(json: $0) })
                    
                    if let isEnd = json["meta"]["is_end"].bool {
                        completion(nil, models, isEnd)
                    } else {
                        completion(nil, models, nil)
                    }
                    
                } else {
                    completion(nil, [], nil)
                }
                
                
            case .failure(let error):
                print(String(describing: error.localizedDescription))
                completion(error, nil, nil)
            }
        }
    }
}
