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
    @State private var selectedEventSource: EventSource = .ticketmaster
    @State private var showAlert = false

    enum EventSource: String, CaseIterable, Identifiable {
        case ticketmaster = "Ticketmaster"
        case goabase = "GoaBase"

        var id: String { self.rawValue }
    }

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
                    Text("Hello, \(logInViewModel.username ?? "Traveler")!")
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white.opacity(0.3),
                                         Color.purple.opacity(0.8), Color.purple.opacity(0.9)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(.horizontal, 30)
                        .padding(.bottom, 15)

                    Text("Event-Tracker")
                        .font(.title)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white.opacity(0.3),
                                         Color.purple.opacity(0.8), Color.purple.opacity(0.9)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(.horizontal, 30)

                    Picker("Event Source", selection: $selectedEventSource) {
                        ForEach(EventSource.allCases) { source in
                            Text(source.rawValue).tag(source)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    HStack {
                        TextField("Search Events...", text: $eventsViewModel.searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                            .padding(.trailing, 10)

                        Button(action: {
                            if selectedEventSource == .goabase {
                                showAlert = true
                            } else {
                                eventsViewModel.fetchEvents()
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .padding(10)
                                .background(
                                    LinearGradient(
                                        colors: [Color.purple.opacity(0.7), Color.purple.opacity(0.4)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
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
                                if selectedEventSource == .ticketmaster {
                                    ForEach(eventsViewModel.events, id: \ .id) { event in
                                        EventCardView(event: event, viewModel: eventsViewModel)
                                    }
                                } else {
                                    ForEach(eventsViewModel.goabaseEvents, id: \ .id) { event in
                                        GoaBaseEventCardView(event: event, viewModel: eventsViewModel)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        }
                    }
                }
                .alert("GoaBase Search Unavailable", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("The search function for GoaBase events is not yet implemented. Please check back later.")
                }
                .background {
                    Image("LogIn1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 420, height: 420)
                        .ignoresSafeArea()
                        .offset(y: 24)
                }
                .onAppear {
                    eventsViewModel.fetchEvents()
                    eventsViewModel.fetchGoabaseEvents()
                }
            }
            Tab("Guide", systemImage: "tent.2") {
                GuideView()
                    .environmentObject(preperationViewModel)
                    .sheet(isPresented: $showDurationSheet) {
                        DurationView()
                            .environmentObject(preperationViewModel)
                    }
            }

/*
            Tab("Guide", systemImage: "tent.2") {
                ZStack {
                    Image("LogIn1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 420, height: 420)
                        .ignoresSafeArea()
                        .offset(y: 24)
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
*/
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


/*
 
 // BackUp Code
 
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
 @State private var selectedEventSource: EventSource = .ticketmaster
 
 enum EventSource: String, CaseIterable, Identifiable {
 case ticketmaster = "Ticketmaster"
 case goabase = "GoaBase"
 
 var id: String { self.rawValue }
 }
 
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
 Text("Hello, \(logInViewModel.username ?? "Traveler")!")
 .foregroundStyle(.purple)
 .font(.title2)
 .padding(.horizontal, 30)
 .padding(.bottom, 15)
 Text("Event-Tracker")
 .foregroundStyle(.purple)
 .font(.title)
 .padding(.horizontal, 30)
 
 Picker("Event Source", selection: $selectedEventSource) {
 ForEach(EventSource.allCases) { source in
 Text(source.rawValue).tag(source)
 }
 }
 .pickerStyle(SegmentedPickerStyle())
 .padding(.horizontal, 20)
 .padding(.top, 10)
 
 if selectedEventSource == .ticketmaster {
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
 }
 
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
 if selectedEventSource == .ticketmaster {
 ForEach(eventsViewModel.events, id: \.id) { event in
 EventCardView(event: event, viewModel: eventsViewModel)
 }
 } else {
 ForEach(eventsViewModel.goabaseEvents, id: \.id) { event in
 GoaBaseEventCardView(event: event, viewModel: eventsViewModel)
 }
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
 .offset(y: -25)
 }
 .onAppear {
 eventsViewModel.fetchEvents()
 eventsViewModel.fetchGoabaseEvents()
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
 */
