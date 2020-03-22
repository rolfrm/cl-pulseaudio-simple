(asdf:load-system "cl-pulseaudio-simple")
(defpackage :pulseaudio-simple-example
  (:use :cl :pulseaudio-simple)
  )
(in-package :pulseaudio-simple-example)

(defparameter *pa-out* (pa-new :name "play" :direction 'playback))
(defparameter *pa-in* (pa-new :name "record" :direction 'record))

(defvar *buffer* (make-array 44100 :element-type 'single-float))
(pa-flush-client *pa-in*)
(pa-read *pa-in* *buffer*) ; record for 1 sec
(pa-read *pa-in* *buffer*) ; record for 1 sec
(pa-write *pa-out* *buffer*) ; playback for 1 sec

(pa-free *pa-in*)
(pa-free *pa-out*)
