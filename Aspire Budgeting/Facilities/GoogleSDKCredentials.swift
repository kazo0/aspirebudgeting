//
//  GoogleSDKCredentials.swift
//  Aspire Budgeting
//
//  Created by TeraMo Labs on 10/19/19.
//  Copyright © 2019 TeraMo Labs. All rights reserved.
//

import Foundation

enum GoogleSDKCredentialsError: Error {
  case missingCredentialsPLIST
  case couldNotCreate
  
  public static func ==(lhs: GoogleSDKCredentialsError, rhs: GoogleSDKCredentialsError) -> Bool{
    switch(lhs, rhs) {
    case (missingCredentialsPLIST, missingCredentialsPLIST):
      return true
    
    case (couldNotCreate, couldNotCreate):
      return true
      
    default:
      return false
  }
  }
}

struct GoogleSDKCredentials: Codable {
  let CLIENT_ID: String
  let REVERSED_CLIENT_ID: String
  
  static func getCredentials(from fileName: String = "credentials",
                             type: String = "plist",
                             bundle: Bundle = Bundle.main,
                             decoder: PropertyListDecoder = PropertyListDecoder()) throws -> GoogleSDKCredentials {
    
    var credentialsData: Data
    var credentials: GoogleSDKCredentials
    
    guard let credentialsURL = bundle.url(forResource: fileName,
                                          withExtension: type)
      else {
        throw GoogleSDKCredentialsError.missingCredentialsPLIST
    }
    
    do {
      credentialsData = try Data(contentsOf: credentialsURL)
      credentials = try decoder.decode(GoogleSDKCredentials.self, from: credentialsData)
      
    } catch {
      print("Exception thrown while trying to create GoogleSDKCredentials: \(error.localizedDescription)")
      throw GoogleSDKCredentialsError.couldNotCreate
    }
    
    return credentials
  }
}
