//
//  ContentView.swift
//  Shared
//
//  Created by Kavisha Sonaal on 21/05/21.
//

import SwiftUI

/*
 Reddit user mentioned that the code works on a restart - https://www.reddit.com/r/SwiftUI/comments/k4k5o5/how_do_i_allow_the_user_to_change_app_icons/gyt0irz/
 It works fine on a Simulator anyways.
 */
struct ContentView: View {
    
    // Refer to details mentioned in AppIconView saying why this is commented.
    // @EnvironmentObject var iconSettings: IconNames
    
    @StateObject private var iconSettings : IconNames = IconNames()
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Appearance")) {
                    /*NavigationLink(destination: AppIconView()) {
                        Label("Choose another App Icon", systemImage: "square.grid.2x2").foregroundColor(Color.primary)
                    }
                    
                    NavigationLink(destination: AppIconPickerView()) {
                        Label("Choose another App Icon", systemImage: "square.grid.2x2").foregroundColor(Color.primary)
                    }*/
                    
                    NavigationLink(destination: AppIconStateView()) {
                        Label("Choose another App Icon", systemImage: "square.grid.2x2").foregroundColor(Color.primary)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - ALTERNATE ICONS

class IconNames: ObservableObject {
    
    /// Setting nil at the first index to support the primary icon to be displayed. i.e when the iconname is nil, the primary icon will be set.
    /// the first element of the iconNames array is set as nil as an indicator of the primary app icon.
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    @Published var currentIconName: String?
    
    init() {
        getAlternateIconNames()
        
        self.currentIconName = UIApplication.shared.alternateIconName
        
        /*if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }*/
    }
    
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String,Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                
                iconNames.append(icon)
            }
            print("iconNames \(iconNames)")
            print("\n")
        }
    }
}


struct K {
    
    // Add more icons here
    static var fileNameDisplayName: Dictionary<String, String> = [
        "MNM_01":"Forks",
        "MNM_02":"Funky Forks",
        "MNM_Sonaal01" : "Pretty Veg"
    ]
    //linkClickableSafariLink
    static var displayNameDisplayLink: Dictionary<String, String> = [
        "Default": "@sonaal",
        "MNM_01":"www.crawfordandjohn.com",
        "MNM_02":"www.crawfordandjohn.com"
    ]
    
    static var nameClickableLink: Dictionary<String, String> = [
        "Default": "http://twitter.com/sonaal",
        "MNM_01":"https://www.crawfordandjohn.com",
        "MNM_02":"https://www.crawfordandjohn.com"
    ]
}
