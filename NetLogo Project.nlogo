extensions [ rnd ]

globals [dead-turtles-count born-turtles-count]

turtles-own [gender age-to-reproduce can-give-birth n-children max-children irreproducibility-age energy lifespan lifetime partner partner-cooldown] ;
breed [brown-eyes brown-eye]
breed [blue-eyes blue-eye]
breed [green-eyes green-eye]


to setup
  clear-all
  set dead-turtles-count 0
  set born-turtles-count 0
  setup-patches
  setup-brown-eyes
  setup-blue-eyes
  setup-green-eyes
  setup-irreproducibility
  setup-population
  reset-ticks
end


to go
  move-turtles
  reduce-cooldown
  ask turtles [reset-partner]
  end-life
  ask turtles [find-potential-partner]
  ask turtles [reproduce]
  tick
end


to setup-patches
  ask patches [
    set pcolor green
  ]
end

;; Create the brown eyed part of the population
to setup-brown-eyes
  create-brown-eyes brown_eyes_percent
  ask brown-eyes [
    setxy
    random-xcor
    random-ycor
    set shape "brown_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3 3] ; In order to approach a 2.33 expectation in the population
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
end

;; Create the blue eyed part of the population
to setup-blue-eyes
  create-blue-eyes blue_eyes_percent
  ask blue-eyes [
    setxy
    random-xcor
    random-ycor
    set shape "blue_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3]
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
end

;; Create the green eyed part of the poulation
to setup-green-eyes
  create-green-eyes green_eyes_percent
  ask green-eyes [
    setxy
    random-xcor
    random-ycor
    set shape "green_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3]
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
end


to setup-irreproducibility ; Set a maximum age of reproducibility for females turtles
  ask turtles [
    if gender = "Female" [
      set irreproducibility-age one-of [45 46 47 48 49 50 51 52 53 54 55]
    ]
  ]
end


to setup-population ; check if the initial percentages sums to 100
  if brown_eyes_percent + green_eyes_percent + blue_eyes_percent != 100 [
    set brown_eyes_percent 100 - (green_eyes_percent + blue_eyes_percent) ; set brown_eyes_percent to complete the other percentages to sum to 100
  ]
end


to-report random-cooldown ; Report a cooldown randomly between one and 11
  report 1 + random 10
end


to move-turtles ; Make turtles move randomly
  ask turtles [
    right random 180
    left random 180
    forward 1
    set lifetime lifetime + 1 ;;Set a lifespan to control generations
  ]
end


to reset-partner ; Reset both partner of turtles and of turtle's partner
  if partner != 0 [
    ask partner [set partner 0]
    set partner 0
  ]
end


to end-life ; If turtle lived longer than its max lifespan then it dies
  ask turtles [
    if lifetime >= lifespan [ ; if the turtles lived longer than the maximal lifespan, then it dies
      if partner != 0 [
        reset-partner
      ]
      set dead-turtles-count dead-turtles-count + 1
      die
    ]
  ]
end


to reduce-cooldown ; reduce the cooldown necessary to have another child
  ask turtles [
    if partner-cooldown != 0 [
      set partner-cooldown partner-cooldown - 1
    ]
  ]
end


to find-potential-partner ; Check on the 4 patches attached to the turtles patch to search for a partner
  let potential-partner turtles-on neighbors4 ; look on the 4 adjacent paths of the turtle if there is another agent
  if count potential-partner > 0 [
    if count potential-partner >= 1 [ ; if there is at least one turtle on adjacents paths
      let actual-partner one-of potential-partner ; choose a partner between the 1 or 4 possible ones
      if [gender] of actual-partner != [gender] of self [ ; assert that they do not have the same gender
        set partner actual-partner
        ask actual-partner [set partner myself]
      ]
    ]
  ]
end


to breed-brown-eyes ; Create a new brown eyes turtle
  hatch-brown-eyes litter-size [
    set shape "brown_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3 3] ; In order to approach a 2.33 expectation in the population
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
  set born-turtles-count born-turtles-count + litter-size
end


to breed-green-eyes ; Create a new green eyes turtle
  hatch-green-eyes litter-size [
    set shape "green_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3]
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
  set born-turtles-count born-turtles-count + litter-size
end


to breed-blue-eyes ; Create a new blue eyes turtle
  hatch-blue-eyes litter-size [
    set shape "blue_eyes"
    set gender one-of ["Male" "Female"]
    set age-to-reproduce one-of [18 19 20 21 22 23 24 25 26 27]
    set n-children 0
    set max-children one-of [1 2 2 3 3]
    set lifetime 0
    set lifespan one-of [70 71 72 73 74 75 76 77 78 78 80 81 82 83 84 85 86 87 88 89 90]
    set partner-cooldown 0
  ]
  set born-turtles-count born-turtles-count + litter-size
end


to reproduce
  if partner != 0 [
    if (([lifetime] of partner >= [age-to-reproduce] of partner) and ([lifetime] of self >= [age-to-reproduce] of self)) [ ; If both have the minimum age to reproduce

      if not (([n-children] of partner >= [max-children] of partner) and ([n-children] of self >= [max-children] of self)) [ ; If neither have reached the max children

        if not (([partner-cooldown] of partner > 0) or ([partner-cooldown] of self > 0)) [
          let test random-float 1

          ;; BOTH BROWN EYES PARENTS
          if [breed] of partner = brown-eyes and [breed] of self = brown-eyes [ ; both parents brown-eyes
            let genetic random-float 1

            if genetic <= 0.75 [ ; Brown eyes children
              breed-brown-eyes
            ]

            if genetic > 0.75 and genetic <= 0.9375 [ ; Green eyes children
              breed-green-eyes
            ]

            if genetic > 0.9375 [ ; Blue eyes children
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ;; BROWN AND GREEN EYES PARENTS
          if [breed] of partner = brown-eyes and [breed] of self = green-eyes [
            let genetic random-float 1

            if genetic <= 0.5 [ ; Brown eyes children
              breed-brown-eyes
            ]

            if genetic > 0.5 and genetic <= 0.875 [ ; Green eyes children
              breed-green-eyes
            ]

            if genetic > 0.875 [ ; Blue eyes children
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ;; BROWN AND BLUE EYES PARENTS
          if [breed] of partner = brown-eyes and [breed] of self = blue-eyes [
            let genetic random-float 1

            if genetic <= 0.5 [ ; Brown eyes children
              breed-brown-eyes
            ]

            if genetic > 0.5 [ ; Blue eyes children
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ;; BOTH GREEN EYES PARENTS
          if [breed] of partner = green-eyes and [breed] of self = green-eyes [
            let genetic random-float 1

            if genetic <= 0.75 [ ; Green eye child
              breed-green-eyes
            ]

            if genetic > 0.75 [ ; Blue eye child
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ;; GREEN AND BLUE EYES PARENTS
          if [breed] of partner = blue-eyes and [breed] of self = green-eyes [
            let genetic random-float 1

            if genetic <= 0.5 [ ; Green eye child
              breed-green-eyes
            ]

            if genetic > 0.5 [ ; Blue eye child
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ;; BOTH BLUE EYES PARENTS
          if [breed] of partner = blue-eyes and [breed] of self = blue-eyes [
            let genetic random-float 1

            if genetic <= 0.01 [ ; Green eye child 1%
              breed-green-eyes
            ]

            if genetic > 0.01 [ ; Blue eye child 99%
              breed-blue-eyes
            ]

            set n-children n-children + 1 ; increment the number of children
            ask partner [set n-children n-children + 1] ; increment the number of children of the partner
          ]

          ask partner [ ; After a reproduction the two partner separates
            set partner 0
            set partner-cooldown random-cooldown
          ]
          set partner 0
          set partner-cooldown random-cooldown
        ]
      ]
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
39
66
102
99
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
107
66
170
99
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

MONITOR
40
113
170
158
NIL
count turtles
17
1
11

SLIDER
17
171
189
204
litter-size
litter-size
1
5
2.0
1
1
NIL
HORIZONTAL

SLIDER
17
204
189
237
brown_eyes_percent
brown_eyes_percent
1
100
75.0
1
1
NIL
HORIZONTAL

SLIDER
17
237
189
270
blue_eyes_percent
blue_eyes_percent
1
100
8.0
1
1
NIL
HORIZONTAL

SLIDER
17
270
189
303
green_eyes_percent
green_eyes_percent
1
100
17.0
1
1
NIL
HORIZONTAL

PLOT
668
13
1020
230
Colors in the population (%)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Brown eyes" 1.0 0 -8431303 true "" "plot count brown-eyes / (count turtles) * 100"
"Blue eyes" 1.0 0 -13791810 true "" "plot count blue-eyes / (count turtles) * 100"
"Green eyes" 1.0 0 -15040220 true "" "plot count green-eyes / (count turtles) * 100"

PLOT
667
231
1023
464
Part of females in population
NIL
NIL
0.0
10.0
0.0
100.0
true
true
"" ""
PENS
"Part of female" 1.0 0 -16777216 true "" "plot count turtles with [gender = \"Female\"] / count turtles * 100"
"50%" 1.0 0 -2674135 true "" "plot 50"

PLOT
1020
12
1316
229
Dead turtles count
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Dead turtles" 1.0 0 -16777216 true "" "plot dead-turtles-count"
"Borned turtles" 1.0 0 -14070903 true "" "plot born-turtles-count"

@#$#@#$#@
## WHAT IS IT?
## HOW IT WORKS

The NetLogo model simulates the distribution of eye colors within a population. It allows users to explore how genetic inheritance and population dynamics influence the proportions of different eye colors (e.g., brown, blue, green). The model includes parameters such as initial population size and the genetic rules governing eye color inheritance. By adjusting these parameters, users can observe how the eye color distribution changes over generations, providing insights into genetic diversity and evolutionary processes. This model is a useful tool for studying the impact of genetic factors and population changes on trait prevalence.

## HOW TO USE IT

Set Parameters: Adjust the sliders for initial population size, and genetic inheritance rules.
Initialize Population: Click the "Setup" button to create the initial population with random eye colors based on your settings.
Run the Simulation: Press "Go" to start the simulation and observe the changes in eye color proportions over time.
Monitor Results: Watch the plot and monitor windows to see real-time data on the distribution of eye colors across generations.
Experiment: Modify the parameters and rerun the simulation to explore different genetic and population dynamics.

## THINGS TO NOTICE

The proportion of eye color in the population.

## THINGS TO TRY

Modify initial proportion to see how it evolves.

## EXTENDING THE MODEL

Change the initial proportions to see how it evolves in the population.

## NETLOGO FEATURES


## RELATED MODELS

HIV / Virus

## CREDITS AND REFERENCES

Eye_transmission_percentages.jpg for the reference of inheritance.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

blue_eyes
false
0
Circle -1 true false 22 20 248
Circle -13791810 true false 83 81 122
Circle -16777216 true false 122 120 44

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

brown_eyes
false
0
Circle -1 true false 22 20 248
Circle -6459832 true false 83 81 122
Circle -16777216 true false 122 120 44

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

green_eyes
false
0
Circle -1 true false 22 20 248
Circle -13840069 true false 83 81 122
Circle -16777216 true false 122 120 44

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
