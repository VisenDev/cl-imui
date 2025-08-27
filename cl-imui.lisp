;(defmacro ui-box (ui params &body body)
;  (declare (ignore ui params))
;  body
                                        ;  )

(defconstant +vec-default-capacity+ 32)
(defun make-vec (type)
  (make-array +vec-default-capacity+
              :element-type type :adjustable t :fill-pointer 0)
  )


(deftype u8 () '(integer 0 255))
(defstruct (color (:conc-name "col-")
                  (:constructor make-color (&optional r g b a))
                  )
  (r 0 :type u8)
  (g 0 :type u8)
  (b 0 :type u8)
  (a 255 :type u8)
  )
(defstruct (theme (:conc-name "thm-"))
  (bg (make-color 20 20 20) :type color)
  (fg (make-color 200 200 200) :type color)
  (text (make-color 220 220 220) :type color)
  (accent (make-color 20 100 100) :type color)
  )

(defstruct (font (:conc-name "fnt-"))
  (name "" :type string)
  (measure-text-width nil) 
  (measure-text-height nil)
  )

(defstruct opt 
   (min-width 0 :type fixnum)
   (max-width 10000 :type fixnum)
   (min-height 0 :type fixnum)
   (max-height 10000 :type fixnum)
   (theme (make-theme) :type theme)
   (margin 5 :type fixnum)
   (font-id (make-font) :type font)
   )

(defclass cmd ()
  ((x :initarg :x :initform 0 :type fixnum :accessor x)
   (y :initarg :y :initform 0 :type fixnum :accessor y)
   (color :initarg :color :type color :accessor color)
   )
  )
(defclass cmd/text (cmd)
  ((text :initarg :text :type string :accessor text)
   )
  )
(defclass cmd/rect (cmd)
  ((width :initarg :width :type fixnum :accessor width)
   (height :initarg :height :type fixnum :accessor height)
   )
  )

(defclass widget () ())

(defclass widget/container (widget)
  ((parent :initarg :parent :accessor parent :initform nil)
   (root-x :initarg :root-x :initform 0 :accessor root-x :type fixnum)
   (root-y :initarg :root-y :initform 0 :accessor root-y :type fixnum)
   (min-width :initarg :min-width :initform 0 :accessor min-width :type fixnum)
   (max-width :initarg :max-width :initform #xFFFFFF :accessor max-width :type fixnum)
   (min-height :initarg :min-height :initform 0 :accessor min-height :type fixnum)
   (max-height :initarg :max-height :initform #xFFFFFF :accessor max-height :type fixnum)
   (used-width  :initform 0 :accessor used-width :type fixnum)
   (used-height :initform 0 :accessor used-height :type fixnum)
   (x :initarg :x :initform 0 :accessor x :type fixnum)
   (y :initarg :y :initform 0 :accessor y :type fixnum)
   (cmds :initform (make-vec 'cmd) :accessor cmds :type (vector cmd))
   )
  )
(defclass widget/container/row (widget/container)
  ()
  )

(define-condition container-bounds-exceeded (error) ())

(defgeneric occupy (container width height))
(defmethod occupy ((container widget/container/row) (width integer) (height integer))
  (with-accessors ((mh max-height) (mw max-width) (uh used-height)
                   (uw used-width) (x x) (y y))
      container
    (when (> height mh)
      (signal 'container-bounds-exceeded)
      )
    (when (> height uh)
      (setf uh height)
      )
    (when (> (+ uw width) mw)
      (signal 'container-bounds-exceeded)
      )
    (incf uw width)
    (incf x width)
    )
  )


(defconstant +text-height+ 10)
(defgeneric label (container text))
(defmethod label ((container widget/container) (text string))
  (let*
      ((h +text-height+)
       (w (* (length text) +text-height+))
       (x (x container))
       (y (y container))
       )
    (occupy container w h)
    (vector-push-extend
     (make-instance 'cmd/text :text text :x x :y y)
     (cmds container))
    )
  )

(declaim (ftype (function (widget/container) widget/container/row) construct-row)) 
(defun construct-row (parent)
  (make-instance 'widget/container/row :root-x (x parent) :root-y (y parent))
  )
(declaim (ftype (function (widget/container/row) (vector cmd))))
(defun deconstruct-row (row)
  (
   

(defmacro with-row (parent name &body body)
  `(progn
     (make-instance 'widget/container/row :



(defclass widget/separator (widget)
  ((size :initarg :size :initform 5 :accessor size :type fixnum)
   )
  )
(defclass widget/separator/line (widget/separator)
  ((weight :initarg :weight :initform 1 :accessor weight :type fixnum
           :documentation "Weight of the drawn line")
   )
  )
(defclass widget/separator/spacer (widget/separator) ())


;;; TODO define a container-push function

 
(defstruct ui
  (x 0 :type fixnum)
  (y 0 :type fixnum)
  (cmds (make-vec 'cmd))
  (containers (make-vec 'container))
  )

;(defun ui-current-zindex (ui)
;  "returns the zindex of the top container"
;  (fill-pointer (ui-containers ui))
;  )
(defun ui-current-container (ui)
  (aref (ui-containers ui) (1- (fill-pointer (ui-containers ui))))
  )
(defun ui-current-direction (ui)
  "returns the direction that the ui is currently being laid out in"
  (cont-direction (ui-current-container ui))
  )

(declaim (ftype (function (ui raw-cmd fixnum) t) ui-push-cmd))
(defun ui-push-cmd (ui cmd zindex)
  (vector-push-extend (make-cmd :zindex zindex :raw-cmd cmd) (ui-cmds ui))
  )

(defun ui-occupy (ui width height)
  "tells the ui that a given amount of space has been used the current container"
  (case (ui-current-direction ui)
    (:horizontal (incf (ui-x ui) width))
    (:vertical (incf (ui-y ui) height))
    )
  (
  )

(defun label (ui text font-name font-size)
  (ui-push-cmd ui (make-cmd-text :x (ui-x ui) :y (ui-y ui) :value text :font-name font-name :font-size font-size)
               (fill-pointer (ui-containers ui))
               )
  ;; TODO figure out how to measure text
  (ui-occupy ui 100 10)
  )
(defun row-begin (ui)
  (vector-push-extend (make-container :direction :horizontal) (ui-containers ui))
  )
(defun row-end (ui)
  (let*
      ((top (vector-pop (ui-containers ui)))
       (row-x (cont-origin-x top))
       (row-y (cont-origin-y top))
       (row-w (ui-x ui))
       (row-h 50) ;;;TODO calculate this in a better way
       (row-color (make-color)) ; TODO make this actually check the style
       ;;;TODO handle margins here
       )
    (setf (ui-x ui) row-x)
    (incf (ui-y ui) row-h)
    (ui-push-cmd
     ui
     (make-cmd-rect :x row-x :y row-y :w row-w :h row-h :color row-color)
     (fill-pointer (ui-containers ui))
     )
    )
  )
  
    
    

(defmacro rows (ui opt &body body)
   `(

(defun example ()
  (let* ((*ui* (make-ui)
         (toggle t)
         )
    (rows (make-opt :min-width 100 :min-height 100 :layout 'vertical)
      (ui-label (:text "hello!"))
      (when (ui-button (:text "toggle"))
        (setf toggle (not toggle))
        )
      (
                      
