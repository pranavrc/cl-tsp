;; A naive branch-and-bound algorithm for the Travelling Salesman problem.
;;
;; > (load "cl-tsp.lisp")
;; > (defparameter city-graph '(:A (:B 7 :C 6 :D 10 :E 13) :B (:A 7 :C 7 :D 10 :E 10) :C (:A 6 :B 7 :D 5 :E 9) :D (:A 10 :B 10 :C 5 :E 6) :E (:A 13 :B 10 :C 9 :D 6)))
;; > (travel-cities city-graph :A)
;; (:LENGTH 6 :CITIES (:A :B :E :D :C :A) :WEIGHT 34 :LENGTH 6 :CITIES (:A :C :D :E :B :A) :WEIGHT 34)

(defun path-length (path)
  (getf path :length))

(defun path-cities (path)
  (getf path :cities))

(defun path-weight (path)
  (getf path :weight))

(defun compute-edge-weight (city-graph start end)
  (getf (getf city-graph start) end))

(defun compute-path-weight (city-graph path)
  (reduce #'+ (loop for (a b) on path while b
                    collect (compute-edge-weight city-graph a b))))

(defun construct-hamiltonian (city-graph)
  (let* ((cities-in-path (loop for (key value) on city-graph by #'cddr collect key))
         (length-of-path (length cities-in-path))
         (weight-of-path (+ (compute-path-weight city-graph cities-in-path)
                            (compute-edge-weight city-graph (car (last cities-in-path))
                                                 (first cities-in-path)))))
    (list :length length-of-path :cities cities-in-path :weight weight-of-path)))

(defun unvisited-cities (visited-cities all-cities)
  (set-difference all-cities visited-cities :test 'equal))

(defun update-path (city-graph path path-city new-city)
  (let* ((new-length (+ 1 (path-length path)))
         (new-cities (append (path-cities path) (list new-city)))
         (new-weight (+ (path-weight path)
                        (compute-edge-weight city-graph path-city new-city))))
    (list :length new-length :cities new-cities :weight new-weight)))

(defun search-cities (city-graph path)
  (if (equal (path-length path) (path-length min-path))
    (let ((new-path (update-path city-graph path
                                 (car (last (path-cities path)))
                                 (first (path-cities path)))))
      (if (< (path-weight new-path) (path-weight best-path))
        (setf best-path new-path)))
    (mapcan #'(lambda (city)
                (let ((new-path (update-path city-graph path
                                             (car (last (path-cities path)))
                                             city)))
                  (if (< (path-weight new-path) (path-weight best-path))
                    (search-cities city-graph new-path))))
            (unvisited-cities (path-cities path) (path-cities min-path)))))

(defparameter best-path '())
(defparameter min-path '())

(defun travel-cities (city-graph source)
  (progn
    (setf best-path (construct-hamiltonian city-graph)
          min-path best-path)
    (search-cities city-graph
                   (list :length 1 :cities (list source) :weight 0))))

