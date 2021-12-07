//
//  iCone.swift
//  Shared
//
//  Created by Bri on 12/5/21.
//

import SwiftUI

enum iCone: Hashable, CaseIterable, Identifiable {
    
    var label: String {
        switch self {
        case .ios:
            return "iOS"
        case .macos:
            return "macOS"
        case .watchos:
            return "watchOS"
        case .unspecified:
            return "--"
        }
    }
    
    static var allCases: [iCone] {
        [.ios("iOS"), .macos("macOS"), .watchos("watchOS")]
    }
    
    case unspecified
    case ios(_ imageName: String)
    case macos(_ imageName: String)
    case watchos(_ imageName: String)
//    case tvos(_ imageName: String)
//    case imessages(_ imageName: String)
    
    var id: UUID { UUID() }
    
    func generate(from origin: URL, to destination: URL) throws {
        
        let iconDirectory = destination.appendingPathComponent("\(label)-AppIcon.appiconset")
        
        try FileManager.default.createDirectory(
            at: iconDirectory,
            withIntermediateDirectories: true,
            attributes: nil
        )
        
        let contents = iconDirectory.appendingPathComponent("Contents.json")
        try templateContentMap.write(to: contents, atomically: true, encoding: .utf8)
        
        for specification in imageSpecifications {
            guard let ciImage = CIImage(contentsOf: origin) else {
                throw iConeError.incompatibleFile
            }
            
            let width = ciImage.extent.width
            let height = ciImage.extent.height
            
            guard width > 1024 && height > 1024 else {
                throw iConeError.imageTooSmall
            }
        
//            guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
//                throw iConeError.failedToEncodeCGImage
//            }
            
            try specification.exportImageScales(using: origin, to: iconDirectory)
        }
    }
}

extension iCone {
    
