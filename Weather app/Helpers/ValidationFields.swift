//
//  Validation.swift
//  Weather app
//
//  Created by praksa on 21.11.22..
//

import Foundation

class ValidationFields {
    
    public func createAccountValdiation(email: String, password: String, repeatPassword: String) -> (Bool, String) {
        var errorMessage = ""
        var isValid = true
        
        
        if password == "" {
            isValid = false
            errorMessage = "Please enter password"
        }
        
        if repeatPassword == "" {
            isValid = false
            errorMessage = "Please confirm your password"
        }
        
        if password != repeatPassword {
            isValid = false
            errorMessage = "Passwords did not match"
        }
        
        if password.count < 6 {
            isValid = false
            errorMessage = "Password must be at least 6 characters long"
        }
        
        
        if email == "" {
            isValid = false
            errorMessage = "Please enter email address"
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            if emailPred.evaluate(with: email) == false{
                errorMessage = "Invalid email address format"
            } else {
                if password == "" {
                    errorMessage = "Please enter password"
                } else {
                    errorMessage = "Please confirm your password"
                }
            }
            
        }
        
            
        return (isValid, errorMessage)
    }
    
    public func loginValidation(email: String, password: String) -> (Bool, String) {
        
        var errorMessage = ""
        var isValid = true
        
        if password == "" {
            isValid = false
            errorMessage = "Please enter password"
        }
        
        if email == "" {
            isValid = false
            errorMessage = "Please enter email address"
        }

        return (isValid, errorMessage)
    }
}
