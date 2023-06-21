//
//  SafariView.swift
//  Orange
//
//  Created by Leon Rinkel on 21.06.23.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        uiViewController.dismissButtonStyle = .close
        uiViewController.delegate = context.coordinator
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var parent: SafariView

        init(_ parent: SafariView) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string:"https://example.org")!)
    }
}
