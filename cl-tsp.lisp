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

(defun search-cities (city-graph path best-path)
  (if (equal (path-length path) (path-length best-path))
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
                    (search-cities city-graph new-path best-path))))
            (unvisited-cities (path-cities path) (path-cities best-path)))))

(defun travel-cities (city-graph source)
  (search-cities city-graph
                 (list :length 1 :cities (list source) :weight 0)
                 (construct-hamiltonian city-graph)))
