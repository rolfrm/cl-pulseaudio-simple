;;;; cl-pulseaudio-simple.asd

(asdf:defsystem :cl-pulseaudio-simple
  :description "Library for using the simple pulseaudio API."
  :author "Rolf Madsen <rolfrm@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
	       (:file "pa-simple-internal" :depends-on ("package"))
	       (:file "cl-pulseaudio-simple" :depends-on ("pa-simple-internal"))
	       ))
