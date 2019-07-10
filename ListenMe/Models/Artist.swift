//
//  Artist.swift
//  ListenMe
//
//  Created by Amal Elgalant on 7/10/19.
//  Copyright © 2019 Amal Elgalant. All rights reserved.
//

/*!
 @class Artist.swift
 
 @brief class about artist
 
 @field id  artist id
 @field name    artist name
 @field role    the role off the artist
 
 @author Amal Elgalant
 @copyright  © 2019 Amal Elgalant. All rights reserved.
 @version    1
 */

import Foundation

class Artist{
    var id = 0
    var name = ""
    var role = ""
    
    
    init(){
    }
    /*!
     object mapping
     
     @param  artist  artist dictionary returned from server
     */
    init(artist dictionary: [String: Any]? ) {
        guard let dictionary = dictionary else { return }
        
        name = dictionary["name"] as! String
        id = dictionary["id"] as! Int
        
        if let _role = dictionary["role"] as? String{
        
            role = _role
        }
    }
    
    
    
}
