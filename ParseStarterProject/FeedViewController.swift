//
//  FeedViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rohith on 05/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class FeedViewController: UITableViewController {
    var users = [String : String]()
    var messages = [String]()
    var usersnames = [String]()
    var imageFiles = [PFFile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var q = PFUser.query()
        q?.findObjectsInBackground(block: { (objects, error) in
            if let usr = objects {
                self.users.removeAll()
                for obj in usr {
                    if let ussr = obj as? PFUser {
                        self.users[ussr.objectId!] = ussr.username!
                    }
                }
            }
            let getFollowersquery = PFQuery(className: "Followers")
            getFollowersquery.whereKey("follower", equalTo: PFUser.current()?.objectId!)
            getFollowersquery.findObjectsInBackground(block: { (objects, error) in
                if let followers = objects {
                    for object in followers{
                        let followedUser = object["following"] as! String
                        let quer = PFQuery(className: "Posts")
                        quer.whereKey("userid", equalTo: followedUser)
                        quer.findObjectsInBackground(block: { (objects, error) in
                            if let posts = objects {
                                for postobj in posts{
                                    if let post = postobj as? PFObject{
                                        self.messages.append(post["message"] as! String)
                                        self.usersnames.append(self.users[post["userid"] as! String]!)
                                        self.imageFiles.append(post["imageFile"] as! PFFile)
                                    self.tableView.reloadData()
                                    }
                                }
                            }
                        })
                    }
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersnames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            if let img = data{
            if let dlimage = UIImage(data: img){
                cell.postedImage.image = dlimage
            }
            }
        }
        //cell.postedImage.image = imageFiles[indexPath.row]
        // Configure the cell...
        cell.message.text = messages[indexPath.row]
        cell.userName.text = usersnames[indexPath.row]
        return cell
    }
//    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
