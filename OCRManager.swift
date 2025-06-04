//
//  OCRManager.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import Vision
import UIKit

class OCRManager {
    static func recognizeText(from image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            completion("")
            return
        }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                completion("")
                return
            }

            let recognizedText = observations.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: "\n")

            completion(recognizedText)
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        DispatchQueue.global(qos: .userInitiated).async {
            try? requestHandler.perform([request])
        }
    }
}
