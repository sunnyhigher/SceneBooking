//
//  Array+Extension.swift
//  HD_PublicLib
//
//  Created by 波 on 2018/3/29.
//

import Foundation
extension Array {
    /// 避免数组越界
    func safeObject(_ index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
