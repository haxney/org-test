(require 'org)
(require 'ert)

;; org-babel-next-src-block

(defmacro org-test-def (name desc &rest body)
  "Create an ERT test embedded in an org file."
  (declare (indent 1))
  `(save-excursion
     (let (actual expected)
       (outline-next-heading)
       (org-mark-subtree)
       (forward-line) ;; Don't include the actual headline
       (setq actual (buffer-substring (point) (mark)))
       (with-temp-buffer
         (insert actual)
         (goto-char (point-min))
         (search-forward "⁁")
         (delete-char -1)
         (org-mode)
         ,@body
         (setq actual (buffer-substring (point-min) (point-max)))
         )

       (outline-next-heading)
       (org-mark-subtree)
       (forward-line)
       (setq expected (buffer-substring (point) (mark)))
       (with-temp-buffer
         (insert expected)
         (goto-char (point-min))
         (search-forward "⁁")
         (delete-char -1)
         (setq expected (buffer-substring (point-min) (point-max))))
       (string-equal expected actual))))
