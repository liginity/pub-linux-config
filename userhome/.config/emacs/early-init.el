;; -*- lexical-binding: t; -*-


;; NOTE early-init.el is supported since emacs 27.

;; maximize the window
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq inhibit-startup-screen t)

(menu-bar-mode -1)
(when (display-graphic-p)
  ;; the following seems not to be present in text terminals.
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(require 'server)
(unless (server-running-p)
  (server-start)
  (message "%s" "Server named \"server\" is started"))
