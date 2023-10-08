import Foundation
import CoreNFC
import SwiftUI

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {

    @Published var message: String = "Scanned Message..."
    var session: NFCNDEFReaderSession?
    
    func scan() {
        session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your phone near to the tag"
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        self.message = error.localizedDescription
        print("\(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let payload = String(data: record.payload, encoding: .ascii) {
                    self.message = payload
                }
            }
        }
    }
}
