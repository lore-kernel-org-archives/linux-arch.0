From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
Date: Wed, 26 Jun 2013 11:48:20 +0200
Message-ID: <CAMuHMdXw6VYhnNWcVfWc9ssxKTqKFcDbN4WXL5i=eNGy+gXcRA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51CAB689.70008@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Chen Gang <gang.chen@asianux.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 26, 2013 at 11:38 AM, Richard Weinberger <richard@nod.at> wrote:
>> Since the API itself already contents the meaning: "return NULL means
>> the arch has no related io memory",

No, NULL means it could not map the I/O memory.

>> Why not define a generic dummy one in "include/asm-generic/io.h" instead
>> of "HAS_IOMEM" (which has already spread many various places, and also,
>> most of new drivers have to know about it).
>>
>> e.g: in "include/asm-generic/io.h", if "CONFIG_HAS_IOMEM=n", define a
>> dummy ioremap() which return NULL ... (also need consider more details).
>
> Because we don't even want to build these drivers and not make them fail while
> executing io memory related functions.

Indeed, it doesn't make sense to build drivers that cannot work.
And they may fail in a very bad way.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
