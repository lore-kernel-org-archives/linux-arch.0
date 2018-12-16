Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:38624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeLPKAv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Dec 2018 05:00:51 -0500
Date: Sun, 16 Dec 2018 11:00:42 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Message-ID: <20181216100042.GA815@zn.tnic>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
 <20181213105146.GH5289@hirez.programming.kicks-ass.net>
 <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
 <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Richard Biener <rguenther@suse.de>, Logan Gunthorpe <logang@deltatee.com>, Sedat Dilek <sedat.dilek@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Michal Marek <michal.lkml@markovi.net>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Message-ID: <20181216100042.Bpeo8pxdJjkxOxVM9HBGN3R_IsKLV8WEfWbIaR6ZcAY@z>

On Sun, Dec 16, 2018 at 02:33:39AM +0000, Nadav Amit wrote:
> In general, I think that from the start it was clear that the motivation for
> the patch-set is not just performance and also better code. For example, I
> see no reason to revert the PV-changes or the lock-prefix changes that
> improved the code readability.

One thing that has caught my eye with the asm macros, which actually
decreases readability, is that I can't see the macro properly expanded
when I do

make <filename>.s

For example, I get

#APP
# 164 "./arch/x86/include/asm/cpufeature.h" 1
        STATIC_CPU_HAS bitnum=$8 cap_byte="boot_cpu_data+35(%rip)" feature=123 t_yes=.L75 t_no=.L78 always=117  #, MEM[(const char *)&boot_cpu_data + 35B],,,,
# 0 "" 2
        .loc 11 164 2 view .LVU480
#NO_APP

but I'd like to see the actual asm as it is really helpful when hacking
on inline asm stuff. And I haven't found a way to make gcc expand asm
macros in .s output.

Now, assuming the gcc inline patch will be backported to gcc8, I think
we should be covered on all modern distros going forward. So I think we
should revert at least the more complex macros.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
