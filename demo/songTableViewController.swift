//
//  songTableViewController.swift
//  demo
//
//  Created by fun on 2020/8/14.
//

import UIKit

class songTableViewController: UITableViewController {
    
    var songs = [song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlStr = "https://itunes.apple.com/search?term=告五人 &media=music&country=TW".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ,
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data , let songResults = try? decoder.decode(SongResults.self, from: data){
                    self.songs = songResults.results
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()

                    }
                }
            }.resume()
            
    
        
            
            
            
            
            
            
            
            
        
            
            
            
        }
        

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songTableViewCell", for: indexPath) as! songTableViewCell

        let song = songs[indexPath.row]
        cell.name.text = song.trackName
        cell.albumImage.image = nil
         URLSession.shared.dataTask(with: song.artworkUrl100) { (data, response, error) in
            if let data = data {
                
                DispatchQueue.main.async {
                    cell.albumImage.image = UIImage(data: data)

                }
                
                
            }
        }.resume()
    return cell
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    }
    
    @IBSegueAction func detail(_ coder: NSCoder) -> detailViewController? {
       
        let controller = detailViewController(coder: coder)
        
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.Song = songs[row]

        }
      return controller
    }
    
}

