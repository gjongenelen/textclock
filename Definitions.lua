local Definitions = {
    safeToUnload = false,

    Words = {
        het = { 1, 2, 3 },
        is = { 5, 6 },
        nu = { 8, 9 },
        vijf_m = { 18, 19, 20, 21 },
        tien_m = { 14, 15, 16, 17 },
        minuten = { 25, 26, 27, 28, 29, 30, 31 },
        kwart = { 40, 41, 42, 43, 44 },
        voor = { 35, 36, 37, 38 },
        over = { 46, 47, 48, 49 },
        half = { 52, 53, 54, 55 },
        uur = { 100, 101, 102 },
        een = { 108, 109, 110 },
        twee = { 60, 61, 62, 63 },
        drie = { 68, 69, 70, 71 },
        vier = { 89, 90, 91, 92 },
        vijf = { 104, 105, 106, 107 },
        zes = { 56, 57, 58 },
        zeven = { 84, 85, 86, 87, 88 },
        acht = { 63, 64, 65, 66 },
        negen = { 80, 81, 82, 83, 84 },
        tien = { 74, 75, 76, 77 },
        elf = { 71, 72, 73 },
        twaalf = { 94, 95, 96, 97, 98, 99 },
        min1 = { 113 },
        min2 = { 112 },
        plus1 = { 114 },
        plus2 = { 115 },
        wifi = { 116 },
        email = { 111 }
    },
    Minutes = {
        m0 = { "uur" },
        m1 = { "uur", "plus1" },
        m2 = { "uur", "plus1", "plus2" },
        m3 = { "vijf_m", "minuten", "over", "min1", "min2" },
        m4 = { "vijf_m", "minuten", "over", "min1" },
        m5 = { "vijf_m", "minuten", "over" },
        m6 = { "vijf_m", "minuten", "over", "plus1" },
        m7 = { "vijf_m", "minuten", "over", "plus1", "plus2" },
        m8 = { "tien_m", "minuten", "over", "min1", "min2" },
        m9 = { "tien_m", "minuten", "over", "min1" },
        m10 = { "tien_m", "minuten", "over" },
        m11 = { "tien_m", "minuten", "over", "plus1" },
        m12 = { "tien_m", "minuten", "over", "plus1", "plus2" },
        m13 = { "kwart", "over", "min1", "min2" },
        m14 = { "kwart", "over", "min1" },
        m15 = { "kwart", "over" },
        m16 = { "kwart", "over", "plus1" },
        m17 = { "kwart", "over", "plus1", "plus2" },
        m18 = { "tien_m", "minuten", "voor", "half", "min1", "min2" },
        m19 = { "tien_m", "minuten", "voor", "half", "min1" },
        m20 = { "tien_m", "minuten", "voor", "half" },
        m21 = { "tien_m", "minuten", "voor", "half", "plus1" },
        m22 = { "tien_m", "minuten", "voor", "half", "plus1", "plus2" },
        m23 = { "vijf_m", "minuten", "voor", "half", "min1", "min2" },
        m24 = { "vijf_m", "minuten", "voor", "half", "min1" },
        m25 = { "vijf_m", "minuten", "voor", "half" },
        m26 = { "vijf_m", "minuten", "voor", "half", "plus1" },
        m27 = { "vijf_m", "minuten", "voor", "half", "plus1", "plus2" },
        m28 = { "half", "min1", "min2" },
        m29 = { "half", "min1" },
        m30 = { "half" },
        m31 = { "half", "plus1" },
        m32 = { "half", "plus1", "plus2" },
        m33 = { "vijf_m", "minuten", "over", "half", "min1", "min2" },
        m34 = { "vijf_m", "minuten", "over", "half", "min1" },
        m35 = { "vijf_m", "minuten", "over", "half" },
        m36 = { "vijf_m", "minuten", "over", "half", "plus1" },
        m37 = { "vijf_m", "minuten", "over", "half", "plus1", "plus2" },
        m38 = { "tien_m", "minuten", "over", "half", "min1", "min2" },
        m39 = { "tien_m", "minuten", "over", "half", "min1" },
        m40 = { "tien_m", "minuten", "over", "half" },
        m41 = { "tien_m", "minuten", "over", "half", "plus1" },
        m42 = { "tien_m", "minuten", "over", "half", "plus1", "plus2" },
        m43 = { "kwart", "voor", "min1", "min2" },
        m44 = { "kwart", "voor", "min1" },
        m45 = { "kwart", "voor" },
        m46 = { "kwart", "voor", "plus1" },
        m47 = { "kwart", "voor", "plus1", "plus2" },
        m48 = { "tien_m", "minuten", "voor", "min1", "min2" },
        m49 = { "tien_m", "minuten", "voor", "min1" },
        m50 = { "tien_m", "minuten", "voor" },
        m51 = { "tien_m", "minuten", "voor", "plus1" },
        m52 = { "tien_m", "minuten", "voor", "plus1", "plus2" },
        m53 = { "vijf_m", "minuten", "voor", "min1", "min2" },
        m54 = { "vijf_m", "minuten", "voor", "min1" },
        m55 = { "vijf_m", "minuten", "voor" },
        m56 = { "vijf_m", "minuten", "voor", "plus1" },
        m57 = { "vijf_m", "minuten", "voor", "plus1", "plus2" },
        m58 = { "uur", "min1", "min2" },
        m59 = { "uur", "min1" },
    },
    Hours = {
        h0 = "twaalf",
        h1 = "een",
        h2 = "twee",
        h3 = "drie",
        h4 = "vier",
        h5 = "vijf",
        h6 = "zes",
        h7 = "zeven",
        h8 = "acht",
        h9 = "negen",
        h10 = "tien",
        h11 = "elf",
    }
}
return Definitions