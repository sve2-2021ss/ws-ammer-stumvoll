//
//  ItemListView.swift
//  statusdeck
//
//  Created by Simon Ammer on 07.05.21.
//

import SwiftUI

struct Pipeline: View {
    @ObservedObject var viewModel: PipelineViewModel

    var body: some View {
        #if os(macOS)
            return view
                .frame(minWidth: 400, minHeight: 600)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: viewModel.reload) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .keyboardShortcut("R", modifiers: .command)
                    }
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                                   NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                               },
                               label: {
                                   Image(systemName: "sidebar.left")
                               })
                            .keyboardShortcut("S", modifiers: .command)
                    }
                }
        #else
            return view
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                                   viewModel.reload()
                               },
                               label: {
                                   Image(systemName: "arrow.clockwise")
                               })
                    }
                }
                .navigationTitle("Status")
        #endif
    }

    @ViewBuilder
    private var view: some View {
        if viewModel.loading {
            ProgressView()
                .onAppear(perform: { viewModel.reload() })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.error {
            Label(error.localizedDescription, systemImage: "exclamationmark.triangle")
                .padding(20)
        } else {
            List {
                ForEach(viewModel.pipelines, id: \.id) { pipeline in
                    NavigationLink(
                        destination: Jobs(viewModel: JobsViewModel(id: pipeline.id)).navigationTitle("Jobs"),
                        label: {
                            HStack {
                                if pipeline.jobs.allSatisfy({ job in
                                    job.state == State.finished
                                }) {
                                    StateIndicator(state: .finished)
                                } else if pipeline.jobs.contains(where: { job in
                                    job.state == State.running
                                }) {
                                    StateIndicator(state: .running)
                                } else {
                                    StateIndicator(state: .upcoming)
                                }
                                Text(pipeline.name)
                            }
                        }
                    )
                }
            }
            .modifier(MultiplatformListModifier())
        }
    }
}

struct Pipelines_Previews: PreviewProvider {
    static var previews: some View {
        Pipeline(viewModel: PipelineViewModel())
    }
}
