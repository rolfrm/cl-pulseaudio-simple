# cl-pulseaudio-simple
### Rolf madsen <rolfrm@gmail.com>_

Common Lisp bindings for pulseaudio-simple.

## Example

```lisp
(use-package :pulseaudio-simple)

(defvar *pa-out* (pa-new :name "play" :direction 'playback))
(defvar *pa-in* (pa-new :name "record" :direction 'record))

(defvar *buffer* (make-array 44100 :element-type 'single-float))
(pa-read *pa-in* *buffer*) ; record for 1 sec
(pa-write *pa-out* *buffer*) ; playback for 1 sec

(pa-free *pa-in*)
(pa-free *pa-out*)

```
## License

MIT License

