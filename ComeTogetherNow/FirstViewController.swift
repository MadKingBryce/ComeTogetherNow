//
//  FirstViewController.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/8/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FirstViewController: UIViewController, CLLocationManagerDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!

    var del : AppDelegate?
    var location : CLLocation?
    var locationManager = CLLocationManager()
    
    
    var longLat = [0.0000, 0.000]
    // var newLongLat = self.longLat
    
    @IBAction func getLocation() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .NotDetermined {
            print("Location Authorization Status = .NotDetermined")
            self.locationManager.requestAlwaysAuthorization()
            print("DidItWork?")
        }
        if authStatus == .Denied || authStatus == .Restricted {
            print("Location Authorization Status = .Denied")
            
        }
        
        print("Getting Location...")
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        
        updateLabels()
        
        print("Test")
        
          }

    

    func saveLocationAsLastLocation() {
        
        print("Alright this is a test ")
    }
    
// MARK: Data Entry 
    
    func updateLabels() {
        print("UpdatingLabels")
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.hidden = false
            messageLabel .text = ""
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.hidden = true
            messageLabel.text = "Tap 'Get My Location' to Start"
        }
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(okAction)
    }

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Shit dude we didFailWithError \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        print("\nAwesome! We didUpdateLocations \(locations.last!)")
        location = locations.last
        updateLabels()
        
        //PFUser.currentUser()!["lastLocation"] = PFGeoPoint(location: locations.last!)
        
    }

// MARK: PFLoginSignUp
    
    func checkAuth() {
        print("Checking for user")
        if PFUser.currentUser() == nil {
            print("No User found... Showing Login")
            self.showLogin()
        } else {
            print("User found")
        }
    }
    
    func showLogin() {
        
        print("cookies")
        let loginViewController = PFLogInViewController ()
        loginViewController.delegate = self
        
        //loginViewController.facebookPermissions = ["user_about_me"]
        
        // Choose which fields you want to display on login page
        loginViewController.fields.insert(PFLogInFields.UsernameAndPassword)
        loginViewController.fields.insert( PFLogInFields.SignUpButton)
        loginViewController.fields.insert(PFLogInFields.LogInButton)
        loginViewController.fields.insert(.Twitter)
        
        let signUpViewController = PFSignUpViewController()
        signUpViewController.fields.insert(PFSignUpFields.UsernameAndPassword)
        signUpViewController.fields.insert(PFSignUpFields.SignUpButton)
        signUpViewController.delegate = self
        loginViewController.signUpController = PFSignUpViewController().self
        loginViewController.signUpController!.delegate = self
        
        
        self.presentViewController (loginViewController, animated: true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn (logInController: PFLogInViewController) {
        self.dismissViewControllerAnimated (true, completion: nil)
    }
    func signUpViewController (signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        print("\ndidSignUpUser")
        self.dismissViewControllerAnimated (true, completion: nil)
    }
    func signUpViewControllerDidCancelSignUp (signUpController: PFSignUpViewController) {
        print("\nsignUpController")
        self.dismissViewControllerAnimated (true, completion: nil)
    }



    
// MARK: Basic VC Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        //xyz()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        checkAuth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

