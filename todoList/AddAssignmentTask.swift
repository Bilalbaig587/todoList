import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList: AssignmentTask
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["English", "Maths", "Science", "PE", "History", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Priority", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment")
            .navigationBarItems(trailing: Button("Save") {
                if(course.count > 0 && description.count > 0) {
                    let item = Assignment(id: UUID(),
                                          course: course,
                                        description: description,
                                        dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
    
    struct AddItemView_Previews: PreviewProvider {
        static var previews: some View {
            AddAssignmentView(assignmentList: AssignmentTask())
        }
    }
