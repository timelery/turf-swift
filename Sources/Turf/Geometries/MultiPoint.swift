import Foundation
#if !os(Linux)
import CoreLocation
#endif


public struct MultiPoint: Equatable {
    public let coordinates: [CLLocationCoordinate2D]
    
    public init(_ coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
}
