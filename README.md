# Debug Insert

[![Build Status](https://travis-ci.org/tejasbubane/debug-insert.svg?branch=master)](https://travis-ci.org/tejasbubane/debug-insert)

Emacs minor mode to insert debug commands a point. Detects major mode and uses
default commands but also allows providing custom commands for different languages.

### Usage

Enable as a hook to your language:

```elisp
(add-hook 'ruby-mode-hook (debug-insert-mode 1))
```

Optionally pass in a different debugger command you would like to use:

```elisp
;; Use `binding.pry` instead of the default `byebug` for ruby code
(add-hook 'ruby-mode-hook (lambda () (debug-insert-mode 1 "binding.pry")))
```

Currently these commands are supported:

Language | Debug Command
---------|--------------
Ruby | byebug
Javascript | debugger
Emacs Lisp | (debug)
Elixir | IEx.pry

PRs for adding more languages are always welcome!
