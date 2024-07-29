//
//  UserListViewModel.swift
//  MVVM API Data Fetch
//
//  Created by Masrafi Anam on 28/7/24.
//

import Foundation

@MainActor  //@MainActor:- A singleton or global actor whose executor is equivalent to the main dispatch queue.
final class UserListViewModel: ObservableObject {  // ObservableObject :- A type of object with a publisher that emits before the object has changed.
    
    @Published var users: [UserModel]?   // @Published :- A property wrapper, allowing us to create observable objects that automatically announce when changes occur. SwiftUl will automatically monitor for such changes, and re-invoke the body property of any views that rely on the data.
    @Published var userError: UserError?
    @Published var shouldShowAlert = false
    @Published var isLoading = false
    
    func getUsers() async {
        isLoading = true
        do {
            self.users = try await WebService.getUsersData()
            self.isLoading = false
        } catch(let error) {
            userError = UserError.custom(error: error)
            shouldShowAlert = true
            isLoading = false
        }
    }
}
