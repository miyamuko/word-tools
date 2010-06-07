; -*- Mode: Lisp; Package: editor -*-

#|
|#

(provide "word-tools")
(in-package "editor")

(export '(wtools-spell-check-buffer
          wtools-spell-check-paragraph
          wtools-spell-check-region
          wtools-auto-summarize-buffer
          wtools-auto-summarize-region
          wtools-thesaurus
          wtools-word-count
          wtools-insert-date-time
          wtools-help-about
          *wtools-summary-length*))

(require "ole")

(defvar *wtools-summary-length* 25
  "wtools: 要約率(%)")

;; ----------------------------------------------------------------------
;; 定数
(defconstant *wdDialogHelpAbout* 9)
(defconstant *wdDialogInsertDateTime* 165)
(defconstant *wdDialogToolsSpellingAndGrammar* 828)
(defconstant *wdDialogToolsThesaurus* 194)
(defconstant *wdDialogToolsWordCount* 228)


;; ----------------------------------------------------------------------
;; 文章校正
(defun wtools-spell-check-buffer ()
  (interactive "*")
  (wtools-spell-check-region (point-min) (point-max)))

(defun wtools-spell-check-paragraph ()
  (interactive "*")
  (save-excursion
    (let ((beg (progn
                 (backward-paragraph)
                 (point)))
          (end (progn
                 (forward-paragraph)
                 (point))))
      (wtools-spell-check-region beg end))))

(defun wtools-spell-check-region (start end)
  (interactive "*r")
  (if (< end start) (rotatef start end))

  (wtools-replace-text start end
                       (wtools-new-document-and-dialog (buffer-substring start end)
                                                       *wdDialogToolsSpellingAndGrammar*)))

;; ----------------------------------------------------------------------
;; 要作の作成
(defconstant *wdSummaryModeHideAllButSummary* 1)

(defun wtools-auto-summarize-buffer ()
  (interactive "*")
  (wtools-auto-summarize-region (point-min) (point-max)))

(defun wtools-auto-summarize-region (start end)
  (interactive "*r")
  (if (< end start) (rotatef start end))

  (wtools-insert-text (wtools-new-document
                       (buffer-substring start end)
                       #'(lambda (word doc)
                           #{doc.AutoSummarize[*wtools-summary-length* *wdSummaryModeHideAllButSummary*]})
                       )))

;; ----------------------------------------------------------------------
;; 類義語辞典
(defun wtools-thesaurus ()
  (interactive "*")
  (save-excursion
    (let ((beg (progn (skip-chars-backward "A-Za-z") (point)))
          (end (progn (skip-chars-forward "A-Za-z") (point))))
      (when (< beg end)
        (wtools-replace-text beg end
                             (wtools-new-document-and-dialog (buffer-substring beg end)
                                                             *wdDialogToolsThesaurus*))))))

;; ----------------------------------------------------------------------
;; 文字カウント
(defun wtools-word-count ()
  (interactive)
  (wtools-new-document-and-dialog (buffer-substring (point-min) (point-max))
                                  *wdDialogToolsWordCount*))

;; ----------------------------------------------------------------------
;; 日付と時刻
(defun wtools-insert-date-time ()
  (interactive)
  (insert (string-trim " \t\r\f\n"
                       (wtools-new-document-and-dialog "" *wdDialogInsertDateTime*))))

;; ----------------------------------------------------------------------
;; バージョン情報
(defun wtools-help-about ()
  (interactive)
  (wtools-new-document-and-dialog "" *wdDialogHelpAbout*))

;; ----------------------------------------------------------------------
;; private

(defun wtools-replace-text (start end text)
  (unless (equal (buffer-substring start end)
                 (substitute-string text "\r" "\n"))
    (delete-region start end)
    (wtools-insert-text text)))

(defun wtools-insert-text (text)
  (insert (substitute-string text "\r" "\n")))

(defun wtools-new-document-and-dialog (text dialog-n)
  (wtools-new-document text #'(lambda (word doc)
                                #{word.Dialogs[dialog-n].Show[]})))

(defun wtools-new-document (text fn)
  (long-operation
    (let ((word (wtools-word-application))
          (doc nil)
          (selection nil))
      (unwind-protect
          (progn
            (setf doc #{word.Documents.Add[]})
            (setf #{word.Selection.Text} text)
            (funcall fn word doc)
            #{doc.Select[]}
            (setf selection #{word.Selection.Text}))
        (if doc #{doc.Close[0]})
        (if word #{word.Quit[0]})
        )
      selection)))

(defun wtools-word-application ()
  (handler-case
      (ole-create-object "Word.Application")
    (simple-error (e)
      (plain-error "Word がインストールされていません"))))

;; ----------------------------------------------------------------------
;; menu from jtc
(defvar *wtools-menu* nil)
(defun wtools-setup-menu ()
  (setq *wtools-menu*
        (let ((menu (copy-menu-items *app-menu* (create-menu))))
          (insert-popup-menu menu (get-menu-position menu 'ed::help)
                             (define-popup-menu
                               (:popup nil "文章校正(&S)"
                                (:item nil "バッファ(&B)" 'wtools-spell-check-buffer)
                                (:item nil "段落(&P)" 'wtools-spell-check-paragraph)
                                (:item nil "リージョン(&R)" 'wtools-spell-check-region))
                               (:popup nil "要約の作成(&U)"
                                (:item nil "バッファ(&B)" 'wtools-auto-summarize-buffer)
                                (:item nil "リージョン(&R)" 'wtools-auto-summarize-region))
                               (:item nil "類義語辞典(&T)" 'wtools-thesaurus)
                               (:item nil "文字カウント(&W)" 'wtools-word-count)
                               :sep
                               (:item nil "日付と時刻(&D)" 'wtools-insert-date-time)
                               :sep
                               (:item nil "バージョン情報(&A)" 'wtools-help-about))
                             "Word(&D)")
          menu))
  (setq *app-menu* *wtools-menu*))

(unless *wtools-menu*
  (cond (*app-menu*
         (wtools-setup-menu)
         (set-menu *app-menu*))
        (t
         (add-hook '*init-app-menus-hook* 'wtools-setup-menu))))
