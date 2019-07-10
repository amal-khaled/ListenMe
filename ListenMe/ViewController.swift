//
//  ViewController.swift
//  ListenMe
//
//  Created by Amal Elgalant on 7/9/19.
//  Copyright © 2019 Amal Elgalant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    
    var mediaArray = [Media]()
    
   var selectedIndex = 0
    var searchText = ""
    let refreshControl = UIRefreshControl()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "media_details"{
            let desVC = segue.destination as! MediadetailsViewController
            desVC.media = mediaArray[selectedIndex]
        }
        
     }
    
    // MARK: - Refresh
    
    @objc func refresh(){
        
        getData()
    }


}
// MARK: - Table extension

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "media_item") as! mediaItemTableViewCell
        
        let media = mediaArray[indexPath.row]
      
        cell.artist.text = media.artist.name
        cell.title.text = media.title
        cell.type.text = media.type
//        if url != nil {
//            do {
//                let data = try Data(contentsOf: url!, options: [])
//                  cell.itemImage.image = UIImage(data: data)
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//
//        }
        cell.itemImage.downloaded(from:media.image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "media_details", sender: self)
    }
    
    
}

// MARK: - Search extenstion

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchBar.resignFirstResponder()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchBar.text!
        if searchText.count == 0{
            self.searchText = ""
            
        }
      
       getItems()
        
    }
    
}
// MARK: - Utilities extenstion

extension ViewController{
    
    

    func getData(){
        APIController.apiController.getUserToken(completion: {success in
            if success{
                self.getItems()
            }
        }
            
        )
    }
    
    func getItems(){
        APIController.apiController.getMedia(completion: {
            _mediaArray in
            self.mediaArray = _mediaArray
            DispatchQueue.main.async {
                self.itemsTableView.reloadData()
                self.refreshControl.endRefreshing()

            }
        }, searchText: searchText)
    }
}


// MARK: - Downloading image extenstion
extension UIImageView {
    
    //download image from url
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
