//
//  AppIconStateView.swift
//  SwiftUIAlternateAppIcon (iOS)
//
//  Created by Kavisha Sonaal on 21/05/21.
//

import SwiftUI

struct AppIconStateView: View  {
    
    @StateObject private var iconSettings : IconNames = IconNames()
    
    @State var chosenIconName : String?
    
    var body: some View {
        
        /// The size of iconNames is 3 due to setting it as [nil] in the AppDelegate. This is done so that the default app icon will also be displayed in this list.
        List(self.iconSettings.iconNames, id: \.self) { item in
            
            HStack {
                HStack(spacing: 15) {
                    /// Still blurred image. It gives  a crispy image here if you dont have any AppIcon set in the Asset catalogue.
                    Image(uiImage: UIImage(named: item ?? "AppIcon") ?? UIImage())
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .cornerRadius(8)
                    
                    // Crispy image
                    Image(uiImage: UIImage(named: item ?? "AppIcon_01") ?? UIImage())
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        
                        if item == nil {
                            Text("Default")
                            ExternalLinkView(displayName: "@sonaal", clickableLink: "http://twitter.com/sonaal")
                        } else {
                            if let i = item,
                               let fileName = K.fileNameDisplayName[i],
                               let displayName = K.displayNameDisplayLink[i],
                               let clickableLink = K.nameClickableLink[i] {
                                
                                Text(fileName)
                                
                                ExternalLinkView(displayName: displayName, clickableLink: clickableLink)
                                
                            } else {
                                // error on fetching item name. cannot tap
                            }
                        }
                    }
                }
                
                Spacer()
                
                if item == self.chosenIconName {
                    Image(systemName: "checkmark.circle").foregroundColor(Color.accentColor)
                }
            }
            .padding([.top, .bottom], 10)
            .contentShape(Rectangle())
            .onTapGesture {
                if item != self.chosenIconName {
                    UIApplication.shared.setAlternateIconName(item) { error in
                        // TODO: Change this!
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Success! You have changed the app icon to = \(item)")
                            print(self.iconSettings.iconNames)
                            
                            self.chosenIconName = item
                            self.iconSettings.currentIconName = item
                        }
                    }
                }
            }
            // Set the chosenIndex here within the row. IMP: Set on link's onAppear ONLY. Doesnot work outside.
            .onAppear() {
                //self.chosenIndex = self.iconSettings.currentIndex
                //self.chosenIconName = self.iconSettings.currentIconName
                self.chosenIconName = UIApplication.shared.alternateIconName
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Choose Icon")
    }
}

struct AppIconStateView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconStateView()
    }
}
