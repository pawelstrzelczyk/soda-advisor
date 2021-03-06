(deftemplate UI-state
   (slot display)
   (slot state (default middle))
    (multislot answers)
)
   
(deftemplate stateCurr
   (slot state))
  
(deffacts startup
   (stateCurr (state initial))
)

(defrule system-banner ""

  =>
    (assert
        (UI-state (display WelcomeMessage)
        (state initial)
        (answers Yes No))
    )

)

(defrule ifStartYes
    ?f1 <- (stateCurr (state initial))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state mexico))
    (assert
        (UI-state (display Mexico) (state mexico) (answers Yes No))
    )
)
(defrule ifStartNo
    ?f1 <- (stateCurr (state initial))
    ?f2 <- (next No)
    =>
    (retract ?f2)
)

;;;Mexico
(defrule ifMexicoYes
    ?f1 <- (stateCurr (state mexico))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display MexicoYes) (state final))
    )
)
(defrule ifMexicoNo
    ?f1 <- (stateCurr (state mexico))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state noobs))
    (assert
        (UI-state (display Noobs) (state noobs)(answers Yes No))
    )
)
;;;Noobs
(defrule ifNoobsYes
    ?f1 <- (stateCurr (state noobs))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display NoobsYes) (state final))
    )
)
(defrule ifNoobsNo
    ?f1 <- (stateCurr (state noobs))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state diet))
    (assert
        (UI-state (display Diet) (state diet)(answers Yes No))
    )
)
;;;Diet
(defrule ifDietYes
    ?f1 <- (stateCurr (state diet))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state ostentatious))
    (assert
        (UI-state (display Ostentatious) (state ostentatious)(answers Yes No))
    )
)
(defrule ifDietNo
    ?f1 <- (stateCurr (state diet))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state animated))
    (assert
        (UI-state (display Animated) (state animated)(answers Yes No))
    )
)
;;;Ostentatious
(defrule ifOstentatiousYes
    ?f1 <- (stateCurr (state ostentatious))
        ?f2 <- (next Yes)
        =>
        (retract ?f2)
        (modify ?f1 (state final))
        (assert
            (UI-state (display OstentatiousYes) (state final))
        )
)
(defrule ifOstentatiousNo
    ?f1 <- (stateCurr (state ostentatious))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state boost))
    (assert
        (UI-state (display Boost) (state boost)(answers Yes No))
    )
)
;;;Boost
(defrule ifBoostYes
    ?f1 <- (stateCurr (state boost))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display BoostYes) (state final))
    )
)
(defrule ifBoostNo
    ?f1 <- (stateCurr (state boost))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display BoostNo) (state final))
    )
)
;;;Animated
(defrule ifAnimatedYes
    ?f1 <- (stateCurr (state animated))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display AnimatedYes) (state final))
    )
)
(defrule ifAnimatedNo
    ?f1 <- (stateCurr (state animated))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state juggalo))
    (assert
        (UI-state (display Juggalo) (state juggalo)(answers Yes No))
    )
)
;;;Juggalo
(defrule ifJuggaloYes
    ?f1 <- (stateCurr (state juggalo))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display JuggaloYes) (state final))
    )
)
(defrule ifJuggaloNo
    ?f1 <- (stateCurr (state juggalo))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state dirt))
    (assert
        (UI-state (display Dirt) (state dirt)(answers Yes No))
    )
)
;;;Dirt
(defrule ifDirtYes
    ?f1 <- (stateCurr (state dirt))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display DirtYes) (state final))
    )
)
(defrule ifDirtNo
    ?f1 <- (stateCurr (state dirt))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state zonday))
    (assert
        (UI-state (display Zonday) (state zonday)(answers Yes No))
    )
)
;;;Zonday
(defrule ifZondayYes
        ?f1 <- (stateCurr (state zonday))
        ?f2 <- (next Yes)
        =>
        (retract ?f2)
        (modify ?f1 (state final))
        (assert
            (UI-state (display ZondayYes) (state final))
        )
)
(defrule ifZondayNo
    ?f1 <- (stateCurr (state zonday))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state brazil))
    (assert
        (UI-state (display Brazil) (state brazil)(answers Yes No))
    )
)
;;;Brazil
(defrule ifBrazilYes
    ?f1 <- (stateCurr (state brazil))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display BrazilYes) (state final))
    )
)
(defrule ifBrazilNo
    ?f1 <- (stateCurr (state brazil))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state dole))
    (assert
        (UI-state (display Dole) (state dole)(answers Yes No))
    )
)
;;;Dole
(defrule ifDoleYes
    ?f1 <- (stateCurr (state dole))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display DoleYes) (state final))
    )
)
(defrule ifDoleNo
    ?f1 <- (stateCurr (state dole))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state capacitor))
    (assert
        (UI-state (display Capacitor) (state capacitor)(answers Yes No))
    )
)
;;;Capacitor
(defrule ifCapacitorYes
    ?f1 <- (stateCurr (state capacitor))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CapacitorYes) (state final))
    )
)
(defrule ifCapacitorNo
    ?f1 <- (stateCurr (state capacitor))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state gum))
    (assert
        (UI-state (display Gum) (state gum)(answers Yes No))
    )
)
;;;Gum
(defrule ifGumYes
    ?f1 <- (stateCurr (state gum))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display GumYes) (state final))
    )
)
(defrule ifGumNo
    ?f1 <- (stateCurr (state gum))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state pulling))
    (assert
        (UI-state (display Pulling) (state pulling)(answers Yes No))
    )
)
;;;Pulling
(defrule ifPullingYes
    ?f1 <- (stateCurr (state pulling))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display PullingYes) (state final))
    )
)
(defrule ifPullingNo
    ?f1 <- (stateCurr (state pulling))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state tesco))
    (assert
        (UI-state (display Tesco) (state tesco)(answers Yes No))
    )
)
;;;Tesco
(defrule ifTescoYes
    ?f1 <- (stateCurr (state tesco))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TescoYes) (state final))
    )
)
(defrule ifTescoNo
    ?f1 <- (stateCurr (state tesco))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state picnic))
    (assert
        (UI-state (display Picnic) (state picnic)(answers Yes No))
    )
)
;;;Picnic
(defrule ifPicnicYes
    ?f1 <- (stateCurr (state picnic))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display PicnicYes) (state final))
    )
)
(defrule ifPicnicNo
    ?f1 <- (stateCurr (state picnic))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state buyany))
    (assert
        (UI-state (display BuyAny) (state buyany)(answers Yes No))
    )
)
;;;BuyAny
(defrule ifBuyAnyYes
    ?f1 <- (stateCurr (state buyany))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display BuyAnyYes) (state final))
    )
)
(defrule ifBuyAnyNo
    ?f1 <- (stateCurr (state buyany))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state tyler))
    (assert
        (UI-state (display Tyler) (state tyler)(answers Yes No))
    )
)
;;;Tyler
(defrule ifTylerYes
    ?f1 <- (stateCurr (state tyler))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TylerYes) (state final))
    )
)
(defrule ifTylerNo
    ?f1 <- (stateCurr (state tyler))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state root))
    (assert
        (UI-state (display Root) (state root)(answers Yes No))
    )
)
;;;Root
(defrule ifRootYes
    ?f1 <- (stateCurr (state root))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state quality))
    (assert
        (UI-state (display Quality) (state quality)(answers Yes No))
    )
)
(defrule ifRootNo
    ?f1 <- (stateCurr (state root))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state tummy))
    (assert
        (UI-state (display Tummy) (state tummy)(answers Yes No))
    )
)
;;;Quality
(defrule ifQualityYes
    ?f1 <- (stateCurr (state quality))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display QualityYes) (state final))
    )
)
(defrule ifQualityNo
    ?f1 <- (stateCurr (state quality))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display QualityNo) (state final))
    )
)
;;;Tummy
(defrule ifTummyYes
    ?f1 <- (stateCurr (state tummy))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TummyYes) (state final))
    )
)
(defrule ifTummyNo
    ?f1 <- (stateCurr (state tummy))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state hfcs))
    (assert
        (UI-state (display HFCS) (state hfcs)(answers Yes No))
    )
)
;;;HFCS
(defrule ifHFCSYes
    ?f1 <- (stateCurr (state hfcs))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state taste))
    (assert
        (UI-state (display Taste) (state taste)(answers Yes No))
    )
)
(defrule ifHFCSNo
    ?f1 <- (stateCurr (state hfcs))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state cherry))
    (assert
        (UI-state (display Cherry) (state cherry)(answers Yes No))
    )
)
;;;Taste
(defrule ifTasteYes
    ?f1 <- (stateCurr (state taste))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TasteYes) (state final))
    )
)
(defrule ifTasteNo
    ?f1 <- (stateCurr (state taste))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TasteNo) (state final))
    )
)
;;;Cherry
(defrule ifCherryYes
    ?f1 <- (stateCurr (state cherry))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CherryYes) (state final))
    )
)
(defrule ifCherryNo
    ?f1 <- (stateCurr (state cherry))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state caffeine))
    (assert
        (UI-state (display Caffeine) (state caffeine)(answers Yes No))
    )
)
;;;Caffeine
(defrule ifCaffeineYes
    ?f1 <- (stateCurr (state caffeine))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state backpack))
    (assert
        (UI-state (display Backpack) (state backpack)(answers Yes No))
    )
)
(defrule ifCaffeineNo
    ?f1 <- (stateCurr (state caffeine))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CaffeineNo) (state final))
    )
)
;;;Backpack
(defrule ifBackpackYes
    ?f1 <- (stateCurr (state backpack))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display BackpackYes) (state final))
    )
)
(defrule ifBackpackNo
    ?f1 <- (stateCurr (state backpack))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state sing))
    (assert
        (UI-state (display Sing) (state sing)(answers Yes No))
    )
)
;;;Sing
(defrule ifSingYes
    ?f1 <- (stateCurr (state sing))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display SingYes) (state final))
    )
)
(defrule ifSingNo
    ?f1 <- (stateCurr (state sing))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state simpler))
    (assert
        (UI-state (display Simpler) (state simpler)(answers Yes No))
    )
)
;;;Simpler
(defrule ifSimplerYes
    ?f1 <- (stateCurr (state simpler))
    ?f2 <- (next Yes)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display SimplerYes) (state final))
    )
)
(defrule ifSimplerNo
    ?f1 <- (stateCurr (state simpler))
    ?f2 <- (next No)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display SimplerNo) (state final))
    )
)