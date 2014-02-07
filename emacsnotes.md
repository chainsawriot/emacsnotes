## Common ops
* undo: C-_
* Select all: C-x h
* Goto-line short cut: M-g g
* Kill a line: C-k
* Move to beginning: C-a
* Scroll a page: C-v / M-v

## Keyboard Macro

* start and end the definition: C-x ( and C-x )
* Execute the macro: C-x e or F4
* Give the last defined macro a name: C-x C-k n
* Execute the macro with name: M-x name
* save the macro into .emacs: Open .emacs and M-x insert-kbd-macro
* Bind the macro into a key: in .emacs (global-set-key "\C-x\C-kT" 'name-of-macro)

## python.el (Ship with emacs)
* Increase ident: C-c >
* Decrease ident: C-c <

## useful macros

```{elisp}
(fset 'pythonevalbuffersplit
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("^Xh^C^R^X1^X2^Xo^Xb*Python*^M" 0 "%d")) arg)))

(fset 'pythonevalregionsplit
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("^C^R^X1^X2^Xo^Xb*Python*^M" 0 "%d")) arg)))

(global-set-key "\C-x\C-kb" 'pythonevalbuffersplit)
(global-set-key "\C-x\C-kr" 'pythonevalregionsplit)                     
```

## C related
* Compile mode: M-x compile
