//
//  LatestPhoto.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI
import Photos

class LatestPhoto : NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("Change")
        
        DispatchQueue.main.async {
            self.fetchPhoto()
        }
    }
    
    @Published var photo: Image?
    @Published var image: UIImage?
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
        fetchPhoto()
    }
    
    func fetchPhoto() {
        print("Getting latest photo")
        let options = PHFetchOptions()
        options.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
        
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        let fetchResult = PHAsset.fetchAssets(with: options)
        
        if fetchResult.count > 0 {
            // fetchResult.firstObject!.pixelWidth / 4
            PHImageManager.default().requestImage(for: fetchResult.firstObject!, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: nil) { (image, userInfo) -> Void in
                self.objectWillChange.send()
                self.image = image
                // TODO: Non-null assertion should be checked
                self.photo = Image(uiImage: image!)
            }
        }
    }
}
