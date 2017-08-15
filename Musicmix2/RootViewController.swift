//
//  RootViewController.swift
//  Musicmix2
//
//  Created by ロドリゲス海 on 2017/08/12.
//  Copyright © 2017年 ロドリゲス海. All rights reserved.
//

import UIKit
import SwiftyJSON

class RootViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var trackNames = NSMutableArray()
    var previewUrls = NSMutableArray()
    var artworkUrls = NSMutableArray()
    var artistNames = NSMutableArray()
    var isLoadNow = false
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchWord: String? = searchBar.text?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let searchWord = searchWord {
            self.isLoadNow = true
            let urlString:String = "http://itunes.apple.com/search?term=\(searchWord)&country=JP&lang=ja_jp&media=music&entity=song&attribute=artistTerm&limit=30"
            //let url:NSURL! = NSURL(string:urlString)
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                let json = JSON(data: data!)
                for (index, element) in json["results"].enumerated() {
                  //  self.trackNames[index] = "\(element["trackName"])"
                   // self.previewUrls[index] = "\(element["previewUrl"])"
                    
                    self.trackNames[index] = "\(json["results"][index]["trackName"])"
                    self.previewUrls[index] = "\(json["results"][index]["previewUrl"])"
                    self.artworkUrls[index] = "\(json["results"][index]["artworkUrl100"])"
                    self.artistNames[index] = "\(json["results"][index]["artistName"])"
                    print(self.artworkUrls[index])
                }
                self.isLoadNow = false
                /*
                for elements in self.trackNames {
                    print("hai:", elements)
                }
 */
 
            }
            task.resume()
            while isLoadNow {
                usleep(5)
            }
                    }
                self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("check2")
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.trackNames.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        if let artWorkUrl = self.artworkUrls[indexPath.row] as? String {
            let url = URL(string: artWorkUrl)!
            let imageData = try? Data(contentsOf: url)
           // print(imageData)
            let artwork = UIImage(data: imageData!)
           // print(artwork)
            cell.artworkImageView.image = artwork
            
            
        } else {
            cell.artworkImageView.image = nil
        }
        cell.trackLabel.text = self.trackNames[indexPath.row] as? String
        cell.artistLabel.text  = self.artistNames[indexPath.row] as? String
        
        //cell.textLabel?.text = self.trackNames[indexPath.row] as? String
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        /*
        print("check")
        for element in self.trackNames {
            print("hai:", element)
            cell.textLabel?.text = element as? String
        }
 */
        /*
        if let result = results?[indexPath.row] {
            cell.textLabel?.text = result["trackName"] as? String
        }
 */
        // Configure the cell...

        return cell
    }
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.trackName = self.trackNames[indexPath.row] as! String
                vc.previewUrl = self.previewUrls[indexPath.row] as? String
            }
        }
    }


}

class ListCell: UITableViewCell {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
}

