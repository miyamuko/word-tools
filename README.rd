= word-tools - Microsoft Word �̋@�\�� xyzzy ���痘�p����

* Author: �݂�ނ� ���䂫 ((<URL:mailto:miyamuko@gmail.com>))
* Home URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/word-tools/intro.htm>))
* Version: 1.0.0


== DESCRIPTION

�ȉ��� Microsoft Word �̃c�[���ނ� xyzzy ����g����悤�ɂ��܂��B

* �c�[�� - ���͍Z��
* �c�[�� - �v��̍쐬
* �c�[�� - ���̑��̍Z���c�[�� - �ދ`�ꎫ�T
* �c�[�� - �����J�E���g
* �}�� - ���t�Ǝ���
* �w���v - �o�[�W�������


== INSTALL

((<NetInstaller|URL:http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html>)) �ŃC���X�g�[�������ꍇ�� 3 �ȍ~���A
NetInstaller + (({ni-autoload})) ���g���Ă���l�� 4 �ȍ~�� OK �ł��B

(1) �A�[�J�C�u���_�E�����[�h���܂��B

    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/word-tools.zip>))

(2) �A�[�J�C�u��W�J���āA$XYZZY/site-lisp �z���Ƀt�@�C�����R�s�[���܂��B

(3) ~/.xyzzy �܂��� $XYZZY/site-lisp/siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂��B

        ;; word-tools
        (require "word-tools")

(4) �ݒ�𔽉f������ɂ� xyzzy ���ċN�����Ă��������B

    ��siteinit.l �ɋL�q�����ꍇ�ɂ͍ă_���v���K�v�ł��B


== MODULE

=== COMMAND

--- wtools-spell-check-buffer
    �o�b�t�@�S�̂��Z�����܂��B

--- wtools-spell-check-paragraph
    �p���O���t���Z�����܂��B

--- wtools-spell-check-region
    ���[�W�������Z�����܂��B

--- wtools-auto-summarize-buffer
    �o�b�t�@�S�̗̂v����쐬���ăJ�[�\���ʒu�ɑ}�����܂��B

    �f�t�H���g�̗v�񗦂� 25 % �ł��B
    ���̒l�� ((|*wtools-summary-length*|)) �ŕύX�ł��܂��B

--- wtools-auto-summarize-region
    ���[�W�����̗v����쐬���ăJ�[�\���ʒu�ɑ}�����܂��B

--- wtools-word-count
    �o�b�t�@�S�̂̕��������J�E���g���܂��B

--- wtools-thesaurus
    �J�[�\����̒P��̗ދ`����������܂��B

--- wtools-insert-date-time
    ���t�Ǝ����̑}���B

--- wtools-help-about
    Word �̃o�[�W��������\������B


=== VARIABLE

--- *wtools-summary-length*
    �v�񗦂��p�[�Z���e�[�W�Ŏw�肵�܂��B�f�t�H���g�� 25% �ł��B


== TODO

* �v�񗦂��_�C�A���O�{�b�N�X�œ��͂ł���悤�ɂ���B


== COPYRIGHT

word-tools �� MIT/X ���C�Z���X�ɏ]���Ė{�\�t�g�E�F�A���g�p�A�Ĕz�z���邱�Ƃ��ł��܂��B

See word-tools/docs/MIT-LICENSE for full license.


== NEWS

<<<NEWS.rd
