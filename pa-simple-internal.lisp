(in-package :pulseaudio-simple-internal)

(load-shared-object "libpulse-simple.so")

(define-alien-type pulse-simple
    (struct _pulse-simple))

(define-alien-type sample-format
    (enum nil u8 alaw ulaw s16le s16be float32le float32be s32le s32be S24-32le))

(define-alien-type stream-direction
    (enum nil no-direction playback record upload))

(define-alien-type sample-spec
    (struct _sample-spec
	    (format sample-format)
	    (rate int)
	    (channels unsigned-char)
	    ))
(define-alien-type pulse-channel-map
    (struct nil))

(define-alien-type pulse-buffer-attr
    (struct nil))

(define-alien-routine "pa_simple_new" (* pulse-simple) (server c-string) (name c-string) (stream-direction stream-direction)
		      (dev c-string) (stream-name c-string) (ss (* sample-spec)) (map (* pulse-channel-map))
		      (attr (* pulse-buffer-attr)) (error (* int)))

(define-alien-routine "pa_simple_free" void (pa (* pulse-simple)))
(define-alien-routine "pa_simple_write" int (pa (* pulse-simple)) (data (* unsigned-char)) (bytes size-t) (error (* int)))
(define-alien-routine "pa_simple_read" int (pa (* pulse-simple)) (data (* unsigned-char)) (bytes size-t) (error (* int)))

(define-alien-routine "pa_simple_get_latency" long-long (pa (* pulse-simple)) (error (* int)))

(define-alien-routine "pa_simple_flush" int (pa (* pulse-simple)) (error (* int)))

(defun pa-simple-test()

  (with-alien ((spec sample-spec)
	       (pa (* pulse-simple))
	       (samples (array float 1024)))

    (setf (sb-alien:slot spec 'format) 'float32le)
    (setf (slot spec 'rate) 44100)
    (setf (slot spec 'channels) 1)
    (setf pa (pa-simple-new nil "pa" 'playback nil "Music" (addr spec) nil nil nil))
    (dotimes (i 50)
      (dotimes (j 1024)
	(setf (deref samples j) (* 1.0 (sin (* (+ (* i 1024) j) (* (expt i 0.5) 0.1))))))
      (print (list i '/ 50))
      (pa-simple-write pa (cast (addr (deref samples 0)) (* unsigned-char)) (* 1024 4) nil))
  
    (unless (sb-alien:null-alien pa)
      (pa-simple-free pa)
      )
    ))


