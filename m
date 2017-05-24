From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Unify the various copies of libgcc into lib
Date: Wed, 24 May 2017 11:21:22 +0200
Message-ID: <CAMuHMdUP2RbjV+09UGkzjJcRrsoyy9F6XT8fbCPEd0mQCDFvFw@mail.gmail.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35618 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934576AbdEXJVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 05:21:24 -0400
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Palmer,

On Wed, May 24, 2017 at 12:05 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> I'm in the process of submitting the RISC-V Linux port, and someone noticed
> that we were adding copies of some libgcc emulation routines that were the same
> as some of the other ports.  This prompted me to go through and check all the
> ports for libgcc.h and to merge the versions that were functionally identical.
>
> The only difference in libgcc.h was that there was a #define for little vs big
> endian.  The differences in the emulation routines were all just whitespace.
>
> This patch set comes in two parts:
>
>  * Patch 1 adds new copies of all the C files copied from libgcc, as well as
>    moving libgcc.h to include/lib (that's a new folder, which probably means
>    it's the wrong place to put it, but I couldn't find anything better).  There
>    are Kconfig entries for each of these library functions so architectures can
>    select them one at a time.

I would call the Kconfig symbols GENERIC_* instead of LIB_*, for consistency
with other generic implementations.

>  * The rest of the patches convert each architecture over to the new system.

Thanks! For all but "[PATCH 4/7] mips: ...":

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Unless I screwed something up, this patch set shouldn't actually change any
> functionality.  Unfortunately I don't actually have all these cross compilers
> setup so I can't actually test any of this, but I did convert the RISC-V port
> over to using this system and it appears to be OK there so at least this isn't
> completely broken.

https://www.kernel.org/pub/tools/crosstool/

BTW, blackfin, h8300, m68k, and parisc have their own implementations, too.
They look different, but I believe their functionality is identical.
They can be converted later, though.

Gr{oetje,eeting}s,

                        Geert
