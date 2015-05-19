//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    
    @IBOutlet weak var Welcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check it"
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        var currentUser = PFUser.currentUser()
        if currentUser == nil {
            let login = PFLogInViewController()
            let signup = PFSignUpViewController()
            
            login.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten
        
        println("is this even happening?")
            login.delegate = self
            signup.delegate = self
            
            login.signUpController = signup
            self.presentViewController(login, animated: true, completion: nil)
        }
        
        else{
            var username = PFUser.currentUser().username
            Welcome.text = username
            println("We're getting an error here")
            println(PFUser.currentUser().username)
            PFUser.logOut()
            currentUser = PFUser.currentUser()
    
            
            
        }

       
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
        
    }


    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        var drills = PFObject(className: "Drills")
        drills["Player"] = PFUser.currentUser()
        user.saveInBackgroundWithBlock{(success:Bool!,error:NSError!)->Void in
            if success != nil {
                NSLog("%@", "Success")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                NSLog("%@", error)
                //Potential UI Alert to user?
                
            }
        }
        
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
