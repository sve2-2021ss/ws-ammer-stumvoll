//
//  Jobs.swift
//  Statusdeck
//
//  Created by Simon Ammer on 14.05.21.
//

import SwiftUI

struct Jobs: View {
    @ObservedObject var viewModel: JobsViewModel

    var body: some View {
        if viewModel.loading {
            ProgressView()
                .onAppear(perform: { viewModel.reload() })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.error {
            Label(error.localizedDescription, systemImage: "exclamationmark.triangle")
                .padding(20)
        } else {
            List {
                ForEach(viewModel.jobs, id: \.id) { job in
                    NavigationLink(
                        destination: JobDetails(viewModel: JobDetailsViewModel(id: job.id)).navigationTitle(job.name != nil ? "Job: \(job.name!)" : "n/a"),
                        label: {
                            HStack {
                                StateIndicator(state: job.state)
                                VStack(alignment: .leading) {
                                    Text(job.name ?? "unknown")
                                    HStack {
                                        Image(systemName: "hourglass.bottomhalf.fill")
                                            .font(.system(size: 12))
                                        Text(job.startedAt != nil ? "\(job.startedAt!)" : "n/a")
                                            .font(.system(size: 12))
                                        Text("-")
                                            .font(.system(size: 12))
                                        Text(job.finishedAt != nil ? "\(job.finishedAt!)" : "n/a")
                                            .font(.system(size: 12))
                                    }
                                    .padding(.trailing)
                                    .foregroundColor(.gray)
                                }
                            }
                        }
                    )
                }
            }
            .modifier(MultiplatformListModifier())
        }
    }
}

struct Jobs_Previews: PreviewProvider {
    static var previews: some View {
        Jobs(viewModel: JobsViewModel(id: "1"))
    }
}
