//
//  ArchivedItemView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 17.02.24.
//

import SwiftUI

struct ArchivedSessionView: View {
    
    let date: String
    let myTopic: String
    let pathName: String

    var body: some View {
        VStack {
            HStack{
                Text(date)
                    .bold()
                Spacer()
                Text(pathName)
                    .foregroundColor(.blue)
            }
            HStack {
                Text(myTopic)
                Spacer()
            }
        }  
    }
}

#Preview {
    ArchivedSessionView(date: "2024-Mar_27", myTopic: "App Developer Exam", pathName: "SimplePath")
}
