//
//  ContentView.swift
//  MVVM API Data Fetch
//
//  Created by Masrafi Anam on 28/7/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = UserListViewModel()  // ObservedObject:- A property wrapper type that subscribes toban observable object and invalidates a view whenever the observable object changes.
    var body: some View {
        ScrollView {
        VStack {
            ForEach(viewModel.users ?? [], id: \.id) { user in
                HStack {
                    AsyncImage(url: URL(string: user.avatarURL ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .foregroundColor(.teal)
                    }
                    .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(user.login?.capitalized ?? "")
                            .font(.headline)
                        Text(user.url ?? "")
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets())
            .background(Color.white)
            .navigationTitle("Users")
            
            if viewModel.isLoading {
                LoaderView()
            }
        }.padding()
        .task {
            print("Task")
            await viewModel.getUsers()    // await :- You place the await keyword wherever you need to call an async function.The await keyword creates a suspension point where the execution of your code may pause until the asynchronous function or method returns.
        }.alert(isPresented: $viewModel.shouldShowAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(viewModel.userError?.errorDescription ?? "")
            )
        }
    }
}
}

//#Preview {
//    ContentView()
//}
