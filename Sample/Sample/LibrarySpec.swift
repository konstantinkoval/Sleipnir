//
//  FirstSpec.swift
//  Sleipnir
//
//  Created by AlexDenisov on 6/16/14.
//  Copyright (c) 2014 railsware. All rights reserved.
//

import Sleipnir

class LibrarySpec : SleipnirSpec {
    
    var book : () = context("Book") {
        
        var swiftBook: Book?
        beforeAll {
            swiftBook = Book(title: "Introduction to Swift", author: "Apple Inc.")
        }
        
        it("has title") {
            expect(swiftBook!.title).to(equal("Introduction to Swift"))
        }
       
        it("has author") {
            expect(swiftBook!.author).to(equal("Apple Inc."))
        }
    }
    
    var library : () = context("Library") {
        
        var swiftLibrary: Library?
        beforeAll {
            swiftLibrary = Library()
        }
        
        afterAll {
            swiftLibrary = nil
        }
        
        describe("empty") {
            it("has no books") {
                expect(swiftLibrary!.hasBooks()).to(beFalse())
            }
        }
        
        describe("with books") {
            
            beforeEach {
                swiftLibrary!.addBook(Book(title: "Introduction to Swift", author: "Apple Inc."))
                swiftLibrary!.addBook(Book(title: "Using Swift with Cocoa", author: "Apple Inc."))
                swiftLibrary!.addBook(Book(title: "Swift tutorials", author: "John Doe"))
                swiftLibrary!.addBook(Book(title: "Programming iOS with Swift", author: "Vladimir Swiftin"))
            }
            
            afterEach {
                swiftLibrary!.clear()
            }
            
            it("is not empty") {
                expect(swiftLibrary!.hasBooks()).to(beTrue())
            }
            
            it("has correct number of books") {
                expect(swiftLibrary!.size()).to(equal(4))
                swiftLibrary!.removeLastBook()
                expect(swiftLibrary!.size()).to(equal(3))
            }
            
            describe("filters books") {
                it("by author") {
                    expect(swiftLibrary!.filterBy(author: "Apple Inc.").count).to(equal(2))
                }
                
                it("by title") {
                    expect(swiftLibrary!.filterBy(title: "tutorials").count).to(equal(1))
                }
            }
        }
    }

}

