;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq TeX-auto-save t
      TeX-parse-self t
      TeX-save-query nil
      TeX-PDF-mode t)

;; Use PDF-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Enable synctex correlation
(setq TeX-source-correlate-mode t)

;; Automatically refresh pdf buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(latex-preview-pane-enable)

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-hook 'after-save-hook (lambda () (TeX-command-run-all nil)) nil t)))

(defface my-prettify-symbols-face
  '((t :height 1.5))  ;; Adjust the :height value as needed
  "Face for prettified symbols.")

(setq prettify-symbols-alist
      '(("\\alpha" . ?α)
        ("\\beta" . ?β)
        ("\\gamma" . ?γ)
        ("\\delta" . ?δ)
        ("\\epsilon" . ?ε)
        ("\\zeta" . ?ζ)
        ("\\eta" . ?η)
        ("\\theta" . ?θ)
        ("\\iota" . ?ι)
        ("\\kappa" . ?κ)
        ("\\lambda" . ?λ)
        ("\\mu" . ?μ)
        ("\\nu" . ?ν)
        ("\\xi" . ?ξ)
        ("\\pi" . ?π)
        ("\\rho" . ?ρ)
        ("\\sigma" . ?σ)
        ("\\tau" . ?τ)
        ("\\upsilon" . ?υ)
        ("\\phi" . ?φ)
        ("\\chi" . ?χ)
        ("\\psi" . ?ψ)
        ("\\omega" . ?ω)
        ("\\forall" . ?∀)
        ("\\exists" . ?∃)
        ("\\neg" . ?¬)
        ("\\in" . ?∈)
        ("\\subset" . ?⊂)
        ("\\subseteq" . ?⊆)
        ("\\supset" . ?⊃)
        ("\\supseteq" . ?⊇)
        ("\\implies" . ?⇒)
        ("\\iff" . ?⇔)
        ("\\nabla" . ?∇)
        ("\\partial" . ?∂)
        ("\\infty" . ?∞)
        ("\\sum" . ?∑)
        ("\\prod" . ?∏)
        ("\\int" . ?∫)
        ("\\oint" . ?∮)
        ("\\sqrt" . ?√)
        ("\\pm" . ?±)
        ("\\times" . ?×)
        ("\\div" . ?÷)
        ("\\cup" . ?∪)
        ("\\cap" . ?∩)
        ("\\vee" . ?∨)
        ("\\wedge" . ?∧)
        ("\\oplus" . ?⊕)
        ("\\otimes" . ?⊗)
        ("\\perp" . ?⊥)
        ("\\parallel" . ?∥)))


(setq prettify-symbols-compose-predicate
      (lambda (start end)
        (let ((char (char-after start)))
          (and char
               (memv char (mapcar 'cdr prettify-symbols-alist))))))

(global-prettify-symbols-mode 1)

(map! :after auctex :map LaTeX-mode-map "<tab>" #'cdlatex-tab)