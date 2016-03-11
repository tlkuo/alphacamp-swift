//
//  PoemList.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation

class Poets {

    struct Poem {
        var title: String
        var content: String
        var description: String
    }

    struct Poet {
        var name: String
        var poemList: [Poem]
    }

    var list: [Poet] = []

    init() {

        do {
            let poet = Poet(name: "孟浩然", poemList: [
                Poem(title: "春曉",
                    content: "春眠不覺曉，處處聞啼鳥。夜來風雨聲，花落知多少。",
                    description: "春意綿綿好睡覺，不知不覺天亮了；猛然一覺惊醒來，到處是鳥儿啼叫。夜里迷迷胡胡，似乎有沙沙風雨聲；呵風雨風雨，花儿不知吹落了多少？"),
                Poem(title: "宿建德江",
                    content: "移舟泊煙渚，日暮客愁新。野曠天低樹，江清月近人。",
                    description: "我把船停泊在暮煙籠罩的小洲，茫茫暮色給游子新添几分鄉愁。曠野無垠遠處天空比樹木還低，江水清澈更覺月与人意合情投。")
                ])

            list.append(poet)
        }
        
        do {
            let poet = Poet(name: "李白", poemList: [
                Poem(title: "夜思",
                    content: "床前明月光，疑是地上霜。舉頭望明月，低頭思故鄉。",
                    description: "皎洁的月光洒到床前，迷离中疑是秋霜一片。仰頭觀看明月呵明月，低頭鄉思連翩呵連翩。"),
                Poem(title: "怨情",
                    content: "美人卷珠帘，深坐蹙蛾眉。但見淚痕濕，不知心恨誰。",
                    description: "美人儿卷起珠帘等待等待，一直坐著把雙眉緊緊鎖閉。只看見她淚痕濕滿了兩腮，不知道她是恨人還是恨己。")
                ])

            list.append(poet)
        }
        
        do {
            let poet = Poet(name: "王維", poemList: [
                Poem(title: "鹿柴",
                    content: "空山不見人，但聞人語響。返影入深林，复照青苔上。",
                    description: "山中空空蕩蕩不見人影，只听得喧嘩的人語聲響。夕陽的金光射入深林中，青苔上映著昏黃的微光。"),
                Poem(title: "竹里館",
                    content: "獨坐幽篁里，彈琴复長嘯。深林人不知，明月來相照。",
                    description: "月夜，獨坐幽靜的竹林子里，間或彈彈琴，間或吹吹口哨。竹林里僻靜幽深，無人知曉，卻有明月陪伴，殷勤來相照")
                ])

            list.append(poet)
        }
        
        do {
            let poet = Poet(name: "劉長卿", poemList: [
                Poem(title: "送靈澈",
                    content: "蒼蒼竹林寺，杳杳鐘聲晚。荷笠帶斜陽，青山獨歸遠。",
                    description: "在蒼翠的竹林寺院中，遠遠傳來深沉的晚鐘。他身背斗笠披著晚霞，獨自歸向青山最深重。"),
                Poem(title: "彈琴",
                    content: "泠泠七弦上，靜听松風寒。古調雖自愛，今人多不彈。",
                    description: "凄清的音樂發自七弦古琴，靜靜細听是風入松的古音。我就愛這令人神往的古曲，只可惜如今世上不太流行。")
                ])

            list.append(poet)
        }
    }
}
