//Ruan Jansen
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var favourits = Favourites()
    public var charName: String = ""
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(viewModel.characters, id: \.name){ item in
                        NavigationLink(destination: InfoView(characters: item, quotes: viewModel.quotes)){
                            HStack{
                                URLImage(urlString: item.img)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .cornerRadius(25)
                                VStack {
                                    Text(item.name)
                                        .font(.headline)
                                }.padding(20)
                                if( favourits.contains(item)){
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                    }
                }.onAppear(){
                    viewModel.loadData()
                        
                }
            }.navigationTitle("Breaking Bad")
        }
        .environmentObject(favourits)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


