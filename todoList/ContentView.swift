//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Bilal Baig on 4/22/21.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentTask()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarTitle("Assignment Notebook")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                                    showingAddView = true }) {
                                    Image(systemName: "plus")
                                })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
    


}

struct Assignment: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
