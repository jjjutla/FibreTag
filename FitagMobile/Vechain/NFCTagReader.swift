import Foundation
import CoreNFC

class NFCTagReader: NSObject, ObservableObject, NFCTagReaderSessionDelegate {
    @Published var message: String = "Scanned Message..."
    var session: NFCTagReaderSession?
    
    func scan() {
        let pollingOption = NFCTagReaderSession.PollingOption.iso14443
        session = NFCTagReaderSession(pollingOption: pollingOption, delegate: self)
        session?.alertMessage = "Hold your phone near to the tag"
        session?.begin()
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("tagReaderSessionDidBecomeActive \(session.description)")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("tagReaderSession \(error.localizedDescription)")
        message = error.localizedDescription
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        if tags.count > 1 {
            session.alertMessage = "More Than One Tag Detected, Please try again"
            session.invalidate()
        }
        print("tagReaderSession \(tags.first.debugDescription)")

        let tag = tags.first!
        session.connect(to: tag) { (error) in
            if nil != error{
                session.invalidate(errorMessage: error?.localizedDescription ?? "")
            }
            if case let .miFare(sTag) = tag {
//                let tagId = sTag.identifier
//                let formattedTagId = stride(from: 0, to: tagId.count, by: 2)
//                        .map { startIndex in
//                            let endIndex = tagId.index(startIndex, offsetBy: 2, limitedBy: tagId.endIndex) ?? tagId.endIndex
//                            return tagId[startIndex..<endIndex]
//                        }
//                        .joined(separator: ":")
                
                let UID = sTag.identifier.map{ String(format:"%02X", $0)}.joined()
                session.alertMessage = "Successfully linked tag to location"
                session.invalidate()
                DispatchQueue.main.async {
                    print("NFC Identifer = ", "\(UID)")
                    self.message = UID
                }
            }
        }
    }
}
    
    
