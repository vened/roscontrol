srv = angular.module("HelpersServices", [])

# транслитерация url
srv.service "TransliterateService", ->
  (w, v) ->
    tr = "a b v g d e [\"zh\",\"j\"] z i y k l m n o p r s t u f h c ch sh [\"shh\",\"shch\"] ~ y ~ e yu ya ~ [\"jo\",\"e\"]".split(" ")
    ww = ""
    if w
      w = w.toLowerCase().replace(RegExp(" ", "g"), "-")
      i = 0
      while i < w.length
        cc = w.charCodeAt(i)
        ch = ((if cc >= 1072 then tr[cc - 1072] else w[i]))
        if ch.length < 3
          ww += ch
        else
          ww += eval_(ch)[v]
        ++i
      ww.replace /~/g, ""
    return ww