    var templateContentMap: String {
        switch self {
        case .unspecified:
            return ""
        case .ios(let imageName):
            return """
            {
              "images" : [
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-20@2x.png",
                  "idiom" : "iphone",
                  "scale" : "2x",
                  "size" : "20x20"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-20@3x.png",
                  "idiom" : "iphone",
                  "scale" : "3x",
                  "size" : "20x20"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29@2x.png",
                  "idiom" : "iphone",
                  "scale" : "2x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29@3x.png",
                  "idiom" : "iphone",
                  "scale" : "3x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-40@2x.png",
                  "idiom" : "iphone",
                  "scale" : "2x",
                  "size" : "40x40"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-40@3x.png",
                  "idiom" : "iphone",
                  "scale" : "3x",
                  "size" : "40x40"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-60@2x.png",
                  "idiom" : "iphone",
                  "scale" : "2x",
                  "size" : "60x60"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-60@3x.png",
                  "idiom" : "iphone",
                  "scale" : "3x",
                  "size" : "60x60"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-20.png",
                  "idiom" : "ipad",
                  "scale" : "1x",
                  "size" : "20x20"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-20@2x.png",
                  "idiom" : "ipad",
                  "scale" : "2x",
                  "size" : "20x20"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29.png",
                  "idiom" : "ipad",
                  "scale" : "1x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29@2x.png",
                  "idiom" : "ipad",
                  "scale" : "2x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-40.png",
                  "idiom" : "ipad",
                  "scale" : "1x",
                  "size" : "40x40"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-40@2x.png",
                  "idiom" : "ipad",
                  "scale" : "2x",
                  "size" : "40x40"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-76.png",
                  "idiom" : "ipad",
                  "scale" : "1x",
                  "size" : "76x76"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-76@2x.png",
                  "idiom" : "ipad",
                  "scale" : "2x",
                  "size" : "76x76"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-83.5@2x.png",
                  "idiom" : "ipad",
                  "scale" : "2x",
                  "size" : "83.5x83.5"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-1024.png",
                  "idiom" : "ios-marketing",
                  "scale" : "1x",
                  "size" : "1024x1024"
                }
              ],
              "info" : {
                "author" : "xcode",
                "version" : 1
              }
            }

            """
        case .macos(let imageName):
            return """
            {
              "images" : [
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-16.png",
                  "idiom" : "mac",
                  "scale" : "1x",
                  "size" : "16x16"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-32.png",
                  "idiom" : "mac",
                  "scale" : "2x",
                  "size" : "16x16"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-32.png",
                  "idiom" : "mac",
                  "scale" : "1x",
                  "size" : "32x32"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-64.png",
                  "idiom" : "mac",
                  "scale" : "2x",
                  "size" : "32x32"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-128.png",
                  "idiom" : "mac",
                  "scale" : "1x",
                  "size" : "128x128"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-256.png",
                  "idiom" : "mac",
                  "scale" : "2x",
                  "size" : "128x128"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-256.png",
                  "idiom" : "mac",
                  "scale" : "1x",
                  "size" : "256x256"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-512.png",
                  "idiom" : "mac",
                  "scale" : "2x",
                  "size" : "256x256"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-512.png",
                  "idiom" : "mac",
                  "scale" : "1x",
                  "size" : "512x512"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-1024.png",
                  "idiom" : "mac",
                  "scale" : "2x",
                  "size" : "512x512"
                }
              ],
              "info" : {
                "author" : "xcode",
                "version" : 1
              }
            }

            """
        case .watchos(let imageName):
            return """
            {
              "images" : [
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-24@2x.png",
                  "idiom" : "watch",
                  "role" : "notificationCenter",
                  "scale" : "2x",
                  "size" : "24x24",
                  "subtype" : "38mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-27.5@2x.png",
                  "idiom" : "watch",
                  "role" : "notificationCenter",
                  "scale" : "2x",
                  "size" : "27.5x27.5",
                  "subtype" : "42mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29@2x.png",
                  "idiom" : "watch",
                  "role" : "companionSettings",
                  "scale" : "2x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-29@3x.png",
                  "idiom" : "watch",
                  "role" : "companionSettings",
                  "scale" : "3x",
                  "size" : "29x29"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-33@2x.png",
                  "idiom" : "watch",
                  "role" : "notificationCenter",
                  "scale" : "2x",
                  "size" : "33x33",
                  "subtype" : "45mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-40@2x.png",
                  "idiom" : "watch",
                  "role" : "appLauncher",
                  "scale" : "2x",
                  "size" : "40x40",
                  "subtype" : "38mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-44@2x.png",
                  "idiom" : "watch",
                  "role" : "appLauncher",
                  "scale" : "2x",
                  "size" : "44x44",
                  "subtype" : "40mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-46@2x.png",
                  "idiom" : "watch",
                  "role" : "appLauncher",
                  "scale" : "2x",
                  "size" : "46x46",
                  "subtype" : "41mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-50@2x.png",
                  "idiom" : "watch",
                  "role" : "appLauncher",
                  "scale" : "2x",
                  "size" : "50x50",
                  "subtype" : "44mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-51@2x.png",
                  "idiom" : "watch",
                  "role" : "appLauncher",
                  "scale" : "2x",
                  "size" : "51x51",
                  "subtype" : "45mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-86@2x.png",
                  "idiom" : "watch",
                  "role" : "quickLook",
                  "scale" : "2x",
                  "size" : "86x86",
                  "subtype" : "38mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-98@2x.png",
                  "idiom" : "watch",
                  "role" : "quickLook",
                  "scale" : "2x",
                  "size" : "98x98",
                  "subtype" : "42mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-108@2x.png",
                  "idiom" : "watch",
                  "role" : "quickLook",
                  "scale" : "2x",
                  "size" : "108x108",
                  "subtype" : "44mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-117@2x.png",
                  "idiom" : "watch",
                  "role" : "quickLook",
                  "scale" : "2x",
                  "size" : "117x117",
                  "subtype" : "45mm"
                },
                {
                  "filename" : "\(imageName.trimmingCharacters(in: .whitespacesAndNewlines))-1024.png",
                  "idiom" : "watch-marketing",
                  "scale" : "1x",
                  "size" : "1024x1024"
                }
              ],
              "info" : {
                "author" : "xcode",
                "version" : 1
              }
            }
            """
//        case .tvos:
//            return """
//
//            """
//        case .imessages:
//            return """
//
//            """
        }
    }
}

extension iCone {
    
