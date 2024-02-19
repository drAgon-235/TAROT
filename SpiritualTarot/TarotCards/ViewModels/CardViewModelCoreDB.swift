//
//  CardViewModelCoreDB.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import Foundation

import SwiftUI
import CoreData

class CardViewModelCoreDB: ObservableObject {
    
    init() {
        saveCardsToCoreDB()
        fetchCardsFromCoreDB()
    }
    // MARK: - Variables
    
    
    // The source of TarotCard-Data for the CoreDB:
    private let cardsRepo = TarotCardsRepo()
    
    // The Core DB:
    private let container = DBManager.shared
    @Published var allCards: [Card] = []
    
    
    // MARK: Functions
    
    func fetchCardsFromCoreDB() {
        let request = NSFetchRequest<Card>(entityName: "Card")
        
        do {
            allCards = try container.context.fetch(request)
        } catch {
            print("error fetching cards from CoreDB: \(error)")
        }
    }
    
    
    // Self made:
    func saveCardsToCoreDB() {
        // new version: Checking the CoreDB container itself (if it's empty):
        if container.containerIsEmpty() {
            
        /* //old version:  checking the CardViemModelCoreDB.allCards list:
            if allCards.isEmpty {
        */
                for card in cardsRepo.cardsList {
                    // transferring the hardcoded cards to CoreData:
                    let coreCard = Card(context: container.context)
                    coreCard.id = card.id
                    coreCard.name = card.name
                    coreCard.value = card.value
                    coreCard.suite = card.suite.name  // Enum
                    coreCard.keywords = card.keywords
                    coreCard.fortuneTelling = card.fortuneTelling
                    coreCard.meaning = card.meaning
                    coreCard.qTA = card.qTA
                    coreCard.descript = card.description
                    coreCard.image = card.image
                    
                    /*
                    if let imageData = card.image {
                        self.image = UIImage(data: imageData)
                    } else {
                        self.image = nil
                    }
                     */
                    container.save()
          //      }
            }
        }
    }
    
    // only needed for testing the CoreDB
    // (just deletes data, not the Entity itself):
    func delete() {
        let allcards = container.context.persistentStoreCoordinator
        for card in container.context.registeredObjects {
            container.context.delete(card)
            do {
                try container.context.save()
            } catch {
                print("Error deleting the CoreDB")
            }
        }
    }

    // (deletes the entire entity in CoreDB):
    func deletecard(_ tarotCard: Card) {
        container.context.delete(tarotCard)
        container.save()
        fetchCardsFromCoreDB()
    }

    
    // returns the deck (@Published var cards) shuffled - but does NOT shuffle THIS deck!!!:
    // (only used in "Your daily/random Card" as randomizer, used only once, each time)
    func shuffledDeck() -> [Card] {
        let shuffledDeck: [Card] = allCards.shuffled()
        return shuffledDeck
    }
    
    
    // only shuffles THIS deck - allows multiple shuffleing the deck before laying
    func justShuffle() {
        allCards.shuffle()
    }
    
        
}
    
    

