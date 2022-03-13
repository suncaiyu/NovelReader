function initFonts(model) {
    var fonts = Qt.fontFamilies()
    var escape = ["仿宋", "楷体", "隶书", "黑体"]
    for (var i in fonts) {
        var font = fonts[i]
        if (font.charCodeAt(0) <= 127) {
            continue
        } else {
            if (escape.indexOf(font) === -1) {
                model.append({"font" : font})
            }
        }
    }
}

function setFont(f, model, index) {
    var fonts = Qt.fontFamilies()
    var font = model.get(index).font
    var i = fonts.indexOf(font)
    f.family = fonts[i]
}
