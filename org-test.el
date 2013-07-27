(with-current-buffer "test.org"
  (save-excursion
    (let (actual)
      (outline-next-visible-heading)
      (org-mark-subtree)
      (setq actual (buffer-substring (point) (mark)))
      (with-temp-buffer
        (insert actual)
        (search-forward "⁁")
        (delete-char -1)
        (org-mode)
        )

      (outline-next-visible-heading)
      (org-mark-subtree)
      (setq expected (buffer-substring (point) (mark)))
      (with-current-buffer expected-buf
        (insert expected))

      )))
