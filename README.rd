= word-tools - Microsoft Word の機能を xyzzy から利用する

* Author: みやむこ かつゆき ((<URL:mailto:miyamuko@gmail.com>))
* Home URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/word-tools/intro.htm>))
* Version: 1.0.0


== DESCRIPTION

以下の Microsoft Word のツール類を xyzzy から使えるようにします。

* ツール - 文章校正
* ツール - 要約の作成
* ツール - その他の校正ツール - 類義語辞典
* ツール - 文字カウント
* 挿入 - 日付と時刻
* ヘルプ - バージョン情報


== INSTALL

((<NetInstaller|URL:http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html>)) でインストールした場合は 3 以降を、
NetInstaller + (({ni-autoload})) を使っている人は 4 以降で OK です。

(1) アーカイブをダウンロードします。

    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/word-tools.zip>))

(2) アーカイブを展開して、$XYZZY/site-lisp 配下にファイルをコピーします。

(3) ~/.xyzzy または $XYZZY/site-lisp/siteinit.l に以下のコードを追加します。

        ;; word-tools
        (require "word-tools")

(4) 設定を反映させるには xyzzy を再起動してください。

    ※siteinit.l に記述した場合には再ダンプが必要です。


== MODULE

=== COMMAND

--- wtools-spell-check-buffer
    バッファ全体を校正します。

--- wtools-spell-check-paragraph
    パラグラフを校正します。

--- wtools-spell-check-region
    リージョンを校正します。

--- wtools-auto-summarize-buffer
    バッファ全体の要約を作成してカーソル位置に挿入します。

    デフォルトの要約率は 25 % です。
    この値は ((|*wtools-summary-length*|)) で変更できます。

--- wtools-auto-summarize-region
    リージョンの要約を作成してカーソル位置に挿入します。

--- wtools-word-count
    バッファ全体の文字数をカウントします。

--- wtools-thesaurus
    カーソル上の単語の類義語を検索します。

--- wtools-insert-date-time
    日付と時刻の挿入。

--- wtools-help-about
    Word のバージョン情報を表示する。


=== VARIABLE

--- *wtools-summary-length*
    要約率をパーセンテージで指定します。デフォルトは 25% です。


== TODO

* 要約率をダイアログボックスで入力できるようにする。


== COPYRIGHT

word-tools は MIT/X ライセンスに従って本ソフトウェアを使用、再配布することができます。

See word-tools/docs/MIT-LICENSE for full license.


== NEWS

<<<NEWS.rd
