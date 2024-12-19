/*
 
 Alter Code
 
 import SwiftUI

struct GoaBaseEventScrollView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.goabaseEvents, id: \.id) { event in
                    GoaBaseEventCardView(event: event, viewModel: viewModel)
                        .frame(width: 250)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 200)
    }
}
*/
