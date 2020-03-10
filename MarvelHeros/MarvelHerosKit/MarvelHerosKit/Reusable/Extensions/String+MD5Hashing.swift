import CryptoKit

extension String {
    /// An MD5 hash is created by taking a string of an any length and encoding it into a 128-bit fingerprint.
    func MD5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
