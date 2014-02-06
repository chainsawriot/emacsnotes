# unleash the full potential of ESS

## Some emacs basics

### Upgrade to emacs 24

Please use emacs 24. emacs 23 is so old.

### package.el and melpa

One of the reason why you should use emacs 24 is the package.el is preinstalled. Add this into your .emacs.

```elisp
(require 'package)
(package-initialize)
(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
``
