//
//  MediadetailsViewController.swift
//  ListenMe
//
//  Created by Amal Elgalant on 7/10/19.
//  Copyright © 2019 Amal Elgalant. All rights reserved.
//

import UIKit

class MediadetailsViewController: UIViewController {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var media = Media()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        artistLabel.sizeToFit()
        titleLabel.sizeToFit()
        
         setData()
    }
    
    
    // MARK: - Set view data

    func setData(){
        titleLabel.text = media.title
        artistLabel.text = media.artist.name
        typeLabel.text = media.type
        durationLabel.text = String(media.duration)
        releaseDateLabel.text = media.releaseDate
        
        let url = URL(string: media.image)
        if url != nil {
            do {
                let data = try Data(contentsOf: url!, options: [])
                mediaImage.image = UIImage(data: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
