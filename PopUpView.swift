//
//  PopUpView.swift
//  TestViewsInSwiftUI
//
//  Created by Karl Holmlöv on 2022-03-07.
//

import SwiftUI

struct PopUpModel {
    
    var title: String
    var titleFontStyle: Font = .title
    var cornerRadius: CGFloat = 20
    var maxWidth: CGFloat = 400
    var listItems: [ListItem] = []
}

struct PopUpView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var model: PopUpModel
    
    init(pupUpModel: PopUpModel) {
        model = pupUpModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(model.title)
                .font(model.titleFontStyle)
                .padding(.vertical)
            Divider()
                .background(colorScheme == .dark ? Color.white : Color.black)
            
            ForEach(model.listItems) { listItem  in
                Divider()
                    .background(colorScheme == .dark ? Color.white : Color.black.opacity(0))
                
                listItem
                
            }
        }
            .frame(maxWidth: model.maxWidth)
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(model.cornerRadius)
            .padding()
    }
}

struct ListItem: View, Identifiable {
    var id = UUID()
    var leftItem: AnyView?
    var itemName: String
    var itemProperty: String?
    var rightItem: AnyView?
    var foregroundColor: Color?
    
    var body: some View {
        HStack {
            if let leftItem = leftItem {
                leftItem
            }
            VStack {
                Text(itemName)
                
                if let itemProperty = itemProperty {
                    Text(itemProperty)
                        .font(.footnote)
                }
            }
            Spacer()
            if let rightItem = rightItem {
                rightItem
            }
        }.frame(maxHeight: 60)
            .foregroundColor(foregroundColor != nil ? foregroundColor : Color.primary)
    }
}

// How to use
struct PopUpView_Previews: PreviewProvider {
    @State static var model = PopUpModel(title: "Add participant", titleFontStyle: .title3, listItems: [
        ListItem(leftItem: AnyView(Circle().fill(Color.red).scaledToFit().scaleEffect(0.2)) ,itemName: "Test", itemProperty: "test", rightItem: AnyView(Rectangle().fill(Color.red).scaledToFit().scaleEffect(0.5))),
        ListItem(leftItem: AnyView(Image(systemName: "play").scaledToFit().scaleEffect(1).padding(.leading, 30)), itemName: "Test", foregroundColor: .blue)])

    
    static var previews: some View {
        Group {
            ZStack {
                Color.blue // Only to see actual pop up
            SwiftUIView(pupUpModel: model)
                    .preferredColorScheme(.dark)
            }
                
        }
    }
}
