;; -*- lexical-binding: t -*-

;;; debug-insert.el --- Insert debug commands with keybinding

;; Copyright (C) 2019  Tejas Bubane

;; Author: Tejas Bubane <tejasbubane@gmail.com>
;; URL: https://github.com/tejasbubane/debug-insert
;; Keywords: debugging programming languages
;; Version: 0.1.1
;; Package-Requires: ((emacs "24.4"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides a minor mode for inserting debug commands into source code program files
;; Detects programming language and adds debug command accordingly
;; Also has ability to use custom command in case you are using a different debugger

;;; Code:

(make-variable-buffer-local
 (defvar debug-insert-buffer-command ""
   "Debug command to be used in the current buffer."))

(define-minor-mode debug-insert-mode
  "Minor mode to insert debug commands at point"
  :lighter " DebugIns"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c d") 'debug-insert-perform)
            map)
  :extra-args (custom-command)
  (if debug-insert-mode
      (if custom-command
          (setq debug-insert-buffer-command custom-command)
        (debug-insert-find-command))))

(defun debug-insert-find-command ()
  "Find debug command based on buffer's major mode"
  (let* ((default-commands '(("ruby-mode" . "byebug")
                             ("js-mode" . "debugger")
                             ("emacs-lisp-mode" . "check")))
         (buffer-command (cdr (assoc (symbol-name major-mode) default-commands))))
    (if buffer-command
        (setq debug-insert-buffer-command buffer-command)
      (message (format "Debug command not found for %s." (symbol-name major-mode))))))

(defun debug-insert-perform ()
  "Perform insertion the debug command"
  (interactive)
  (insert debug-insert-buffer-command))
