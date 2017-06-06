//  ParseStarterProject-Swift
//
//  Created by Rohith on 05/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//
import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in form", message: "Please enter an email and password")
            
        } else {
            
                activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                
                // Sign Up
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in // user.signUpInBackground({ (success, error) is now user.signUpInBackground(block: { (success, error)
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as? NSError
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("user signed up")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    
                    }
                    
                    
                })
                
                
            } else {
                
                // Login mode
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged in")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                    }
                    
                    
                })
                
                
            }
            
            
            
        }
        
        
        
    }
    
    @IBOutlet var signupOrLogin: UIButton!
    
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        
        if signupMode {
            
            // Change to login mode
            
            signupOrLogin.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            
            // Change to signup mode
            
            signupOrLogin.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
            
        }
        
    }
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var changeSignupModeButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage.jpg")!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
