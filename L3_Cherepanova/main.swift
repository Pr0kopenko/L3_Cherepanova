//
//  main.swift
//  L3_Cherepanova
//
//  Created by Виктория Черепанова on 20.03.2021.
//

import Foundation

enum WindowsState: String {
    case open = "Открыты"
    case closed = "Закрыты"
}
enum EngineState {
    case turnedOn, turnedOff
}

enum CarAction {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadTrunk (cargo: Double)
    case unloadTrunk (cargo: Double)
    case hookedTrunk
    case unhookedTrunk
}

struct SportCar {
    let brand: String
    let releaseYear: Int
    let trunkVolume: Double
    var trunkVolumeFilled: Double
    var carEngineState: EngineState
    var carWindowsState: WindowsState
    
    mutating func carChange (action: CarAction) {
            switch action {
            case .startEngine:
                carEngineState = .turnedOn
                print("Двигатель заведён")
            case .stopEngine:
                carEngineState = .turnedOff
                print("Двигатель выключен")
            case .openWindows:
                carWindowsState = .open
                print("Окна открыты")
            case .closeWindows:
                carWindowsState = .closed
                print("Окна закрыты")
            case .loadTrunk (let cargo):
                if cargo <= trunkVolume {
                    trunkVolumeFilled = cargo
                    print("В автомобиль загружено \(cargo) кг груза")
                }else{
                    print("В автомобиль нельзя положить столько груза, уберите \(cargo - trunkVolume) кг")
                }
                trunkVolumeFilled = cargo
            case .unloadTrunk (let cargo):
                if cargo <= trunkVolumeFilled {
                    trunkVolumeFilled = trunkVolumeFilled - cargo
                    print("Из автомобиля выгружено \(cargo) кг груза")
                }else{
                    print("Невозможно выгрузить из автомобиля \(cargo) кг. В автомобиле всего \(trunkVolumeFilled) кг  груза")
                }
            default:
                print("Вы пытаетесь совершить недопустимое для этого автомобиля действие")
            }
    
    }
}

struct TrunkCar {
    let brand: String
    let releaseYear: Int
    let trunkVolume: Double
    var trunkVolumeFilled: Double
    var carEngineState: EngineState
    var carWindowsState: WindowsState
    var trunkHooked: Bool
    
    mutating func carChange (action: CarAction) {
            switch action {
            case .startEngine:
                carEngineState = .turnedOn
                print("Двигатель заведён")
            case .stopEngine:
                carEngineState = .turnedOff
                print("Двигатель выключен")
            case .openWindows:
                carWindowsState = .open
                print("Окна открыты")
            case .closeWindows:
                carWindowsState = .closed
                print("Окна закрыты")
            case .hookedTrunk:
                trunkHooked = true
                print("Багажник прицеплен")
            case .unhookedTrunk:
                trunkHooked = false
                print("Багажник отцеплен")
            case .loadTrunk (let cargo):
                if trunkHooked == false {
                    print("Невозможно положить в автомобиль груз, пока багажник отцеплен")
                }else{
                    if cargo <= trunkVolume {
                        trunkVolumeFilled = cargo
                        print("В автомобиль загружено \(cargo) кг груза")
                    }else{
                        print("В автомобиль нельзя положить столько груза, уберите \(cargo - trunkVolume) кг")
                    }
                }
            case .unloadTrunk (let cargo):
                if cargo <= trunkVolumeFilled {
                    trunkVolumeFilled = trunkVolumeFilled - cargo
                    print("Из автомобиля выгружено \(cargo) кг груза")
                }else{
                    print("Невозможно выгрузить из автомобиля \(cargo) кг. В автомобиле всего \(trunkVolumeFilled) кг  груза")
                }
            }
    
    }
}

func printSportCarInfo (car: SportCar) {
    print("-----------------------------------")
    print(car.brand)
    print("Год выпуска: \(car.releaseYear)")
    print("Объём багажника: \(car.trunkVolume) кг")
    print("Заполненность багажника: \(car.trunkVolumeFilled) кг")
    print("Двигатель \(car.carEngineState == .turnedOn ? "заведён" : "выключен")")
    print("Окна \(car.carWindowsState == .closed ? "закрыты" : "открыты")")
    print("-----------------------------------")
}

func printTrunkCarInfo (car: TrunkCar) {
    print("-----------------------------------")
    print(car.brand)
    print("Год выпуска: \(car.releaseYear)")
    print("Объём багажника: \(car.trunkVolume) кг")
    print("Заполненность багажника: \(car.trunkVolumeFilled) кг")
    print("Багажник \(car.trunkHooked == true ? "прицеплен" : "отцеплен")")
    print("Двигатель \(car.carEngineState == .turnedOn ? "заведён" : "выключен")")
    print("Окна \(car.carWindowsState == .closed ? "закрыты" : "открыты")")
    print("-----------------------------------")
}

var car1 = SportCar (brand: "Subaru Impreza", releaseYear: 2005, trunkVolume: 300.0, trunkVolumeFilled: 5.5, carEngineState: .turnedOff, carWindowsState: .closed)
var car2 = TrunkCar (brand: "Toyota Hilux", releaseYear: 2015, trunkVolume: 1230.0, trunkVolumeFilled: 0.0, carEngineState: .turnedOff, carWindowsState: .closed, trunkHooked: true)
var car3 = SportCar(brand: "Ferrari", releaseYear: 2000,  trunkVolume: 200.0, trunkVolumeFilled: 5.5, carEngineState: .turnedOff, carWindowsState: .closed)
var car4 = TrunkCar (brand: "Jeep", releaseYear: 2015, trunkVolume: 1080.0, trunkVolumeFilled: 0.0, carEngineState: .turnedOff, carWindowsState: .closed, trunkHooked: false)

printSportCarInfo(car: car1)
printSportCarInfo(car: car3)
printTrunkCarInfo(car: car2)
printTrunkCarInfo(car: car4)


car1.carChange(action: .openWindows)
car2.carChange(action: .startEngine)
car2.carChange(action: .loadTrunk(cargo: 1000))
car3.carChange(action: .loadTrunk(cargo: 100))
car4.carChange(action: .loadTrunk(cargo: 300))

printSportCarInfo(car: car1)
printSportCarInfo(car: car3)
printTrunkCarInfo(car: car2)
printTrunkCarInfo(car: car4)
