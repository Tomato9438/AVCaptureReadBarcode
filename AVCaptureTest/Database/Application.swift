//
//  Application.swift
//  TextCandy 2
//
//  Created by Tom Bluewater on 11/14/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation

class Application {
    static func createData(path: String) {
        var statement: OpaquePointer? = nil
        sqlite3_open(path, &statement)
        let sqlCreate1 = "CREATE TABLE IF NOT EXISTS data1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, barcode text, uuid text, x1 text, x2 text, x3 text)"
        let sqlCreate2 = "CREATE TABLE IF NOT EXISTS data2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, x1 text, x2 text, x3 text, x4 text, x5 text)" // not used
        let sqlCreate3 = "CREATE TABLE IF NOT EXISTS data3 (ID INTEGER PRIMARY KEY AUTOINCREMENT, x1 text, x2 text, x3 text, x4 text, x5 text)" // not used
        sqlite3_exec(statement, (sqlCreate1 as NSString).utf8String, nil, nil, nil)
        sqlite3_exec(statement, (sqlCreate2 as NSString).utf8String, nil, nil, nil)
        sqlite3_exec(statement, (sqlCreate3 as NSString).utf8String, nil, nil, nil)
    }
    
    static func insertData1(path: String, barcode: String, uuid: String) {
        // rectName as new record name, x1 as old record name
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "INSERT INTO data1 (barcode, uuid, x1, x2, x3) VALUES (?, ?, ?, ?, ?)"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
            }
            sqlite3_bind_text(statement, 1, barcode, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 2, uuid, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 3, "0", -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 4, "0", -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 5, "0", -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_step(statement)
            sqlite3_finalize(statement)
        }
    }
    
    static func readData1(path: String) -> [Dictionary<String, String>] {
        var statement: OpaquePointer? = nil
        var dataArray = [Dictionary<String, String>]()
        
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "SELECT barcode, uuid, x1, x2, x3 FROM data1"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
                return []
            }
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                let str0 = ((sqlite3_column_text(statement, 0)) != nil) ? String(cString: sqlite3_column_text(statement, 0)) : ""
                let str1 = ((sqlite3_column_text(statement, 1)) != nil) ? String(cString: sqlite3_column_text(statement, 1)) : ""
                //let str2 = ((sqlite3_column_text(statement, 2)) != nil) ? String(cString: sqlite3_column_text(statement, 2)) : ""
                //let str3 = ((sqlite3_column_text(statement, 3)) != nil) ? String(cString: sqlite3_column_text(statement, 3)) : ""
                //let str4 = ((sqlite3_column_text(statement, 4)) != nil) ? String(cString: sqlite3_column_text(statement, 4)) : ""
                let dict = ["barcode": str0, "uuid": str1]
                dataArray.append(dict)
            }
            sqlite3_finalize(statement)
        }
        return dataArray
    }
    
    static func deleteData1(path: String, uuid: String) {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "DELETE FROM data1 WHERE uuid = '\(uuid)'"
            if sqlite3_prepare_v2(statement,sql,-1,&statement,nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    //print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
    static func deleteAllData1(path: String) {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "DELETE FROM data1"
            if sqlite3_prepare_v2(statement,sql,-1,&statement,nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    //print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
    static func updateData1Onoff(path: String, folder: String, value: String) {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "UPDATE data1 SET onoff = ? WHERE name = ?"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
            }
            sqlite3_bind_text(statement, 1, value, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 2, folder, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_step(statement)
            sqlite3_finalize(statement)
            //sqlite3_close(statement)
        } else {
            print("The database not open...")
            //sqlite3_close(statement)
        }
    }
    
    static func updateData1Place(path: String, folder: String, place: String) {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "UPDATE data1 SET place = ? WHERE name = ?"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
            }
            sqlite3_bind_text(statement, 1, place, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 2, folder, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_step(statement)
            sqlite3_finalize(statement)
            //sqlite3_close(statement)
        } else {
            print("The database not open...")
            //sqlite3_close(statement)
        }
    }
    
    static func countData1a(path: String, newRec: String) -> Int {
        // counting a record based on a new rec name: preventing the user from rating its own movie screenshot //
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "SELECT COUNT(*) FROM data1 WHERE recName='\(newRec)'"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
                return -1
            }
            if(sqlite3_step(statement) == SQLITE_ROW) {
                let r = sqlite3_column_int(statement, 0)
                sqlite3_finalize(statement)
                return Int(r)
            } else {
                sqlite3_finalize(statement)
                return -1
            }
        } else {
            sqlite3_finalize(statement)
            return -1
        }
    }
    
    static func countData1b(path: String, oldRec: String) -> Int {
        // counting a record based on an old rec name: preventing the user from submitting the same movie screenshot twice //
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "SELECT COUNT(*) FROM data1 WHERE x1='\(oldRec)'"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
                return -1
            }
            if(sqlite3_step(statement) == SQLITE_ROW) {
                let r = sqlite3_column_int(statement, 0)
                sqlite3_finalize(statement)
                return Int(r)
            } else {
                sqlite3_finalize(statement)
                return -1
            }
        } else {
            sqlite3_finalize(statement)
            return -1
        }
    }
}

