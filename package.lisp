;;;; package.lisp

(defpackage :pulseaudio-simple-internal
  (:use :cl :sb-alien)
  (:export :pulse-simple :sample-format :sample-spec :format
	   :u8 :alaw :ulaw :s16le :s16be :float32le :float32be
	   :s32le :s32be :s24-32le
	   :no-direction :playback :record :upload
	   :rate :channels
	   :pulse-channel-map :pulse-buffer-attr
	   :pa-simple-new :pa-simple-free :pa-simple-write
	   :get-latency :pa-simple-flush :pa-simple-test)
  )

(defpackage :pulseaudio-simple
  (:use :cl :pulseaudio-simple-internal :sb-alien)
  (:export :pa-new :pa-free :pa-write :pa-read :playback :u8 :float32le :float32be)
  (:shadow :playback :record :u8 :float32le :float32be)
  )

