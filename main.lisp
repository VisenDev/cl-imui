(defstruct color
  (r 0 :type (unsigned-byte 8))
  (g 0 :type (unsigned-byte 8))
  (b 0 :type (unsigned-byte 8))
  (a 0 :type (unsigned-byte 8))
  )

(defstruct bounds
  (min-width 0 :type fixnum)
  (min-height 0 :type fixnum)
  (max-width #xFFFFFF :type fixnum)
  (max-height #xFFFFFF :type fixnum)
  )

(defstruct color-state
  (primary nil :type color)
  (hover nil :type color)
  (pressed nil :type color)
  )
(defstruct style
  (background nil :type color-state)
  (foreground nil :type color-state)
  (border nil :type color-state)
  )

(defstruct color-style
  (fill       nil :type color)
  (fill-hover nil :type color)
  (fill-press nil :type color)
  (text       nil :type color)
  (text-hover nil :type color)
  (text-press nil :type color)
  (border     nil :type color)
  )

(defstruct theme
  (focus nil :type color)
  (text-select nil :type color)
  (fill nil :type color)
  (fill-hover nil :type color)
  (fill-press nil :type color)
  (text nil :type color)
  (text-hover nil :type color)
  (text-press nil :type color)
  (border nil :type color)
  (control nil :type color-style)
  (window nil :type color-style)
  (highlight nil :type color-style)
  (danger nil :type color-style)
  )

(defstruct (container (:include bounds))
  (layout :vertical :type (member :vertical :horizontal))
  (


(defclass ui ()
  ((
