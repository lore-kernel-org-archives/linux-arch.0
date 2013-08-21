From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Get rid of SUBARCH
Date: Wed, 21 Aug 2013 14:07:33 +0200
Message-ID: <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
Sender: linux-kbuild-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 21, 2013 at 10:19 AM, Richard Weinberger <richard@nod.at> wrote:
> This series is an attempt to remove the SUBARCH make parameter.
> It as introduced at the times of Linux 2.5 for UML to tell the UML
> build system what the real architecture is.
>
> But we actually don't need SUBARCH, we can store this information
> in the .config file.

Haha, now you have OS_ARCH (shouldn't that be called HOST_ARCH?) instead,
which is available only for UM?

> The series touches also m68k, sh, mips and unicore32.
> These architectures magically select a cross compiler if ARCH != SUBARCH.
> Do really need that behavior?

This does remove functionality.
It allows to build a kernel using e.g. "make ARCH=m68k".

Perhaps this can be moved to generic code? Most (not all!) cross-toolchains
are called $ARCH-{unknown-,}linux{,-gnu}.
Exceptions are e.g. am33_2.0-linux and bfin-uclinux.

> [PATCH 1/8] um: Create defconfigs for i386 and x86_64
> [PATCH 3/8] um: Remove old defconfig

Why not merge these two, so git copy/rename detection will show only the real
changes?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
