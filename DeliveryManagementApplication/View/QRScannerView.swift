//
//  QRScannerView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 11/6/25.
//


//
//  QRScannerView.swift
//  DeliveryManagementApplication
//
//  Created by YourName on YourDate.
//

import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {
    var onScanSuccess: (String) -> Void

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let viewController = QRScannerViewController()
        viewController.onScanSuccess = onScanSuccess
        // Pass the ViewController's session to the Coordinator when the Coordinator is made
        // The Coordinator's setup will happen within makeUIViewController's lifecycle
        context.coordinator.session = viewController.captureSession // Pass the session
        return viewController
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {
        // No update needed for this simple scanner
    }

    func makeCoordinator() -> Coordinator {
        // Initialize coordinator without session initially. Session will be set after VC creation.
        Coordinator(parent: self, session: nil)
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScannerView
        var session: AVCaptureSession? // This will be set from makeUIViewController

        init(parent: QRScannerView, session: AVCaptureSession?) {
            self.parent = parent
            self.session = session
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }

                // Stop scanning immediately after capturing the first code
                session?.stopRunning() // Use the stored session reference

                // Call the closure with the scanned value on the main thread
                DispatchQueue.main.async {
                    self.parent.onScanSuccess(stringValue)
                }
            }
        }
    }
}

// MARK: - QRScannerViewController (UIKit part)

class QRScannerViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var onScanSuccess: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ensure session starts if it's not running
        if captureSession?.isRunning == false {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession?.startRunning()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Ensure session stops when view disappears
        if captureSession?.isRunning == true {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession?.stopRunning()
            }
        }
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            failed()
            return
        }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Could not create video input: \(error)")
            failed()
            return
        }

        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) // Delegate is THIS UIViewController
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession ?? AVCaptureSession())
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
    }

    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

// MARK: - Extend QRScannerViewController to conform to AVCaptureMetadataOutputObjectsDelegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }

            // Stop scanning immediately after capturing the first code
            captureSession?.stopRunning()

            // Call the success closure
            DispatchQueue.main.async {
                self.onScanSuccess?(stringValue) // Call the closure passed from SwiftUI
            }
        }
    }
}
