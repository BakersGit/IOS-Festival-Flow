import SwiftUI

struct DurationView: View {
    @State private var festivalDuration: Int = 1
    @State private var selectedGenre: String = "Electronic"
    let genres = ["Electronic", "Rock", "Hip-Hop", "Techno", "Classical"]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    if festivalDuration > 1 {
                        festivalDuration -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.red)
                }
                Spacer()
                
                Text("\(festivalDuration) Days")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
                Button(action: {
                    festivalDuration += 1
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            .padding(.horizontal)
            
            Picker("Music Genre", selection: $selectedGenre) {
                ForEach(genres, id: \.self) { genre in
                    Text(genre)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxHeight: 150)
            .padding(.horizontal)
            Spacer()
            Button(action: {
                print("GuideMe tapped. Days: \(festivalDuration), Genre: \(selectedGenre)")
            }) {
                Text("Guide Me")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.bottom, 50)
        .background {
            Image(.main)
                .resizable()
                .scaledToFill()
                .frame(width: 420, height: 450)
                .ignoresSafeArea()
                .blur(radius: 3)
                .offset(y: -25)
        }
    }
}

#Preview {
    DurationView()
}
