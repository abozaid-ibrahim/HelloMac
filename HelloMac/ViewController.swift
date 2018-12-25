//
//  ViewController.swift
//  HelloMac
//
//  Created by Abuzeid Ibrahim on 12/25/18.
//  Copyright © 2018 abuzeid. All rights reserved.
//

import Cocoa
struct Constants{
    static  let iCloudPath = "Library/Mobile\\ Documents/com~apple~CloudDocs/"
    static let codeSnippetPath = "Library/Developer/Xcode/UserData/CodeSnippets/"
    static let homeUrl = FileManager.default.homeDirectoryForCurrentUser.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    enum fullPath{
        case iCloud = Constants.
    }
}



class ViewController: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    @IBAction func syncNowAction(_ sender: NSButton) {
     syncSnippets()
    }
    func syncSnippets(){
        
        guard checkIfDirectoryExist(path: Constants.homeUrl.appendingPathComponent(Constants.homeUrl.appendingPathComponent(Constants.codeSnippetPath))) else {
            return
        }
        
        
    }
    
    
    func createFolderInICloud(path:String) throws {
        do{
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }catch let error{
            throw MyAppErrors.failedToCreateFile(reason: error.localizedDescription)
        }
        
    }
    func copySnippets() throws {
        do {
            let from = Constants.homeUrl.appendingPathComponent(Constants.codeSnippetPath)
            let to = Constants.homeUrl.appendingPathComponent(Constants.iCloudPath)
            try FileManager.default.copyItem(at: from,to: to)
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            throw MyAppErrors.failedToCopyItem(reason: error.localizedDescription)
        }
    }
    
    func checkIfDirectoryExist(path:String)->Bool{
        var isDir: ObjCBool = false

        if FileManager.default.fileExists(atPath: path, isDirectory:&isDir) {
            if isDir.boolValue {
                // file exists and is a directory
                return true
            } else {
                // file exists and is not a directory
                return true
            }
        } else {
            // file does not exist
            return false
        }
        
    }
}

enum MyAppErrors:Error{
    case failedToCreateFile(reason:String),
    failedToCopyItem(reason:String)
}

