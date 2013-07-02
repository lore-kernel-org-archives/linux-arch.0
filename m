From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support
 'COMPILE_TEST' in 'asm-generic'.
Date: Tue, 2 Jul 2013 09:19:51 +0200
Message-ID: <CAMuHMdUvctqqStGE0QKM_BqgK2f6f_E6T=przdYszZo9A_oDzg@mail.gmail.com>
References: <51CA8AB8.7080504@asianux.com>
	<51CA900E.9020407@nod.at>
	<51CA9E92.4000107@asianux.com>
	<51CAA0C6.60007@nod.at>
	<51CAA78C.5040900@asianux.com>
	<51CAA8D6.9000505@nod.at>
	<51CAAD1D.8050801@asianux.com>
	<51CAAE7C.9090003@nod.at>
	<51CAB556.4070700@asianux.com>
	<51CAB689.70008@nod.at>
	<CAMuHMdXw6VYhnNWcVfWc9ssxKTqKFcDbN4WXL5i=eNGy+gXcRA@mail.gmail.com>
	<51CABBDD.403@asianux.com>
	<51CABFAC.1040505@nod.at>
	<51CAC0D0.60505@asianux.com>
	<51D0DE09.4090702@asianux.com>
	<51D0FAFE.5010500@asianux.com>
	<51D23766.8000605@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51D23766.8000605@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Richard Weinberger <richard@nod.at>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 2, 2013 at 4:13 AM, Chen Gang <gang.chen@asianux.com> wrote:
> 'asm-generic' need provide necessary configuration checking, if can't
> pass checking, 'asm-generic' shouldn't implement it.
>
> For 'COMPILE_TEST', according to its help contents, 'asm-generic' need
> let it pass configuration checking, and provide related dummy contents
> for it.
>
> Part of 'COMPLE_TEST' help contents in "init/Kconfig":
>
>   "...Despite they cannot be loaded there (or even when they load they cannot be used due to missing HW support)..."
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

NAKed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please don't clutter the code with checks for CONFIG_COMPILE_TEST.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
