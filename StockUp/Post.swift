//
//  Post.swift
//  StockUp
//
//  Created by Franky Liang on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps

class Post: NSObject {
    
    
    func postRide(destination: GMSPlace, currentLocation: GMSPlace, currentLatitude: Double, currentLongitude: Double, price: Int, seatsAvailable: Int) {
        let newRide = PFObject(className:"Post")
        
        newRide["price"] = price
        newRide["seatsAvailable"] = seatsAvailable
        newRide["departuredTime"] = 5 //temporary
        newRide["destinationAddress"] = destination.formattedAddress!.componentsSeparatedByString(", ").joinWithSeparator("\n")
        
//        let destPoint = PFGeoPoint(latitude:destination.coordinate.latitude, longitude:destination.coordinate.longitude )
//        newRide["destinationLatitude"] = destination.coordinate.latitude
//        newRide["destinationLongitude"] = destination.coordinate.longitude
//        
//        
//        newRide["currentLatitude"] = currentLatitude
//        newRide["currentLongitude"] = currentLongitude
        
        
        newRide["destinationName"] = destination.name
        newRide["driverID"] = PFUser.currentUser()?.objectId
        
        newRide["destinationPlaceID"] = destination.placeID
        newRide["currentLocationID"] = currentLocation.placeID
        
        newRide["currentLocation"] = [currentLongitude, currentLatitude]
        newRide["destinationLocation"] = [destination.coordinate.longitude, destination.coordinate.latitude]
        
        newRide.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Mark the user as an active driver
                User.user = userType.activeDriver
                User.activeRideID = newRide.objectId!
                print("Post ID \(newRide.objectId!)")
                User.setUpProfile()
                print("Posted Ride Successfully")
                //EZLoadingActivity.hide()
                
            }
        }
    }

}
