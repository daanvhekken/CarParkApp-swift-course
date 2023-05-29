import SwiftUI

struct HomeListView: View {
    @ObservedObject private var authViewModel = AuthViewModel()
    @ObservedObject private var homeViewModel = HomeViewModel()
        
    init(authViewModel: AuthViewModel, homeViewModel: HomeViewModel) {
        self.authViewModel = authViewModel
        self.homeViewModel = homeViewModel
    }

    @State private var addHomeSheet: Bool = false
    @State private var isActionVisible: Bool = false
    
    var body: some View {
      NavigationView {
        ZStack {
            if homeViewModel.homes.count > 0 {
                List(homeViewModel.homes) { home in
                    HomeRowView(home: home, isDefault: authViewModel.appUser.defaultHomeId == home.id)
                        .padding(.vertical, 4)
                        .onLongPressGesture(minimumDuration: 1) {
                            withAnimation(.easeOut) {
                                isActionVisible.toggle()
                            }
                        }
                        .contextMenu {
                            if authViewModel.appUser.defaultHomeId == home.id {
                                Button {
                                    authViewModel.unsetAsDefault()
                                    isActionVisible.toggle()
                                } label: {
                                    Label("Remove home as default", systemImage: "heart")
                                }
                            } else {
                                Button {
                                    authViewModel.setAsDefault(homeId: home.id)
                                    isActionVisible.toggle()
                                } label: {
                                    Label("Add home as default", systemImage: "heart.fill")
                                }
                            }
                        }
                }.navigationBarTitle("Homes")
            } else {
                VStack(alignment: .leading) {
                    Text("No homes found").font(.title)
                    Text("Add a new home here..").font(.subheadline)
                }
            }
            
            // Floating Button Panel
            VStack {
              Spacer()
              HStack {
                Spacer()
                HomeListActions(
                  primaryItem: HomeListActionItem(label: ""),
                  secondaryItems: [
                    HomeListActionItem(label: "house") {
                        self.addHomeSheet = true
                    }
                  ]
                )
                .padding()
              }
            }
          }
        }
          .onAppear {
              homeViewModel.fetchData()
          }
          
        .sheet(isPresented: $addHomeSheet, content: {
            HomeAddView(authViewModel: authViewModel, homeViewModel: homeViewModel, addHomeSheet: $addHomeSheet)
        })
    }
}

//struct HomeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeListView()
//    }
//}
