/*!
 @class APIController.swift
 
 @brief Contain all connections with the API
 
 @author Amal Elgalant
 @copyright  © 2019 Amal Elgalant. All rights reserved.
 @version    1
 */

import Foundation

class APIController{
    static var apiController = APIController()
    
    
    
    // MARK: - Get user Token
    /*!
     This method to connect to server to get user token
     
     @param  completion  completion handler
     
     @return Bool   true if token returnrd and false in case of failure
     */
    func getUserToken(completion: @escaping (Bool) -> ()){
        
        
        
        guard let url = URL(string: Constants.GET_TOKEN) else { return }
        
        print(url)
        var request = URLRequest(url: url)
        request.setValue( Constants.GETWAY_KEY,forHTTPHeaderField:"X-MM-GATEWAY-KEY")

        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        let session = URLSession.shared

        let task = session.dataTask( with: request  ) {(data, response, error) in

            guard let data = data else { return }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {

                    if let api_token = jsonObj!.value(forKey: "accessToken") as? String {
                        Constants.api_Token = api_token
                       print(api_token)
                        completion(true)

                    }

                }


            } else  {
                completion(false)

                print("Failed")
            }
        }
        task.resume()
        session.invalidateAndCancel()

        
        
    }
    // MARK: - Get media items
    /*!
     This method to connect to server to get list of media
     
     @param  completion  completion handler
     @param  searchText  search text that user entered

     @return [Media]   Array of Media
     */
    func getMedia(completion: @escaping ([Media]) -> (), searchText: String){
        
        var search = searchText
        if search == ""{
            search = "all"
        }
       
        guard let url = URL(string: Constants.GET_MEDIA_ITEMS
            + search) else { return }
        
        var allmedia = [Media]()
        
        print(url)
        var request = URLRequest(url: url)
        request.setValue( Constants.GETWAY_KEY,forHTTPHeaderField:"X-MM-GATEWAY-KEY")
        
        request.addValue("Bearer "+Constants.api_Token, forHTTPHeaderField: "Authorization")
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask( with: request  ) {(data, response, error) in
            guard let data = data else { return }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray {
                    print(jsonObj!.count)
                    for i in 0..<jsonObj!.count{
                        if let media = jsonObj![i] as? NSDictionary{
                            allmedia.append(Media(media:media as! [String : Any]))
                        }
                    }
                    completion(allmedia)


                    
                }
                
                
            } else  {
                completion([])

                print("Failed")
            }
        }
        task.resume()
        
        
        
    }
}
