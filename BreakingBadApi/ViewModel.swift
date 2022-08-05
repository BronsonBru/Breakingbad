//
//  ViewModel.swift
//  BreakingBadApi
//
//  Created by IACD -016 on 2022/06/28.
//

import Foundation
import SwiftUI

struct Character: Codable, Hashable{
    let name: String
    let nickname: String
    let status: String
    let char_id: Int
    let img : String
    let birthday: String
}

struct Quotes: Codable, Hashable{
    let quote_id: Int
    let quote: String
    let author: String
}

//Image
struct URLImage: View{
    let urlString: String
    @State var data: Data?
    var body: some View{
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable().aspectRatio(contentMode: .fill)
        }
        else{
            Image(systemName: "person")
                .resizable().aspectRatio(contentMode: .fill)
                .onAppear(){
                    loadImg()
                }
        }
    }
    private func loadImg(){
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        
        }
        print(urlString)
        task.resume()
    }
}

//API Call
class ViewModel: ObservableObject{
    @Published var characters : [Character] = []
    @Published var quotes : [Quotes] = []

    func loadData(){
        guard let url1 = URL(string: "https://breakingbadapi.com/api/characters") else {
            return
        }
        let task1 = URLSession.shared.dataTask(with: url1) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let characters = try JSONDecoder().decode([Character].self, from: data)
                    DispatchQueue.main.async {
                        self?.characters = characters
                    }
            } catch {
                print(error)
            }
        }
        task1.resume()
        
        guard let url2 = URL(string: "https://breakingbadapi.com/api/quotes") else {
            return
        }
        let task2 = URLSession.shared.dataTask(with: url2) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let quotes = try JSONDecoder().decode([Quotes].self, from: data)
                    DispatchQueue.main.async {
                        self?.quotes = quotes
                    }
            } catch {
                print(error)
            }
        }
        task2.resume()
    }
}

