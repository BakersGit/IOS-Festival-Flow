import Foundation
import SwiftUI



// Erstellt mittels Tutorial - Nicht komplett selbst erarbeitet


struct SplashView: View {
    
    @Binding var isFirstLaunch: Bool
    @State private var selectedItems: ItemSplash = items.first!
    @State private var introItems: [ItemSplash] = items
    @State private var activeIndex: Int = 0
    @State private var navigateToLogin = false
    
    var body: some View {
        ZStack {
            Image("Splash4")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Button {
                    updateItem(isForward: false)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.bold())
                        .foregroundStyle(.blue)
                        .contentShape(.rect)
                        .padding(.top, 20)
                }
                .padding(15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(selectedItems.id != introItems.first?.id ? 1 : 0)
                
                ZStack {
                    ForEach(introItems) { item in
                        AnimatedIconView(item)
                    }
                }
                .frame(height: 250)
                .frame(maxHeight: .infinity)
                
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        ForEach(introItems) { item in
                            Capsule()
                                .fill(selectedItems.id == item.id ? Color.primary : .gray)
                                .frame(width: selectedItems.id == item.id ? 25 : 4, height: 4)
                        }
                    }
                    .padding(.bottom, 15)
                    
                    Text(selectedItems.title)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                    
                    Button {
                        updateItem(isForward: true)
                    } label: {
                        Text(selectedItems.id == introItems.last?.id ? "Continue" : "Next")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 250)
                            .padding(.vertical, 12)
                            .background(.purple.gradient, in: .capsule)
                    }
                    .padding(.top, 25)
                    
                    if selectedItems.id == introItems.last?.id {
                        Button(action: {
                            isFirstLaunch = false
                        }) {
                            Text("Start your Flow!")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 250)
                                .padding(.vertical, 12)
                                .background(.blue.gradient, in: .capsule)
                        }
                        .padding(.top, 15)
                    }
                }
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .frame(maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: ItemSplash) -> some View {
        let isSelected = selectedItems.id == item.id
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120, height: 120)
            .background(.purple.gradient, in: .rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: -1, y: -1)
                    .padding(-3)
                    .opacity(selectedItems.id == item.id ? 1 : 0)
            }
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            .zIndex(isSelected ? 2 : item.zindex)
    }
    
    func updateItem(isForward: Bool) {
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0 else { return }
        var fromIndex: Int
        var extraOffset: CGFloat
        if isForward {
            activeIndex += 1
        } else {
            activeIndex -= 1
        }
        if isForward {
            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].extraOffset
        } else {
            extraOffset = introItems[activeIndex].extraOffset
            fromIndex = activeIndex + 1
        }
        
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        Task { [fromIndex, extraOffset] in
            withAnimation(.bouncy(duration: 3)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation = introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                introItems[activeIndex].offset = extraOffset
                introItems[fromIndex].zindex = 1
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            
            withAnimation(.bouncy(duration: 0.9)) {
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                
                selectedItems = introItems[activeIndex]
            }
        }
    }
}

#Preview {
    SplashView(isFirstLaunch: .constant(true))
}
