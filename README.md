# cl-tsp
Branch-and-bound implementation of the travelling salesman problem in Common Lisp.

### Running the Code

```
> (defparameter city-graph ’(:al (:bu 289 :bi 141 :ny 151 :hu 36 :ro 227 :sy 145 :it 166)
:bu (:al 289 :bi 199 :ny 372 :hu 325 :ro 76 :sy 152 :it 155)
:bi (:al 141 :bu 199 :ny 177 :hu 149 :ro 160 :sy 73 :it 49)
:ny (:al 151 :bu 372 :bi 177 :hu 121 :ro 334 :sy 247 :it 223)
:hu (:al 36 :bu 325 :bi 149 :ny 121 :ro 260 :sy 178 :it 175)
:ro (:al 227 :bu 76 :bi 160 :ny 334 :hu 260 :sy 88 :it 91)
:sy (:al 145 :bu 152 :bi 73 :ny 247 :hu 178 :ro 88 :it 55)
:it (:al 166 :bu 155 :bi 49 :ny 223 :hu 175 :ro 91 :sy 55)))
CITY-GRAPH
> (load "cl-tsp.lisp")
> (travel-cities city-graph :sy))
(:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :RO :IT :SY) :WEIGHT 1337
:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :IT :RO :SY) :WEIGHT 1285
:LENGTH 9 :CITIES (:SY :AL :BU :RO :BI :NY :HU :IT :SY) :WEIGHT 1198
:LENGTH 9 :CITIES (:SY :AL :BU :RO :HU :NY :BI :IT :SY) :WEIGHT 1172
:LENGTH 9 :CITIES (:SY :AL :BU :RO :IT :BI :NY :HU :SY) :WEIGHT 1126
:LENGTH 9 :CITIES (:SY :AL :BI :NY :HU :IT :BU :RO :SY) :WEIGHT 1078
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BU :RO :IT :BI :SY) :WEIGHT 1031
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :BU :RO :IT :SY) :WEIGHT 987
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :IT :BU :RO :SY) :WEIGHT 934
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :BU :RO :IT :SY) :WEIGHT 900
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :IT :BU :RO :SY) :WEIGHT 847)
```

### Timing the brute force vs branch-and-bound algorithms

Over 10 runs, the average runtime of the Brute Force method was ~0.175 seconds while that of
the Branch-and-Bound method was ~0.075 seconds. This is a *57 percent* decrease in runtime!

```
> (defparameter city-graph ’(:al (:bu 289 :bi 141 :ny 151 :hu 36 :ro 227 :sy 145 :it 166)
:bu (:al 289 :bi 199 :ny 372 :hu 325 :ro 76 :sy 152 :it 155)
:bi (:al 141 :bu 199 :ny 177 :hu 149 :ro 160 :sy 73 :it 49)
:ny (:al 151 :bu 372 :bi 177 :hu 121 :ro 334 :sy 247 :it 223)
:hu (:al 36 :bu 325 :bi 149 :ny 121 :ro 260 :sy 178 :it 175)
:ro (:al 227 :bu 76 :bi 160 :ny 334 :hu 260 :sy 88 :it 91)
:sy (:al 145 :bu 152 :bi 73 :ny 247 :hu 178 :ro 88 :it 55)
:it (:al 166 :bu 155 :bi 49 :ny 223 :hu 175 :ro 91 :sy 55)))
CITY-GRAPH
> (load "cl-tsp.lisp") ;; BRUTE-FORCE IMPLEMENTATION
> (time (travel-cities city-graph :sy))
Real time: 0.170489 sec.
Run time: 0.170265 sec.
Space: 8574096 Bytes
GC: 6, GC time: 0.015981 sec.
(:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :RO :IT :SY) :WEIGHT 1337
:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :IT :RO :SY) :WEIGHT 1285
:LENGTH 9 :CITIES (:SY :AL :BU :RO :BI :NY :HU :IT :SY) :WEIGHT 1198
:LENGTH 9 :CITIES (:SY :AL :BU :RO :HU :NY :BI :IT :SY) :WEIGHT 1172
:LENGTH 9 :CITIES (:SY :AL :BU :RO :IT :BI :NY :HU :SY) :WEIGHT 1126
:LENGTH 9 :CITIES (:SY :AL :BI :NY :HU :IT :BU :RO :SY) :WEIGHT 1078
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BU :RO :IT :BI :SY) :WEIGHT 1031
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :BU :RO :IT :SY) :WEIGHT 987
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :IT :BU :RO :SY) :WEIGHT 934
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :BU :RO :IT :SY) :WEIGHT 900
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :IT :BU :RO :SY) :WEIGHT 847)
> (load "cl-tsp.lisp") ;; BRANCH-AND-BOUND IMPLEMENTATION
> (time (travel-cities city-graph :sy))
Real time: 0.075832 sec.
Run time: 0.075701 sec.
Space: 2972064 Bytes
GC: 2, GC time: 0.006567 sec.
(:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :RO :IT :SY) :WEIGHT 1337
:LENGTH 9 :CITIES (:SY :AL :BU :BI :NY :HU :IT :RO :SY) :WEIGHT 1285
:LENGTH 9 :CITIES (:SY :AL :BU :RO :BI :NY :HU :IT :SY) :WEIGHT 1198
:LENGTH 9 :CITIES (:SY :AL :BU :RO :HU :NY :BI :IT :SY) :WEIGHT 1172
:LENGTH 9 :CITIES (:SY :AL :BU :RO :IT :BI :NY :HU :SY) :WEIGHT 1126
:LENGTH 9 :CITIES (:SY :AL :BI :NY :HU :IT :BU :RO :SY) :WEIGHT 1078
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BU :RO :IT :BI :SY) :WEIGHT 1031
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :BU :RO :IT :SY) :WEIGHT 987
:LENGTH 9 :CITIES (:SY :AL :NY :HU :BI :IT :BU :RO :SY) :WEIGHT 934
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :BU :RO :IT :SY) :WEIGHT 900
:LENGTH 9 :CITIES (:SY :AL :HU :NY :BI :IT :BU :RO :SY) :WEIGHT 847)
```
