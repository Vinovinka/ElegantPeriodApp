import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        VStack(spacing: 35) {
            
            //Days...
            let days: [String] =
                ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(extraData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraData()[1])
                        .font(.title.bold())
                    
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation{
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal, 8.0)
        
            //Day View...
        
            HStack(spacing: 0) {
                ForEach(days,id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            //Dates....
            //Lazy grid...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in

                    CardView(value: value)
                        .background(
                            
                            Capsule()
                                .fill(Color("Pink"))
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0 )
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            
            //updating month...
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View{

        VStack {
            if value.day != -1 {
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.callout)
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Pink"))
                        .frame(width: 8, height: 8)
                    
                } else {
                    Text("\(value.day)")
                        .font(.callout)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }

            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
        
    }
    
    //checking dates...
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //Extracting Month and Year for display...
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date{
        let calendar = Calendar.current
        
        //Getting Current Month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue]{
        
        let calendar = Calendar.current
        
        //Getting Current Month date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            //getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day, starts from Monday...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
//        for _ in 0..<firstWeekday - 2 {
//            days.insert(DateValue(day: -1, date: Date()), at: 0)
//        }
        for _ in stride(from: 0, to: firstWeekday - 2, by: 1) {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