    var imageSpecifications: [ImageSpecification] {
        switch self {
        case .unspecified:
            return []
        case .ios(let imageName):
            return [
                ImageSpecification(
                    name: imageName,
                    width: 20,
                    height: 20,
                    scales: [.one, .two, .three]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 29,
                    height: 29,
                    scales: [.one, .two, .three]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 40,
                    height: 40,
                    scales: [.one, .two, .three]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 60,
                    height: 60,
                    scales: [.two, .three]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 76,
                    height: 76,
                    scales: [.one, .two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 83.5,
                    height: 83.5,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 1024,
                    height: 1024,
                    scales: [.one]
                ),
            ]
        case .macos(let imageName):
            return [
                ImageSpecification(
                    name: imageName,
                    width: 16,
                    height: 16
                ),
                ImageSpecification(
                    name: imageName,
                    width: 32,
                    height: 32
                ),
                ImageSpecification(
                    name: imageName,
                    width: 64,
                    height: 64
                ),
                ImageSpecification(
                    name: imageName,
                    width: 128,
                    height: 128
                ),
                ImageSpecification(
                    name: imageName,
                    width: 256,
                    height: 256
                ),
                ImageSpecification(
                    name: imageName,
                    width: 512,
                    height: 512
                ),
                ImageSpecification(
                    name: imageName,
                    width: 1024,
                    height: 1024
                ),
            ]
        case .watchos(let imageName):
            return [
                ImageSpecification(
                    name: imageName,
                    width: 24,
                    height: 24,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 27.5,
                    height: 27.5,
                    scales: [.two,]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 33,
                    height: 33,
                    scales: [.two,]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 29,
                    height: 29,
                    scales: [.two, .three]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 40,
                    height: 40,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 44,
                    height: 44,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 46,
                    height: 46,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 50,
                    height: 50,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 51,
                    height: 51,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 86,
                    height: 86,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 98,
                    height: 98,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 108,
                    height: 108,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 117,
                    height: 117,
                    scales: [.two]
                ),
                ImageSpecification(
                    name: imageName,
                    width: 1024,
                    height: 1024,
                    scales: [.one]
                ),
            ]
//        case .tvos(let _):
//            <#code#>
//        case .imessages(let _):
//            <#code#>
        }
    }
}

struct ImageSpecification: Identifiable {
    
    var name: String
    var width: CGFloat
    var height: CGFloat
    var scales: [ImageScale]?
    
    var id: UUID = UUID()
}
 
extension ImageSpecification {
    
    func exportImageScales(using origin: URL, to destination: URL) throws {
            
        func save(scale: ImageScale? = nil) throws {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            formatter.thousandSeparator = ""
            formatter.alwaysShowsDecimalSeparator = false
            
            var points: String {
                if width < height {
                    return formatter.string(from: NSNumber(floatLiteral: Double(width)))!
                }
                if width == height {
                    return formatter.string(from: NSNumber(floatLiteral: Double(width)))!
                }
                return formatter.string(from: NSNumber(floatLiteral: Double(height)))!
            }
            
            var filename: String = name + "-" + points
            
            if let scale = scale, scale != .one {
                filename = filename + "@\(formatter.string(from: NSNumber(floatLiteral: Double(scale.rawValue)))!)x"
            }
            
            let outputFile = destination.appendingPathComponent(filename + ".png")
            
            let scaledWidth = width * (scale?.rawValue ?? 1)
            let scaledHeight = height * (scale?.rawValue ?? 1)
            
#if os(macOS)
            let scaledSize = NSSize(width: scaledWidth, height: scaledHeight)
            guard let nsImage = NSImage(contentsOf: origin) else {
                assertionFailure()
                return
            }
            guard let scaledImage = nsImage.resizeMaintainingAspectRatio(withSize: scaledSize) else {
                assertionFailure()
                return
            }
            try scaledImage.savePngTo(url: outputFile)
#else
            let scaledSize = CGSize(width: scaledWidth, height: scaledHeight)
            var uiImage = UIImage(cgImage: cgImage)
            let renderer = UIGraphicsImageRenderer(size: scaledSize)
            
            uiImage = renderer.image { context in
                uiImage.draw(in: CGRect(origin: .zero, size: scaledSize))
            }
            
            guard let png = uiImage.pngData() else {
                assertionFailure()
                throw iConeError.failedToEncodePNGData
            }
            
            try png.write(
                to: outputFile,
                options: .atomic
            )
#endif
        }
        
        guard let scales = scales else {
            try save()
            return
        }

        for scale in scales {
            try save(scale: scale)
        }
    }
}

enum ImageScale: CGFloat {
    case one = 1
    case two = 2
    case three = 3
}

enum iConeError: Error {
    
    case incompatibleFile
    case imageTooSmall
    case failedToEncodeCGImage
    case failedToEncodePNGData
    case failedToWriteTiffBitmap
    case failedToWriteTiff
    
    var localizedDescription: String {
        switch self {
        case .incompatibleFile:
            return "The file you have chosen is not a valid image format. Please choose a JPEG or PNG image with a minimum resolution of 1024x1024."
        case .imageTooSmall:
            return "The chosen image is too small. Please choose another image with a minimum resolution of 1024x1024."
        case .failedToEncodeCGImage:
            return "The image failed to encode to intermediary data type (CGImage)"
        case .failedToEncodePNGData:
            return "The image failed to encode to destination data type (PNG)"
        case .failedToWriteTiffBitmap:
            return "The image failed to encode to intermediary data type (TIFF Bitmap)"
        case .failedToWriteTiff:
            return "The image failed to encode to intermediary data type (TIFF)"
        }
    }
}
