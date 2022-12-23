//
//  DatabaseService.swift
//  Weather app
//
//  Created by praksa on 21.11.22..
//

import Foundation
import Resolver
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    lazy var database = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let authResult = authResult {
                completion(.success(authResult))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let authResult = authResult {
                completion(.success(authResult))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func isLoggedUser() -> Bool{
        return firebaseAuth.currentUser?.uid != nil
    }
    
    func logout() {
        do {
            UserDefaults.favoriteLocations = nil
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func emailLoginUser()-> String {
        if let email = firebaseAuth.currentUser?.email {
            return email
        }
        return ""
    }
    
    func getUserUnitSystem(email: String, completion: @escaping (Result<String, Error>) -> Void)  {
        database.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    if document.documentID == email {
                        if let unitSystem = document.data()["unitSystem"] as? String {
                            completion(.success(unitSystem))
                        } else {
                            completion(.success(UnitSystem.celsius.rawValue))
                        }
                    }
                }
            }
        }
    }
        
    func updateUserUnitSystem(email: String, unitSystem: String){
        let docRef = database.document("users/\(email)")
        docRef.updateData(["unitSystem": unitSystem])
    }
    
    func setUserDefaultUnitSystem(email: String){
        let docRef = database.document("users/\(email)")
        docRef.setData(["unitSystem": "metric"])
    }
    
    func getFavouriteLocation(email: String, completion: @escaping (Result<[Coord], Error>) -> Void)  {
        database.collection("/users/\(email)/favourites").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                var listFavourite: [Coord] = []
                for document in querySnapshot!.documents {
                    if let lon = document.data()["lon"] as? Double, let lat = document.data()["lat"] as? Double {
                        listFavourite.append(Coord(lon: lon, lat: lat))
                    }
                }
                completion(.success(listFavourite))
            }
        }
    }
    
    func saveNewFavoriteLocation(email: String, location: Coord){
        let lat = Double(round(10000 * location.lat) / 10000)
        let lon = Double(round(10000 * location.lon) / 10000)
        let newLocation = ["lat": lat, "lon": lon] as [String : Any]
        database.collection("/users/\(email)/favourites").addDocument(data: newLocation)
    }
    
    func removeFavoriteLocation(email: String, coord: Coord){
        database.collection("/users/\(email)/favourites").whereField("lon", isEqualTo: coord.lon).whereField("lat", isEqualTo: coord.lat)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.database.collection("/users/\(email)/favourites").document("\(document.documentID)").delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
                    }
                }
        }
    }
    


    
    
    
}
