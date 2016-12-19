#!/usr/bin/swift
//
//  quicksort.swift
//  
//
//  Created by MITSUNOBUHOMMA on 2016/12/18.
//
//

// arc4random_uniform()を使うために必要
import Foundation

func quicksort (ary: inout [Int], l: Int = 0, r: Int = ary.count - 1)
{
    guard l < r else {
        return
    }
    
    // 配列の左端の値をピポットに選択
    let pivot = ary[l]
    var p = l
    for i in (l+1 ... r) {
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
    
    quicksort(ary: &ary, l: l, r: p-1)
    quicksort(ary: &ary, l: p+1, r: r)
}


func random_quicksort (ary: inout [Int], l: Int = 0, r: Int = ary.count - 1)
{
    guard l < r else {
        return
    }
    
    // 乱数でピボットを選択->ピボットを左に持ってくる
    let ran = Int(arc4random_uniform(UInt32(r - l))) + l
    if(ran != l) {
        swap(&ary[l], &ary[ran])
    }
    
    // あとは通常のquicksortと同じ
    let pivot = ary[l]
    var p = l
    for i in (l+1 ... r) {
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
    
    random_quicksort(ary: &ary, l: l, r: p-1)
    random_quicksort(ary: &ary, l: p+1, r: r)
}

// main

var ary = [5, 6, 2, 3, 8, 1, 9, 7, 4]

print(ary)

//quicksort(ary: &ary)
random_quicksort(ary: &ary)

print(ary)
