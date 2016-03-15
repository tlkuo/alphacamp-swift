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

    enum Categories: String {
        case Tang = "唐詩"
        case Song = "宋詞"
    }

    var category: String
    var list: [Poet] = []

    init(_ category: Categories) {
        self.category = category.rawValue

        switch category {
        case .Tang:
            initTang()
        case .Song:
            initSong()
        }
    }

    func initTang() {

        do {
            let poet = Poet(name: "孟浩然", poemList: [
                Poem(title: "春曉",
                    content: "春眠不覺曉，處處聞啼鳥。\n夜來風雨聲，花落知多少。\n",
                    description: "春意綿綿好睡覺，不知不覺天亮了；猛然一覺惊醒來，到處是鳥儿啼叫。夜里迷迷胡胡，似乎有沙沙風雨聲；呵風雨風雨，花儿不知吹落了多少？"),
                Poem(title: "宿建德江",
                    content: "移舟泊煙渚，日暮客愁新。\n野曠天低樹，江清月近人。\n",
                    description: "我把船停泊在暮煙籠罩的小洲，茫茫暮色給游子新添几分鄉愁。曠野無垠遠處天空比樹木還低，江水清澈更覺月与人意合情投。")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "李白", poemList: [
                Poem(title: "夜思",
                    content: "床前明月光，疑是地上霜。\n舉頭望明月，低頭思故鄉。\n",
                    description: "皎洁的月光洒到床前，迷离中疑是秋霜一片。仰頭觀看明月呵明月，低頭鄉思連翩呵連翩。"),
                Poem(title: "怨情",
                    content: "美人卷珠帘，深坐蹙蛾眉。\n但見淚痕濕，不知心恨誰。\n",
                    description: "美人儿卷起珠帘等待等待，一直坐著把雙眉緊緊鎖閉。只看見她淚痕濕滿了兩腮，不知道她是恨人還是恨己。")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "王維", poemList: [
                Poem(title: "鹿柴",
                    content: "空山不見人，但聞人語響。\n返影入深林，复照青苔上。\n",
                    description: "山中空空蕩蕩不見人影，只听得喧嘩的人語聲響。夕陽的金光射入深林中，青苔上映著昏黃的微光。"),
                Poem(title: "竹里館",
                    content: "獨坐幽篁里，彈琴复長嘯。\n深林人不知，明月來相照。\n",
                    description: "月夜，獨坐幽靜的竹林子里，間或彈彈琴，間或吹吹口哨。竹林里僻靜幽深，無人知曉，卻有明月陪伴，殷勤來相照")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "劉長卿", poemList: [
                Poem(title: "送靈澈",
                    content: "蒼蒼竹林寺，杳杳鐘聲晚。\n荷笠帶斜陽，青山獨歸遠。\n",
                    description: "在蒼翠的竹林寺院中，遠遠傳來深沉的晚鐘。他身背斗笠披著晚霞，獨自歸向青山最深重。"),
                Poem(title: "彈琴",
                    content: "泠泠七弦上，靜听松風寒。\n古調雖自愛，今人多不彈。\n",
                    description: "凄清的音樂發自七弦古琴，靜靜細听是風入松的古音。我就愛這令人神往的古曲，只可惜如今世上不太流行。")
                ])

            list.append(poet)
        }
    }

    func initSong() {

        do {
            let poet = Poet(name: "范仲淹", poemList: [
                Poem(title: "蘇幕遮",
                    content: "碧雲天，黃葉地。秋色連波，波上寒煙翠。山映斜陽天接水。芳草無情，更在斜陽外。黯鄉魂，追旅思。夜夜除非，好夢留人睡。明月樓高休獨倚。酒入愁腸，化作相思淚。",
                    description: ""),
                Poem(title: "御街行",
                    content: "紛紛墜葉飄香砌。夜寂靜，寒聲碎。真珠簾卷玉樓空，天淡銀河垂地。年年今夜，月華如練，長是人千里！愁腸已斷無由醉。酒未到，先成淚。殘燈明滅枕頭攲，諳盡孤眠滋味。都來此事，眉間心上，無計相迴避。",
                    description: "")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "張先", poemList: [
                Poem(title: "浣溪沙",
                    content: "樓倚春江百尺高，煙中還未見歸橈，幾時期信似江潮？花片片飛風弄蝶，柳陰陰下水平橋，日長才過又今宵。",
                    description: ""),
                Poem(title: "醉垂鞭",
                    content: "雙蝶繡羅裙。東池宴，初相見。朱粉不深勻，間花淡淡春。細看諸處好，人人道﹕柳腰身。昨日亂山昏，來時衣上雲。",
                    description: "")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "晏殊", poemList: [
                Poem(title: "浣溪沙",
                    content: "一曲新詞酒一杯，去年天氣舊亭台，夕陽西下幾時回？無可奈何花落去，似曾相識燕歸來，小園香徑獨徘徊。",
                    description: ""),
                Poem(title: "清商怨",
                    content: "關河愁思望處滿，漸素秋向晚。雁過南雲，行人回淚眼。雙鸞衾裯悔展，夜又永、枕孤人遠。夢未成歸，梅花聞塞管。",
                    description: "")
                ])

            list.append(poet)
        }

        do {
            let poet = Poet(name: "歐陽修", poemList: [
                Poem(title: "玉樓春",
                    content: "洛陽正值芳菲節，穠艷清香相間發。游絲有意苦相縈，垂柳無端爭贈別。杏花紅處青山缺，山畔行人山下歇。今宵誰肯遠相隨？惟有寂寥孤館月。",
                    description: ""),
                Poem(title: "望江南",
                    content: "江南蝶，斜日一雙雙。身似何郎全傅粉，心如韓壽愛偷香，天賦與輕狂。微雨後，薄翅膩煙光。才伴遊蜂來小院，又隨飛絮過東牆，長是為花忙。",
                    description: "")
                ])

            list.append(poet)
        }
    }
}
