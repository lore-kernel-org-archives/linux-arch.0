Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33724 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGIN7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 09:59:47 -0400
Received: by mail-io0-f176.google.com with SMTP id h64so14597739iod.0
        for <linux-arch@vger.kernel.org>; Sun, 09 Jul 2017 06:59:47 -0700 (PDT)
Date: Sun, 9 Jul 2017 09:59:44 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH] x86: enable dead code and data elimination (LTO)
In-Reply-To: <CAK7LNAR-VF2o3-qcCXnkath_B74KQodh_vezPRErGPhZSao2VA@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1707090946090.1959@knanqh.ubzr>
References: <20170709031333.29443-1-npiggin@gmail.com> <20170709090551.bm2c55ctt3togim7@gmail.com> <CAK7LNAR-VF2o3-qcCXnkath_B74KQodh_vezPRErGPhZSao2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@imgtec.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170709135944.I5gLSNIF7lNl898uf7ZSyvxlhXveH276WZ95et2Xbgw@z>

On Sun, 9 Jul 2017, Masahiro Yamada wrote:

> Hi.
> 
> 2017-07-09 18:05 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
> >
> > * Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> >> FYI, easiest way to check if you forgot to KEEP a linker table is
> >> to look at `readelf -S vmlinux` differences, and to see what is
> >> being trimmed, look at nm differences or use --print-gc-sections
> >> LD option to see what symbols you're trimming. Linker tables,
> >> boot entry, and exception entry tends to require anchoring.
> >
> > Could you please add a debug build target to display all discarded
> > symbols/sections? Something like:
> >
> >         make lto-check
> >
> > ... or so?
> >
> > Thanks,
> >
> >         Ingo
> 
> 
> Actually, LTO activity existed some years ago
> (but not pulled in).
> 
> http://www.spinics.net/lists/linux-kbuild/msg09242.html
> 
> 
> IIUC, this patch enables "dead code elimination",
> (or "garbage collection"?),
> but I think it is different from what is called LTO.

Yes, it is different.  With gc-sections the linker simply drops code 
sections that have no references to them. This is therefore fast and low 
complexity.  LTO postpones the compiler's code optimization passes at 
the point where everything is linked together and can do things like 
constant propagation across multiple files, etc. LTO is therefore more 
efficient at removing unused code but compilation time is much longer 
due to the added complexity and inherent difficulty to parallelize the 
operation across multiple CPUS.

I think we should aim for gc-sections to be used by default and have LTO 
as a possible option only.


Nicolas
