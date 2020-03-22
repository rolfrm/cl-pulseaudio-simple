(asdf:load-system "cl-pulseaudio-simple")
(defpackage :pulseaudio-simple-example
  (:use :cl :pulseaudio-simple)
  )
(in-package :pulseaudio-simple-example)

;; create a client for playback
(defparameter *pa-out* (pa-new :name "play" :direction 'playback))

;; create a client for recording
(defparameter *pa-in* (pa-new :name "record" :direction 'record))

;; a buffer for one sec of samples (at 44100 hz).
(defvar *buffer* (make-array 44100 :element-type 'single-float))

;; flush the record client, to clear existing daa
(pa-flush-client *pa-in*)
(pa-read *pa-in* *buffer*) ; record for 1 sec
(pa-write *pa-out* *buffer*) ; playback for 1 sec

;; free things up again.
(pa-free *pa-in*)
(pa-free *pa-out*)
