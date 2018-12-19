From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 00/27] kconfig: remove all reduce/shift conflicts,
 refactor lexer, fix various issues
Date: Wed, 19 Dec 2018 23:59:06 +0900
Message-ID: <CAK7LNAQigp+cnH18w6iYKjix3oZtOOjOF=e1RKiJPdBFr3TwPw@mail.gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michal Simek <monstr@monstr.eu>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 11, 2018 at 8:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> When I tryed to change something, I was often hit by annoying
> shift/reduce conflicts in the parser.
>
> The lexer and parser are too cluttered.
>
> So, I decided to clean-up now.
>
>   - Fix all shift/reduce conflicts in the parser
>
>   - Rewrite the lexer. The linear keyword search was removed.
>     The number of states descreased from 6 to 4.
>
>   - Fix various subtle issues
>
>
>
> Masahiro Yamada (27):
>   kconfig: fix file name and line number of warn_ignored_character()
>   kconfig: fix memory leak when EOF is encountered in quotation
>   kconfig: require T_EOL to reduce visible statement
>   kconfig: remove unneeded pattern matching to whitespaces
>   kconfig: refactor pattern matching in STRING state
>   kconfig: fix ambiguous grammar in terms of new lines
>   kconfig: clean up EOF handling in the lexer
>   kconfig: warn no new line at end of file
>   kconfig: remove grammatically ambiguous "unexpected option" diagnostic
>   kconfig: remove grammatically ambiguous option_error
>   kconfig: remove redundant if_block rule
>   kconfig: remove redundant menu_block rule
>   kconfig: loosen the order of "visible" and "depends on" in menu entry
>   kconfig: rename depends_list to comment_option_list
>   kconfig: remove redundant token defines
>   kconfig: use distinct tokens for type and default properties
>   kconfig: refactor scanning and parsing "option" properties
>   kconfig: use specific tokens instead of T_ASSIGN for assignments
>   kconfig: use T_WORD instead of T_VARIABLE for variables
>   microblaze: surround string default in Kconfig with double quotes
>   treewide: surround file paths in Kconfig files with double quotes
>   kconfig: ban the use of '.' and '/' in unquoted words
>   kconfig: refactor end token rules
>   kconfig: stop associating kconf_id with yylval
>   kconfig: switch to ASSIGN_VAL state in the second lexer
>   kconfig: update current_pos in the second lexer
>   kconfig: remove keyword lookup table entirely


Series, applied to kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada
