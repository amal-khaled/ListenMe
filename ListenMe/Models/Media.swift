/*!
 @class Media.swift
 
 @brief class about media
 
 @field image media image
 @field id  media id
 @field title    title for media
 @field type    the type of media (song or release)
 @field duration    duration of media
 @field releaseDate    publishing date of the media
 @field artist    main artist for this media

 @author Amal Elgalant
 @copyright  © 2019 Amal Elgalant. All rights reserved.
 @version    1
 */
import Foundation
class Media{
    var image: String = ""
    var id = 0
    var title: String = ""
    var type: String = ""
    var duration = 0
    var releaseDate: String = ""
    var artist = Artist()
    
    init(){
    }
    /*!
     object mapping
     
     @param  media  media dictionary returned from server
     
     */
    init(media dictionary: [String: Any]? ) {
        guard let dictionary = dictionary else { return }
        
        title = dictionary["title"] as! String
        if let artistObject = dictionary["mainArtist"] as? NSDictionary{
            artist = Artist(artist: artistObject as! [String : Any])
            
        }
        if let coverObject = dictionary["cover"] as? NSDictionary{
            image = coverObject["large"] as! String
            guard let url = URL(string: image)
                else {
                    print("Unable to create URL")
                    return
            }
            image = "https:" + url.absoluteString
        }
        type = dictionary["type"] as! String
        id = dictionary["id"] as! Int
        duration = dictionary["duration"] as! Int
        releaseDate = seperateDateAndTime(dictionary["publishingDate"] as! String)
    }
}
// MARK: - Seperate time and date
/*!
 This method returns date only from Date object
 
 @param  dte  The date with formate yyyy-MM-dd'T'HH:mm:ssZ
 
 @return string   date with formate yyyy-MM-dd
 */
public func seperateDateAndTime(_ dte: String)-> String{
    let df = DateFormatter()
    print(dte)
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    if let date = df.date(from: dte) {
        print(date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    else{
        return ""
    }
    
}
