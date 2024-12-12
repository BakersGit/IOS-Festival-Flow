
import Foundation

class GuideViewModel: ObservableObject {
    
    let dayLists: [Int: [Item]] = [
        1: [
            Item(id: UUID().uuidString, name: "Water Bottle", quantity: "1", category: .food),
            Item(id: UUID().uuidString, name: "ID Card", quantity: "1", category: .documents)
        ],
        14: [
            // 14 Hygiene Items
            Item(id: UUID().uuidString, name: "Shampoo", quantity: "1 bottle", category: .hygiene),
            Item(id: UUID().uuidString, name: "Deodorant Spray", quantity: "1 can", category: .hygiene),
            Item(id: UUID().uuidString, name: "Toothbrush", quantity: "1", category: .hygiene),
            Item(id: UUID().uuidString, name: "Toothpaste", quantity: "1 tube", category: .hygiene),
            Item(id: UUID().uuidString, name: "Toilet Paper", quantity: "3 rolls", category: .hygiene),
            Item(id: UUID().uuidString, name: "Hairbrush", quantity: "1", category: .hygiene),
            Item(id: UUID().uuidString, name: "Hand Mirror", quantity: "1", category: .hygiene),
            Item(id: UUID().uuidString, name: "Towels", quantity: "3", category: .hygiene),
            Item(id: UUID().uuidString, name: "Disposable Razor", quantity: "2", category: .hygiene),
            Item(id: UUID().uuidString, name: "Contact Lenses", quantity: "14 pairs", category: .hygiene),
            Item(id: UUID().uuidString, name: "Sunscreen", quantity: "1 bottle", category: .hygiene),
            Item(id: UUID().uuidString, name: "Tissues", quantity: "3 packs", category: .hygiene),
            Item(id: UUID().uuidString, name: "Cotton Swabs", quantity: "1 box", category: .hygiene),
            
            // 8 First Aid Items
            Item(id: UUID().uuidString, name: "Bandages", quantity: "1 pack", category: .firstAid),
            Item(id: UUID().uuidString, name: "Painkillers (Headache, Stomachache, etc.)", quantity: "1 pack", category: .firstAid),
            Item(id: UUID().uuidString, name: "Insect Repellent", quantity: "1 bottle", category: .firstAid),
            Item(id: UUID().uuidString, name: "Wound Ointment", quantity: "1 tube", category: .firstAid),
            Item(id: UUID().uuidString, name: "After Sun Cream", quantity: "1 tube", category: .firstAid),
            Item(id: UUID().uuidString, name: "Magnesium Tablets", quantity: "14 tablets", category: .firstAid),
            Item(id: UUID().uuidString, name: "Disinfectant Spray", quantity: "1 bottle", category: .firstAid),
            Item(id: UUID().uuidString, name: "Tick Remover", quantity: "1", category: .firstAid),
            
            // 9 Clothing Items
            Item(id: UUID().uuidString, name: "T-Shirts", quantity: "8", category: .clothing),
            Item(id: UUID().uuidString, name: "Sweaters", quantity: "3", category: .clothing),
            Item(id: UUID().uuidString, name: "Pants", quantity: "4", category: .clothing),
            Item(id: UUID().uuidString, name: "Jacket", quantity: "1", category: .clothing),
            Item(id: UUID().uuidString, name: "Shoes", quantity: "1 pair", category: .clothing),
            Item(id: UUID().uuidString, name: "Underwear", quantity: "14 pairs", category: .clothing),
            Item(id: UUID().uuidString, name: "Swimsuit", quantity: "1", category: .clothing),
            Item(id: UUID().uuidString, name: "Rain Poncho", quantity: "1", category: .clothing),
            Item(id: UUID().uuidString, name: "Comfortable Clothes", quantity: "1 set", category: .clothing),
            Item(id: UUID().uuidString, name: "Pajamas", quantity: "1 set", category: .clothing),
            Item(id: UUID().uuidString, name: "Socks", quantity: "14 pairs", category: .clothing),
            
            // 20 Equipment Items
            Item(id: UUID().uuidString, name: "Water Bottle", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Backpack", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Earplugs", quantity: "1 pair", category: .equipment),
            Item(id: UUID().uuidString, name: "Waist Pouch/Chest Bag", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Tent", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Camping Chair", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Flashlight", quantity: "2", category: .equipment),
            Item(id: UUID().uuidString, name: "Batteries", quantity: "4", category: .equipment),
            Item(id: UUID().uuidString, name: "Tarp", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Tent Pegs", quantity: "8", category: .equipment),
            Item(id: UUID().uuidString, name: "Rubber Mallet", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Sleeping Mat/Air Mattress", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Lighting", quantity: "1 set", category: .equipment),
            Item(id: UUID().uuidString, name: "Water Canister", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Gas Stove + Cartridge", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Cooking Pot", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Dishes", quantity: "1 set", category: .equipment),
            Item(id: UUID().uuidString, name: "Lighter/Matches", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Cooler Bag", quantity: "1", category: .equipment),
            Item(id: UUID().uuidString, name: "Dishwashing Liquid", quantity: "1 bottle", category: .equipment),
            
            // 10 Food Items
            Item(id: UUID().uuidString, name: "Fruits (e.g., Apples)", quantity: "7", category: .food),
            Item(id: UUID().uuidString, name: "Canned Food", quantity: "10", category: .food),
            Item(id: UUID().uuidString, name: "Isotonic Tablets", quantity: "14", category: .food),
            Item(id: UUID().uuidString, name: "Spices", quantity: "1 set", category: .food),
            Item(id: UUID().uuidString, name: "Instant Noodles", quantity: "7 packs", category: .food),
            Item(id: UUID().uuidString, name: "Instant Coffee", quantity: "14 sachets", category: .food),
            Item(id: UUID().uuidString, name: "Tea Bags", quantity: "14", category: .food),
            Item(id: UUID().uuidString, name: "Crackers", quantity: "4 packs", category: .food),
            Item(id: UUID().uuidString, name: "Sugar/Coffee Whitener", quantity: "1 pack", category: .food),
            Item(id: UUID().uuidString, name: "Soup Packets", quantity: "5 packs", category: .food),
            
            // 7 Document Items
            Item(id: UUID().uuidString, name: "ID Card/Passport", quantity: "1", category: .documents),
            Item(id: UUID().uuidString, name: "Festival Tickets", quantity: "1", category: .documents),
            Item(id: UUID().uuidString, name: "Travel Insurance", quantity: "1", category: .documents),
            Item(id: UUID().uuidString, name: "Cash", quantity: "Sufficient", category: .documents),
            Item(id: UUID().uuidString, name: "Health Insurance Card", quantity: "1", category: .documents),
            Item(id: UUID().uuidString, name: "Driver's License", quantity: "1", category: .documents),
            Item(id: UUID().uuidString, name: "Directions", quantity: "1 copy", category: .documents),
            
            // 11 Other Items
            Item(id: UUID().uuidString, name: "Charging Cable", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Power Bank", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Clothesline", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Air Pump", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Radio/Speakers", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Toolkit", quantity: "1", category: .others),
            Item(id: UUID().uuidString, name: "Notebook and Pen", quantity: "1 set", category: .others),
            Item(id: UUID().uuidString, name: "Duct Tape", quantity: "1 roll", category: .others),
            Item(id: UUID().uuidString, name: "Cable Ties", quantity: "10", category: .others),
            Item(id: UUID().uuidString, name: "Blankets", quantity: "2", category: .others),
            Item(id: UUID().uuidString, name: "Sewing Kit", quantity: "1", category: .others)
        ]
    ]
}

