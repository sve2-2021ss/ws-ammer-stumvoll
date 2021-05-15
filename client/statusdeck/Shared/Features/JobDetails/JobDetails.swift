//
//  JobDetail.swift
//  Statusdeck
//
//  Created by Simon Ammer on 14.05.21.
//

import SwiftUI

struct JobDetails: View {
    @ObservedObject var viewModel: JobDetailsViewModel

    var body: some View {
        if viewModel.loading {
            ProgressView()
                .onAppear(perform: { viewModel.reload() })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.error {
            Label(error.localizedDescription, systemImage: "exclamationmark.triangle")
                .padding(20)
        } else if let job = viewModel.job {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("Issuer: " + (job.issuer.name != nil ? "\(job.name!)" : "n/a"))
                        Text("Started: " + (job.startedAt != nil ? "\(job.startedAt!)" : "n/a"))
                        Text("Finished: " + (job.finishedAt != nil ? "\(job.finishedAt!)" : "n/a"))
                    }
                }

                Section(header: Text("Changes")) {
                    ForEach(job.changes, id: \.id) { change in
                        VStack(alignment: .leading) {
                            Text(change.message)
                            Text(change.changer.name ?? "n/a")
                                .font(.system(size: 12))
                        }
                    }
                }

                Section(header: Text("Logs")) {
                    Text(job.logs ?? "n/a")
                        .listRowBackground(Color.black)
                        .lineLimit(10)
                        .font(.system(size: 14, design: .monospaced))
                        .foregroundColor(.white)
                }

                Section(header: Text("Stages")) {
                    ForEach(job.stages, id: \.id) { stage in
                        HStack {
                            StateIndicator(state: stage.state)
                            VStack(alignment: .leading) {
                                Text(stage.name)
                                HStack {
                                    Image(systemName: "hourglass.bottomhalf.fill")
                                        .font(.system(size: 12))
                                    Text(stage.startedAt != nil ? "\(stage.startedAt!)" : "n/a")
                                        .font(.system(size: 12))
                                    Text("-")
                                        .font(.system(size: 12))
                                    Text(stage.finishedAt != nil ? "\(stage.finishedAt!)" : "n/a")
                                        .font(.system(size: 12))
                                }
                                .padding(.trailing)
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .modifier(MultiplatformListModifier())
        } else {
            Text("No job description available")
        }
    }
}

struct JobDetails_Previews: PreviewProvider {
    static var previews: some View {
        JobDetails(viewModel: JobDetailsViewModel(id: "1"))
    }
}
