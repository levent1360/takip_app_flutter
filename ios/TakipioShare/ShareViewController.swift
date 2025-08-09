//
//  ShareViewController.swift
//  TakipioShare
//
//  Created by Zeynep Sekmen on 8.08.2025.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
            if let item = extensionContext?.inputItems.first as? NSExtensionItem {
                if let attachments = item.attachments {
                    for provider in attachments {
                        if provider.hasItemConformingToTypeIdentifier("public.url") {
                            provider.loadItem(forTypeIdentifier: "public.url", options: nil) { (url, error) in
                                if let shareURL = url as? URL {
                                    let userDefaults = UserDefaults(suiteName: "group.com.truyazilim.takip.shared")
                                    userDefaults?.set(shareURL.absoluteString, forKey: "sharedLink")
                                    userDefaults?.synchronize()
                                }
                            }
                        }
                    }
                }
            }
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }

        private func saveSharedText(text: String) {
            let userDefaults = UserDefaults(suiteName: "group.com.truyazilim.takip.shared") // App Group adın
            userDefaults?.set(text, forKey: "sharedText")
            userDefaults?.synchronize()
        }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
