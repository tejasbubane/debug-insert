;;; debug-insert-test.el --- Tests for the "Debug Insert" package

(load-file "debug-insert.el")

(ert-deftest test-default-ruby-command ()
  (with-temp-buffer
    (ruby-mode) ;; set major mode to ruby
    (debug-insert-mode)
    (should (equal debug-insert-buffer-command "byebug"))))

(ert-deftest test-default-javascript-command ()
  (with-temp-buffer
    (js-mode) ;; set major mode to js
    (debug-insert-mode)
    (should (equal debug-insert-buffer-command "debugger"))))

(ert-deftest test-custom-debug-command ()
  (with-temp-buffer
    (js-mode) ;; set major mode to js
    (debug-insert-mode 1 "custom-debugger")
    (should (equal debug-insert-buffer-command "custom-debugger"))))

(ert-deftest test-adds-keybinding ()
  (with-temp-buffer
    (debug-insert-mode 1)
    (let ((modename (symbol-name (key-binding (kbd "C-c d")))))
      (should (equal modename "debug-insert-perform")))))

(ert-deftest test-perform-insert-custom-command ()
  (with-temp-buffer
    (debug-insert-mode 1 "custom-debugger")
    (goto-char (point-min))
    (debug-insert-perform)
    (should (equal (buffer-string) "custom-debugger"))))

(ert-deftest test-perform-insert-major-mode-command ()
  (with-temp-buffer
    (ruby-mode)
    (debug-insert-mode)
    (goto-char (point-min))
    (debug-insert-perform)
    (should (equal (buffer-string) "byebug"))))

(provide 'debug-insert-test)
