import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        
        
        if #available(iOS 15.0, *) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    //Custom Date Picker
                    CustomDatePicker(currentDate: $currentDate)
                    
                }
                .padding(.vertical)
            }
            
            // Safe area view

            .safeAreaInset(edge: .bottom) {
                HStack {
                    Button {
                    } label: {
                        Text("Add task")
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color("Orange"), in: Capsule())
                    }
                    
                    Button {
                    } label: {
                        Text("Add remainder")
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color("Purple"), in: Capsule())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
            }
        } else {
            Text("Update your iPhone please")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 13 Pro")
    }
}
