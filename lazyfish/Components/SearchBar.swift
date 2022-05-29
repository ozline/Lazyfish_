//
//  SearchBar.swift
//  lazyfish
//
//  Created by ozline on 2022/5/29.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    
    var onCommit: ((_ text: String) -> Void)?

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator

        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onCommit: self.onCommit)
    }

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var onCommit: ((_ text: String) -> Void)?

        init(text: Binding<String>, onCommit: ((_ text: String) -> Void)?) {
            _text = text
            self.onCommit = onCommit
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let onCommit = self.onCommit {
                onCommit(searchBar.text ?? "")
            }
        }
    }
}
