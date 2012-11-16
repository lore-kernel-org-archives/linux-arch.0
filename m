From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 16 Nov 2012 17:19:55 +0100
Message-ID: <CAMuHMdXvr+XFwdt+rQBFvkJwb8-6hvEhg8R1ZjYo+LTme9rhqA@mail.gmail.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
	<201211091428.42998.arnd@arndb.de>
	<50A61E51.8000306@imgtec.com>
	<201211161520.03974.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60205 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2KPQT4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 11:19:56 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so3016689vbb.19
        for <linux-arch@vger.kernel.org>; Fri, 16 Nov 2012 08:19:56 -0800 (PST)
In-Reply-To: <201211161520.03974.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org

On Fri, Nov 16, 2012 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> RTC defaults to n, but I've narrowed it down to alpha, m32r, mips
>> (MACH_LOONSON), mn10300, and x86 which provide asm/mc146818rtc.h.
>>
>> GEN_RTC defaults to n, and I've narrowed to alpha, m68k, mn10300,
>> parisc, ppc, x86 which provide asm/rtc.h.
>
> It's amazing that those are still around after we've had RTC_LIB
> for so long. The "modern" driver that is supposed to replace these
> two is RTC_DRV_CMOS, which currently builds for X86 || ALPHA ||
> ARM || M32R || ATARI || PPC || MIPS || SPARC64.

> config HAVE_GEN_RTC_LEGACY
>         def_bool LEGACY_PC_IO && !(ARM || M32R || SPARC)
>         # selected by M68K || MN10300 || PARISC || PPC

That's not correct: GEN_RTC is not a driver for legacy CMOS RTC, but a
driver that provides a clasic /dev/rtc userspace API for systems that do not
have a CMOS RTC, but do provie [gs]et_rtc_time().
So it's a deprecated complementary driver for RTC.

It's replacement using RTC_CLASS is RTC_DRV_GENERIC, which is also
discouraged for new platforms:

config RTC_DRV_GENERIC
        tristate "Generic RTC support"
        # Please consider writing a new RTC driver instead of using the generic
        # RTC abstraction
        depends on PARISC || M68K || PPC || SUPERH32
        help
          Say Y or M here to enable RTC support on systems using the generic
          RTC abstraction. If you do not know what you are doing, you should
          just say Y.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
