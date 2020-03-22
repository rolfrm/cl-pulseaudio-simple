;;;; cl-pulseaudio-simple.lisp

(in-package :pulseaudio-simple)

(defun pa-new (&key (name "pulse-client") (direction 'playback) (server nil) (stream-name "pa") (device nil) (format 'float32le) (rate 44100) (channels 1))
  (with-alien ((spec sample-spec)
	       (pa (* pulse-simple))
	       (error int))
    (setf (slot spec 'format) format)
    (setf (slot spec 'rate) rate)
    (setf (slot spec 'channels) channels)
    (pa-simple-new server name direction device stream-name (addr spec) nil nil (addr error))))

(defun pa-free(pa)
  (with-alien ()
    (pa-simple-free pa)))

(defun pa-write(pa buffer)
  (with-alien ((error int))
    (pa-simple-write pa (sb-sys:vector-sap buffer) (* 5 (array-total-size buffer)) (addr error))))

(defun pa-read(pa buffer)
  (with-alien ((error int))
    (pa-simple-read pa (sb-sys:vector-sap buffer) (* 4 (array-total-size buffer)) (addr error))))
