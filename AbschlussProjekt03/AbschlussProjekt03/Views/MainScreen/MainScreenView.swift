import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct MainScreenView: View {
    @StateObject private var eventsViewModel = MainViewModel()
    @EnvironmentObject var logInViewModel: LogInViewModel
    @EnvironmentObject var preperationViewModel: PreperationViewModel
    @State private var showDurationSheet = false

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.black
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.purple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            Tab("Events", systemImage: "calendar.and.person") {
                VStack(alignment: .leading) {
                    Text("Event-Tracker")
                        .foregroundStyle(.purple)
                        .font(.title)
                        .padding(.horizontal, 30)
                    HStack {
                        TextField("Search Events...", text: $eventsViewModel.searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 10)

                        Button(action: {
                            eventsViewModel.fetchEvents()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .padding(10)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    if eventsViewModel.isLoading {
                        ProgressView("Loading Events...")
                            .padding()
                    } else if let errorMessage = eventsViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(eventsViewModel.events, id: \.id) { event in
                                    EventCardView(event: event, viewModel: eventsViewModel)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        }
                    }
                }
                .background {
                    Image(.main)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 420, height: 450)
                        .ignoresSafeArea()
                        .blur(radius: 3)
                        .offset(y: -25)
                }
                .onAppear {
                    eventsViewModel.fetchEvents()
                }
            }

            Tab("Guide", systemImage: "tent.2") {
                ZStack {
                    Image(.guide)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 420, height: 420)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDurationSheet = true
                        }
                }
                .sheet(isPresented: $showDurationSheet) {
                    DurationView()
                        .environmentObject(preperationViewModel)
                        .presentationDetents([.fraction(0.5)])
                }
            }

            Tab("Preparation", systemImage: "list.number.rtl") {
                PreperationView()
            }

            Tab("Profile", systemImage: "person.crop.circle") {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainScreenView()
        .environmentObject(LogInViewModel())
        .environmentObject(PreperationViewModel())
}
