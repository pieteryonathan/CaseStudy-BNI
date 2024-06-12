//
//  QRScannerController.swift
//  uph-mobile-ios
//
//  Created by Pieter Yonathan on 11/06/24.
//  Copyright © 2024 Suitmedia. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var safeView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 24
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 24, left: 24, bottom: 16, right: 24)
        return view
    }()
    
    lazy var viewSpacerTop: UIView = {
        let viewX = UIView()
        viewX.backgroundColor = .clear
        viewX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return viewX
    }()
        
    lazy var labelScan: UILabel = {
        let labelScan = UILabel()
        labelScan.textAlignment = .center
        labelScan.textColor = .white
        labelScan.text = "Scan QR here"
        labelScan.font = .systemFont(ofSize: 12, weight: .regular)
        return labelScan
    }()
    
    lazy var imageViewFrameQR: UIImageView = {
        let imageViewX = UIImageView()
        imageViewX.image = UIImage(named: "img_frame_qr")
        imageViewX.heightAnchor.constraint(equalToConstant: 312).isActive = true
        imageViewX.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageViewX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return imageViewX
    }()
    
    lazy var viewSpacer: UIView = {
        let viewX = UIView()
        viewX.backgroundColor = .clear
        viewX.setContentHuggingPriority(.defaultLow, for: .vertical)
        return viewX
    }()
    
    lazy var buttonFlash: UIButton = {
        // Create a flashlight button
        let buttonFlash = UIButton()
        buttonFlash.translatesAutoresizingMaskIntoConstraints = false
        buttonFlash.setImage(UIImage(systemName: "flashlight.on.circle.fill"), for: .normal)
        buttonFlash.setImage(UIImage(systemName: "flashlight.on.circle"), for: .selected)
        buttonFlash.tintColor = .orange
        buttonFlash.addTarget(self, action: #selector(toggleFlashlight), for: .touchUpInside)
        view.addSubview(buttonFlash)
        
        buttonFlash.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)

        
        // Add constraints for the flash button
        NSLayoutConstraint.activate([
            buttonFlash.widthAnchor.constraint(equalToConstant: 48),
            buttonFlash.heightAnchor.constraint(equalToConstant: 48),
            buttonFlash.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -48),
            buttonFlash.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        return buttonFlash
    }()

    
    lazy var labelFlash: UILabel = {
        let labelFlash = UILabel()
        labelFlash.textAlignment = .center
        labelFlash.textColor = .white
        labelFlash.text = "Flash"
        labelFlash.font = .systemFont(ofSize: 12, weight: .regular)
        return labelFlash
    }()
    
    // MARK: - VARIABLE DECLARATION
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var isFlashOn = false
    var isQRCodeDetected = false
    var backToHome: ((QRScannerController) -> Void)?

    // MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a session object
        captureSession = AVCaptureSession()
        
        // Create a preview layer for the video output
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: safeView, toView: self.view)
        
        safeView.addArrangedSubViews(views: [contentView])

        contentView.addArrangedSubViews(views: [viewSpacerTop, labelScan, imageViewFrameQR, viewSpacer, buttonFlash, labelFlash])
        
        contentView.setCustomSpacing(8, after: buttonFlash)
        
        viewSpacerTop.heightAnchor.constraint(equalTo: viewSpacer.heightAnchor, constant: -48).isActive = true
                
        // Get the back camera
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return
        }
        
        // Create an input object using the camera device
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            print("Failed to create input device")
            return
        }
        
        // Add the input to the capture session
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Failed to add video input to capture session")
            return
        }
        
        // Create an output object for metadata
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add the output to the capture session
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            // Set the delegate and metadata types
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Failed to add metadata output to capture session")
            return
        }
        
        // Start the capture session
        captureSession.startRunning()
    }
    
    // Implement the delegate method to handle captured metadata
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the QR code is already detected
        guard !isQRCodeDetected else {
            return
        }
        
        // Check if the metadata objects array is not empty
        if metadataObjects.isEmpty {
            return
        }
        
        // Get the metadata object
        if let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if metadataObj.type == .qr {
                isQRCodeDetected = true
                if let qrCodeString = metadataObj.stringValue {
                    print("Result: \(qrCodeString)")
                }
            }
        }
    }
    
    // MARK: - ACTION
        
    @objc func doDismiss() {
        
    }
    
    @objc func toggleFlashlight() {
        buttonFlash.isSelected.toggle()
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("Failed to access the camera device")
            return
        }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if device.isTorchAvailable {
                    device.torchMode = device.torchMode == .on ? .off : .on
                } else {
                    print("Torch mode is not available")
                }
                device.unlockForConfiguration()
            } catch {
                print("Failed to toggle flashlight: \(error.localizedDescription)")
            }
        } else {
            print("Flashlight is not available")
        }
    }
}
