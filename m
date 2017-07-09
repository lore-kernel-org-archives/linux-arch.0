Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28962 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdGIN3p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 09:29:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170709090551.bm2c55ctt3togim7@gmail.com>
References: <20170709031333.29443-1-npiggin@gmail.com> <20170709090551.bm2c55ctt3togim7@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 9 Jul 2017 22:29:37 +0900
Message-ID: <CAK7LNAR-VF2o3-qcCXnkath_B74KQodh_vezPRErGPhZSao2VA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86: enable dead code and data elimination (LTO)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@imgtec.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170709132937.61Uc0MabU1M9PDlMV7bH_EgaTiaVaKHobwBcbHgR7Cw@z>

Hi.

2017-07-09 18:05 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
>
> * Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> FYI, easiest way to check if you forgot to KEEP a linker table is
>> to look at `readelf -S vmlinux` differences, and to see what is
>> being trimmed, look at nm differences or use --print-gc-sections
>> LD option to see what symbols you're trimming. Linker tables,
>> boot entry, and exception entry tends to require anchoring.
>
> Could you please add a debug build target to display all discarded
> symbols/sections? Something like:
>
>         make lto-check
>
> ... or so?
>
> Thanks,
>
>         Ingo


Actually, LTO activity existed some years ago
(but not pulled in).

http://www.spinics.net/lists/linux-kbuild/msg09242.html


IIUC, this patch enables "dead code elimination",
(or "garbage collection"?),
but I think it is different from what is called LTO.


-- 
Best Regards
Masahiro Yamada
