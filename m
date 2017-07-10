From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] x86: enable dead code and data elimination (LTO)
Date: Mon, 10 Jul 2017 12:13:29 +1000
Message-ID: <20170710121329.77dd3364@roar.ozlabs.ibm.com>
References: <20170709031333.29443-1-npiggin@gmail.com>
        <20170709090551.bm2c55ctt3togim7@gmail.com>
        <CAK7LNAR-VF2o3-qcCXnkath_B74KQodh_vezPRErGPhZSao2VA@mail.gmail.com>
        <alpine.LFD.2.20.1707090946090.1959@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35926 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdGJCNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 22:13:49 -0400
In-Reply-To: <alpine.LFD.2.20.1707090946090.1959@knanqh.ubzr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@imgtec.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>

On Sun, 9 Jul 2017 09:59:44 -0400 (EDT)
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> On Sun, 9 Jul 2017, Masahiro Yamada wrote:
> 
> > Hi.
> > 
> > 2017-07-09 18:05 GMT+09:00 Ingo Molnar <mingo@kernel.org>:  
> > >
> > > * Nicholas Piggin <npiggin@gmail.com> wrote:
> > >  
> > >> FYI, easiest way to check if you forgot to KEEP a linker table is
> > >> to look at `readelf -S vmlinux` differences, and to see what is
> > >> being trimmed, look at nm differences or use --print-gc-sections
> > >> LD option to see what symbols you're trimming. Linker tables,
> > >> boot entry, and exception entry tends to require anchoring.  
> > >
> > > Could you please add a debug build target to display all discarded
> > > symbols/sections? Something like:
> > >
> > >         make lto-check
> > >
> > > ... or so?

Some kind of option like this could be a good idea. It could apply
to any kind of link-time optimization we do. I'll think about it.

> > >
> > > Thanks,
> > >
> > >         Ingo  
> > 
> > 
> > Actually, LTO activity existed some years ago
> > (but not pulled in).
> > 
> > http://www.spinics.net/lists/linux-kbuild/msg09242.html
> > 
> > 
> > IIUC, this patch enables "dead code elimination",
> > (or "garbage collection"?),
> > but I think it is different from what is called LTO.  
> 
> Yes, it is different.  With gc-sections the linker simply drops code 
> sections that have no references to them.

Yes, I shouldn't have confused the terms. gc-sections is a trivial
form of LTO, but not "LTO".

> This is therefore fast and low 
> complexity.  LTO postpones the compiler's code optimization passes at 
> the point where everything is linked together and can do things like 
> constant propagation across multiple files, etc. LTO is therefore more 
> efficient at removing unused code but compilation time is much longer 
> due to the added complexity and inherent difficulty to parallelize the 
> operation across multiple CPUS.
> 
> I think we should aim for gc-sections to be used by default and have LTO 
> as a possible option only.

I agree after it starts getting implemented and debugged by small
system users, we could make it default in the interest of sharing
testing and reducing combinations.

Thanks,
Nick
