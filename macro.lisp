(defstruct cmd/rect x y w h color)
(defstruct cmd/text x y text size color)


(defparameter *commands* (make-array 128 :fill-pointer 0 :adjustable t))

(defun button (x y text)
  (vector-push-extend
   (make-cmd/rect :x x :y y :w 100 :h 20 :color #x111111FF)
   *commands*)
  (vector-push-extend
   (make-cmd/rect :x (1+ x) :y (1+ y) :w 98 :h 18 :color #xDDDDDD)
   *commands*)
  (vector-push-extend
   (make-cmd/text :x (+ 2 x) :y (+ 2 y) :text text :size 16 :color #x000000FF)
   *commands*)
  )

(defun render-commands ()
  (loop
    for i from 0 below (fill-pointer *commands*)
    for cmd = (aref *commands* i)
    do (case (type-of cmd)
         (cmd/rect
          (cl-raylib:draw-rectangle (cmd/rect-x cmd)
                                    (cmd/rect-y cmd)
                                    (cmd/rect-w cmd)
                                    (cmd/rect-h cmd)
                                    (cl-raylib:get-color (cmd/rect-color cmd))))
         (cmd/text
          (cl-raylib:draw-text (cmd/text-text cmd)
                               (cmd/text-x cmd)
                               (cmd/text-y cmd)
                               (cmd/text-size cmd)
                               :black)))
         ))
  (setf (fill-pointer *commands*) 0)
  )

(ql:quickload :cl-raylib)

(defun main ()
  (let ((screen-width 800)
        (screen-height 450))
    (cl-raylib:with-window (screen-width screen-height "raylib [core] example - basic window")
      (cl-raylib:set-target-fps 60) ; Set our game to run at 60 FPS
      (loop
        until (cl-raylib:window-should-close) ; detect window close button or ESC key
        do (cl-raylib:with-drawing
             (cl-raylib:clear-background :raywhite)
  ;;           (cl-raylib:draw-fps 20 20)
;;             (cl-raylib:draw-text "Congrats! You created your first window!" 190 200 20 :lightgray)

             (button 50 50 "hello! foo bar")

             (render-commands)

        )))))

(main)
