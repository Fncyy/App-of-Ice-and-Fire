import Foundation
import Resolver
import UIKit

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { DiskDataSource() }
        register { NetworkDataSource() as AnApiOfIceAndFireAPI }
        register { IceAndFireInteractor() }
    }
}
