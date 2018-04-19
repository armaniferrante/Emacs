;;; Commentary:
;;;
;;; To setup gdb on mac-os, you need to add to ~/.gdbinit:
;;;
;;; set startup-with-shell off
;;; python
;;; # This is valid for rustup rust installation only.  The path will be different for Homebrew-installed Rust.
;;; import os
;;; sys.path.insert(0, os.path.join(os.getenv('HOME'), ".rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/etc"))
;;; import gdb_rust_pretty_printing
;;; gdb_rust_pretty_printing.register_printers(gdb)
;;; end

(use-package rust-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package flycheck-rust
  :ensure t)

(use-package rust-playground
  :ensure t)

; curl https://sh.rustup.rs -sSf | sh
; rustup component add rust-src
; cargo install racer
(use-package racer
  :ensure t)

(use-package company
  :ensure t)

(use-package cargo
  :ensure t  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

(defun set-two-spaces ()
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

(defun my-rust-mode-hook ()
  (flycheck-rust-setup)
  (rust-enable-format-on-save)
  (racer-mode)
  (set-two-spaces))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;; note: when installing rust via rustup, you might need to run
;;       rustup update nightly
;;       rustup component add rustfmt-preview
;;       before getting rust-fmt to work properly

;; to find: echo `rustc --print sysroot`/lib/rustlib/src/rust/src
(setq racer-rust-src-path "/Users/armaniferrante/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
