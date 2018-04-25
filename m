Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38703 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756021AbeDYSgp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2018 14:36:45 -0400
MIME-Version: 1.0
In-Reply-To: <20180425160311.2718314-5-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de> <20180425160311.2718314-5-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 20:36:43 +0200
Message-ID: <CAMuHMdXzNwNxbrcbJxdh+ON5MU7Wp2OPYriHq9mk3eViXOWaOg@mail.gmail.com>
Subject: Re: [PATCH 04/17] asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, libc-alpha <libc-alpha@sourceware.org>, Thomas Gleixner <tglx@linutronix.de>, netdev <netdev@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Message-ID: <20180425183643.fFJunDoEVA0U69SWWgQH6f3Xdd-JenhipHyVRTNQ50E@z>

On Wed, Apr 25, 2018 at 6:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The sys_llseek sytem call is needed on all 32-bit architectures and
> none of the 64-bit ones, so we can remove the __ARCH_WANT_SYS_LLSEEK guard
> and simplify the include/asm-generic/unistd.h header further.
>
> Since 32-bit tasks can run either natively or in compat mode on 64-bit
> architectures, we have to check for both !CONFIG_64BIT and CONFIG_COMPAT.
>
> There are a few 64-bit architectures that also reference sys_llseek
> in their 64-bit ABI (e.g. sparc), but I verified that those all
> select CONFIG_COMPAT, so the #if check is still correct here. It's
> a bit odd to include it in the syscall table though, as it's the
> same as sys_lseek() on 64-bit, but with strange calling conventions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
