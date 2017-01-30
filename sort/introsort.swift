#!/usr/bin/swift
//
//  introsort.swift
//
//  Created by MITSUNOBUHOMMA on 2017/01/30.
//

import Foundation

func quicksort (ary: [Int], d: Int) -> [Int]
{
    var ary = ary
    let l = 0
    let r = ary.count - 1
    
    guard l < r else {
        return ary
    }
    
    if (d == 0) {
        return heapsort(ary: Array(ary[l...r]))
    }
    
    // 配列の左端の値をピポットに選択
    let pivot = ary[l]
    var p = l
    for i in (l+1...r) {
        if(ary[i] < pivot) {
            p += 1
            // NOTE: swapping a location with itself is not supported
            if(p != i) {
                swap(&ary[p], &ary[i])
            }
        }
    }
    // NOTE: swapping a location with itself is not supported
    if(p != l) {
        swap(&ary[l], &ary[p])
    }
    
    var pre = [Int]()
    var suf = [Int]()
    let queue = OperationQueue()
    
    let ope1 = BlockOperation {
        pre = quicksort(ary: Array(ary[l...p-1]), d: d-1)
    }
    queue.addOperation(ope1)
    
    let ope2 = BlockOperation {
        suf = quicksort(ary: Array(ary[p+1...r]), d: d-1)
    }
    queue.addOperation(ope2)
    
    queue.waitUntilAllOperationsAreFinished()
    
    return pre + Array(ary[p..<p+1]) + suf
}

func heapsort (ary: [Int]) -> [Int]
{
    var ary = ary
    let l = 0
    let r = ary.count - 1
    
    guard l < r else {
        return ary
    }
    
    // ヒープを作る
    let size = r - l
    for i in (0 ... size) {
        var j = i
        while (j > 0) {
            let k = (j-1)/2
            if (ary[k] < ary[j]) {
                swap(&ary[k], &ary[j])
                j = (j-1)/2
            } else {
                break
            }
        }
    }
    
    // ヒープを入れ替えてソートする
    for i in (1 ... size).reversed() {
        swap(&ary[l], &ary[i])
        var j = 0
        var k = 0
        while(true) {
            let left = 2*j + 1
            let right = 2*j + 2
            if(left >= i) {
               break
            }
            if(ary[left] > ary[k]) {
                k = left
            }
            if(right < i && ary[right] > ary[k]) {
                k = right
            }
            if(k == j) {
                break
            }
            swap(&ary[k], &ary[j])
            j = k
        }
    }
    
    return ary
}

func introsort (ary: [Int], d: Int = 2) -> [Int]
{
    if(d == 0) {
        return heapsort(ary: ary)
    }
    
    return quicksort(ary: ary, d: d)
}

// main

let size = 1000000
var ary = [Int]()
ary += 1...size

for i in (0 ... size-1) {
    var k = Int(arc4random_uniform(UInt32(size - 1)))
    // NOTE: swapping a location with itself is not supported
    if(i != k) {
        swap(&ary[i], &ary[k])
    }
}

print("init  : \(ary)")

var start = Date()
let result = introsort(ary: ary)
var end = Date()

print("sorted: \(result)")
print("execution time: \(end.timeIntervalSince1970 - start.timeIntervalSince1970)")
