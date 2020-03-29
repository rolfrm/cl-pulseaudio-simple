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

(defun array-element-size(buffer)
  (let ((tp (array-element-type buffer)))
    (cond ((eq tp 'single-float) 4)
	  ((eq tp 'double-float) 8)
	  ((equal tp '(unsigned-byte 8)) 1)
	  ((equal tp '(unsigned-byte 16)) 2)
	  ((equal tp '(unsigned-byte 32)) 4)
	  ((equal tp '(unsigned-byte 64)) 8)
	  ((equal tp '(signed-byte 8)) 1)
	  ((equal tp '(signed-byte 16)) 2)
	  ((equal tp '(signed-byte 32)) 4)
	  ((equal tp '(signed-byte 64)) 8)
	  (t (error "Unsupported array type ~a" tp)))))

(defun pa-write(pa buffer)
  (declare (simple-array buffer))
  (with-alien ((error int))
    (pa-simple-write pa (sb-sys:vector-sap buffer) (* (array-element-size buffer) (array-total-size buffer)) (addr error))))

(defun pa-read(pa buffer)
  (declare (simple-array buffer))
  (with-alien ((error int))
    (pa-simple-read pa (sb-sys:vector-sap buffer) (* (array-element-size buffer) (array-total-size buffer)) (addr error))))

(defun pa-flush-client(pa)
  (with-alien ((error int))
    (pa-simple-flush pa (addr error))))

