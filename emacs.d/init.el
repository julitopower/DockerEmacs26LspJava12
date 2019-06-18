(server-start)

;; We don't want to type yes and no all the time so, do y and n
(defalias 'yes-or-no-p 'y-or-n-p)
;; Disable the horrid auto-save
(setq auto-save-default nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set packages to install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; You might already have this line
(package-initialize)
;; list the packages you want
(defvar package-list)
(setq package-list '(solarized-theme projectile yasnippet
                                     lsp-mode hydra company-lsp
                                     lsp-ui lsp-java
                                     dap-mode))
;; TODO: Install dap-java
;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The deeper blue theme is loaded but the resulting text
;; appears black in Aquamacs. This can be fixed by setting
;; the font color under Menu Bar->Options->Appearance->Font For...
;; and then setting "Adopt Face and Frame Parameter as Frame Default"
(if window-system
    (load-theme 'deeper-blue t)
    (load-theme 'wheatgrass t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP-JAVA configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
