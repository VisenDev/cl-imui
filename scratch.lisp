(defstruct cmd type value)

(defun label (text) (list (make-cmd :type 'text :value text)))

(defun button (&rest contents)
   `(,(make-cmd :type 'button-open)
     ,@contents
     ,(make-cmd :type 'button-close))
  )

(defun layout/vertical (&keys max-width &rest contents)
  `(,(make-cmd :type 'layout/vertical-open)
    ,@contents
    ,(make-cmd :type 'layout/vertical-close)
    ))

(layout/vertical
 :max-width 100 :max-height 100
 (label "hi"))

  
