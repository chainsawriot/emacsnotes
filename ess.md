# unleash the full potential of ESS

The manual of ESS is daunting to read. That's why most of the ESS users can only use 20% of the functionalities. This cookbook style guide is written to provide an approachable documentation on how to unleash the full potential of ESS.

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
```

Use the package-list-packages (M-x package-list-packages) function to fire up the package installation screen.

### auto-complete mode

You can install whatever you want. Notes: you might need to activate the package in some cases.

Install auto-complete mode from the melpa and activate it from .emacs

```elisp
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-composition-mode 1)
```

## The real deal

### Enable ESS auto-complete mode

Add this into your .emacs

```elisp
(add-to-list 'ac-sources 'ac-source-R)
(setq ess-use-auto-complete t)
```

And try to write some R code in the ESS r console / script.

### ess-rdired

### ess-tracebug

[refence](https://code.google.com/p/ess-tracebug/wiki/GettingStarted)

