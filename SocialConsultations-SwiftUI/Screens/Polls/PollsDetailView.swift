//
//  PollsDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 14/10/2024.
//

import SwiftUI
import Charts

struct Result: Identifiable {
    let id = UUID()
    let name: String
    let number: Double
}

struct Stats: Identifiable {
    let id = UUID()
    let amount: Int
    let age: String
}

struct MockDataResult {
    static var array: [Result] = [
        .init(name: "Yes", number: 75000),
        .init(name: "No", number: 32000),
        .init(name: "Maybe", number: 14000)
        
    ]
}

struct PollsDetailView: View {
    
    @State private var isShowingBottomSheet = false
    @State private var option = ""
    
    let voteNumbers: [Stats] = [
        .init(amount: 370, age: "18-20"),
        .init(amount: 450, age: "20-25"),
        .init(amount: 900, age: "25-30"),
        .init(amount: 678, age: "30-35"),
        .init(amount: 1300, age: "35-40"),
        .init(amount: 1002,age: "40-45"),
        .init(amount: 1056,age: "45-50"),
        .init(amount: 445, age: "50-55"),
        .init(amount: 108, age: ">55"),
    ]
    
    let voteJobs: [Stats] = [
        .init(amount: 370, age: "Lawyer"),
        .init(amount: 450, age: "Doctor"),
        .init(amount: 600, age: "Builder"),
        .init(amount: 978, age: "Psychologist"),
        .init(amount: 1300, age: "IT"),
    ]
    
    var body: some View {
        
        ScrollView(.vertical) {
            infoSection
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
                .itemCornerRadius(20)
                .shadow(radius: 5)
                .padding()
            
            ChartHeader(title: "Current results", subtitle: "8765 voted")
            voteResults
            
            ChartHeader(title: "How did the group ages voted?", subtitle: "8765 voted")
            agesChart
            
            ChartHeader(title: "How did the jobs voted?", subtitle: "5 most voting jobs")
            jobsChart
            
        }
        .navigationTitle("Poll details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var infoSection: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("Poll details")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Social consultations about cars and buses")
                    .fontWeight(.medium)
                
                Text("Society of City Centre Residents")
                    .font(.subheadline)
                
                VStack(alignment: .leading) {
                    Text("Do you want to disallow electric cars in the city centre?")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Spacer()
                        
                        Button("Vote") {
                            isShowingBottomSheet.toggle()
                        }
                        .bold()
                        .font(.title2)
                        .frame(width: 300, height: 50)
                        .background(Color.blue.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top)
                        .padding(.bottom)
                        .sheet(isPresented: $isShowingBottomSheet) {
                            voteOptionView
                                .presentationDetents([.medium, .large])
                        }
                        
                        Spacer()
                    }
                }
                
            }
            .padding()
        }
    
    var voteOptionView: some View {
        VStack(spacing: 20) {
            Text("Choose option")
                .font(.title2)
                .bold()
                .padding(.top, 20)
            
            Text("You can change your decision before 27 July 2024 23:59")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.red)
                .offset(y: -10)
            
            VStack(spacing: 16) {
                Button("Yes") {
                    isShowingBottomSheet.toggle()
                    option = "Yes"
                }
                .bold()
                .font(.title2)
                .frame(width: 300, height: 50)
                .background(.green.gradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                
                Button("Maybe") {
                    isShowingBottomSheet.toggle()
                    option = "Maybe"
                }
                .bold()
                .font(.title2)
                .frame(width: 300, height: 50)
                .background(.orange.gradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                
                Button("No") {
                    isShowingBottomSheet.toggle()
                    option = "No"
                }
                .bold()
                .font(.title2)
                .frame(width: 300, height: 50)
                .background(.red.gradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                
                Button("Undo Vote") {
                    isShowingBottomSheet.toggle()
                    option = ""
                }
                .bold()
                .font(.title2)
                .frame(width: 300, height: 50)
                .background(.white)
                .foregroundStyle(.red.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
            }
        }
    }
    
    var voteResults: some View {
        Chart {
            ForEach(MockDataResult.array) { stream in
                
                //SectorMark(angle: .value("stream", stream.number))
                SectorMark(angle: .value("stream", stream.number),
                           innerRadius: .ratio(0.5),
                           angularInset: 1.0
                )
                .foregroundStyle(by: .value("Name", stream.name))
                .cornerRadius(6)
                .annotation(position: .overlay) {
                    Text(stream.name)
                        .bold()
                        .foregroundStyle(.white)
                        .offset(x: -2, y:4)
                }
            }
        }
        // .chartLegend(.hidden)
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .padding()
        // .frame(width: 380, height: 300)
    }
    
    var agesChart: some View {
        VStack {
            Chart {
                ForEach(voteNumbers) { item in
                    BarMark(x: .value("Age", item.age),
                            y: .value("Votes", item.amount)
                    )
                }
            }
            .foregroundStyle(.pink.gradient)
            .frame(height: 240)
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
    
    var jobsChart: some View {
        VStack {
            Chart {
                ForEach(voteJobs) { item in
                    BarMark(x: .value("Age", item.amount),
                            y: .value("Votes", item.age)
                    )
                }
            }
            .foregroundStyle(.yellow.gradient)
            .frame(height: 240)
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
    
}

struct ChartHeader: View {
    
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.title2)
                
                //.offset(y:14)
            
            Text(subtitle)
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 10)
        .padding(.bottom, -10)
    }
}

#Preview {
    NavigationStack {
        PollsDetailView()
    }
}


