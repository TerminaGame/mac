//
//  Speech.swift
//  Termina
//
//  Created by Marquis Kurt on 12/13/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
struct Speech {
    
    static let shared = Speech()
    
    /**
     Random one-line dialogues used for NPCs. Generally describe their own feelings or about Termina.
     
     This is an array containing one-line dialogues and therefore doesn't include special escape sequences when parsing monologues by Termina or NPCs.
     */
    let randomMonologuesNPC = [
        "Remember: she is always watching.",
        "Was there ever a happy time?",
        "Once you go into the void, you can't come back.",
        "You better be well-equipped if you want to defeat her.",
        "I haven't showered in three weeks.",
        "She always looks at me funny.",
        "Programmers beware!",
        "Can I sleep now?",
        "This isn't fun anymore.",
        "It's just a game, she says.",
        "How is she even real?",
        "Her name is Termina.",
        "Please help me.",
        "I've waited here for a really long time.",
        "I don't think she likes me at all.",
        "\(NameGenerator().generateNameNPC()) stole my cookies!",
        "She's not fun at all.",
        "Frankly, she was a mistake.",
        "I don't blame you.",
        "Sometimes I wish she'd stop whining for just a second.",
        "What does she mean by that she's a corrupted object? Isn't that a nerd thing to say?",
        "I had my pudding today.",
        "No one really know what goes on in her head.",
        "I can't look at her straight without getting a need to run away.",
        "Maybe people would like her if she weren't so mean.",
        "And the toilets here are broken...",
        "I feel like someone took a crowbar to her face. Maybe it was the guy with the glasses that passed through here a little bit ago?",
        "I want my cake!",
        "Dreams come true. Or they're supposed to, anyway.",
        "I think Daniel did the graffiti on the wall. Not that I would know...",
        "Maybe she got dumped by her boyfriend or something...",
        "Sometimes I can hear her cry and sing a sad little tune at night.",
        "There must be something wrong with her head. Besides her face.",
        "Can we have a guardian angel to give her a good ass-whooping?",
        "Her staff looks like a really sweet candy that I can't get my hands on.",
        "I want breakfast.",
        "Sometimes I can't tell if she's crazy or just high...",
        "...",
        "Watch out for the turrets!",
        "I think someone made a fucky wucky or oingo boingo when approaching her.",
        "Does she dream of changelings jumping over a fence?",
        "I want to go home.",
        "Is it just me, or does she have a horrible sense of fashion?",
        "I don't know how she finds a dress above athletic clothing fashionably acceptable.",
        "Je déteste Termina.",
        "She kind of scares me.",
        "She looks like the kind of gal that was treated poorly as a kid.",
        "She's something alright...",
        "The last time anyone fell into her arms, they died.",
        "Is she a sorceress? She kind of looks like a sorceress.",
        "She feels fake to me.",
        "Why am I so scared to run away from her?",
        "She holds close our way out of this place.",
        "She's probably the smartest out of anyone in this building.",
        "Rumor has it that she hears everything in this place.",
        "I'd rather fight aliens than be her prisoner.",
        "Grapes.",
        "Sometimes, it feels like the end is never the end is never the end is never...",
        "Cheesecake.",
        "Have you ever wondered what it's like to fly?",
        "Do you smell something burning?",
        "Space dust!",
        "What would a life be without words?",
        "I think my pants are on fire.",
        "Why are you running around these halls?",
        "Meh.",
        "If people were radio stations, her station would probably be broken as a beer bottle on the ground.",
        "Once, I remember seeing her run away after seeing her reflection in some broken glass on the floor, crying.",
        "Poor thing.",
        "Take me to the old workshop.",
        "It's weird staring into her green eyes. Then again, I'm bad with colors...",
        "The thing is, once you leave a room, it no longer exists. Kinda weird, eh?",
        "What time is it?",
        "You have nice posture.",
        "Uwaa~!",
        "Obfuscation isn't security. It's just being a royal pain in the butt.",
        "Don't trust her!",
        "I'm sorry.",
        "No.",
        "Everything is probably as deadly as everything that isn't.",
        "Sense.",
        "We do what we must because... crap, I forgot what comes next.",
        "I saw a bird this morning.",
        "Nothing lasts forever."
    ]
    
}
