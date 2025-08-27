(defmacro ui-box (ui params &body body)
  (declare (ignore ui params))
  body
  )


(defvar *ui* nil)

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
 
(defstruct ui
  (opt (make-opt) :type opt)
  (x 0 :type fixnum)
  (y 0 :type fixnum)
  (layout-direction-stack '())
  )

(defun 

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
                      
