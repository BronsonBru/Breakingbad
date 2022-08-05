//
//  InfoView.swift
//  BreakingBadApi
//
//  Created by IACD -016 on 2022/06/28.
//

import SwiftUI

struct InfoView: View{
    var characters: Character?
    var quotes : [Quotes]?
    var characterQuotes = Quotes(quote_id: 0, quote: "", author: "")
    @EnvironmentObject var favourites: Favourites
    @StateObject  var viewModel = ViewModel()
    var quoteCount: Int = 0
    var body: some View{
        NavigationView{
            VStack {
                
                URLImage(urlString: characters!.img)
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(250)
                    .aspectRatio(contentMode: .fit)
                    .offset(y: -135)
                    .padding(.bottom, -130)
                Spacer()
                
                    VStack {
                        Text("\(characters!.name)").font(.largeTitle).padding(5)
                        Text("''\(characters!.nickname)''").font(.body).padding(2)
                        Text("\(characters!.status)").font(.body).padding(2)
                        Text("\(characters!.birthday)").font(.body).padding(2)
                        Image(systemName: favourites.contains(characters!) ? "heart.fill" : "heart")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.top,5)
                            .onTapGesture{
                    if (favourites.contains(characters!)){
                        favourites.remove(characters!)
                    }else{
                        favourites.add(characters!)
                    }
                }
                        Text("Quotes").font(.title).padding(5).padding(.top, 5)
                    }
                ScrollView {
                    ForEach(quotes!, id: \.quote){ item in
                        if (item.author == characters!.name){
                            let characterQuotes = item.quote
//                            var quoteCount = quoteCount + 1
                            Text("\(characterQuotes)")
                                .padding(.horizontal, 25)
                                .multilineTextAlignment(.center)
                                .lineSpacing(5)
                                .font(.body)
                                .padding(.vertical, 5)
                        }else{
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
}

//struct InfoView_Previews: PreviewProvider{
//    static var previews: some View{
//        NavigationView{
//            InfoView()
//        }
//    }
//}

