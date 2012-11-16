From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 16 Nov 2012 16:43:50 +0000
Message-ID: <201211161643.50749.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211161520.03974.arnd@arndb.de> <CAMuHMdXvr+XFwdt+rQBFvkJwb8-6hvEhg8R1ZjYo+LTme9rhqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58855 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab2KPQn5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 11:43:57 -0500
In-Reply-To: <CAMuHMdXvr+XFwdt+rQBFvkJwb8-6hvEhg8R1ZjYo+LTme9rhqA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org

On Friday 16 November 2012, Geert Uytterhoeven wrote:
> > config HAVE_GEN_RTC_LEGACY
> >         def_bool LEGACY_PC_IO && !(ARM || M32R || SPARC)
> >         # selected by M68K || MN10300 || PARISC || PPC
> 
> That's not correct: GEN_RTC is not a driver for legacy CMOS RTC, but a
> driver that provides a clasic /dev/rtc userspace API for systems that do not
> have a CMOS RTC, but do provie [gs]et_rtc_time().

Right, I was confusing it with the other symbol I suggested introducing,
HAVE_RTC_CMOS_LEGACY, which instead should default to LEGACY_PC_IO && !(...).

> So it's a deprecated complementary driver for RTC.
> 
> It's replacement using RTC_CLASS is RTC_DRV_GENERIC, which is also
> discouraged for new platforms:
> 
> config RTC_DRV_GENERIC
>         tristate "Generic RTC support"
>         # Please consider writing a new RTC driver instead of using the generic
>         # RTC abstraction
>         depends on PARISC || M68K || PPC || SUPERH32
>         help
>           Say Y or M here to enable RTC support on systems using the generic
>           RTC abstraction. If you do not know what you are doing, you should
>           just say Y.

Ah, I wasn't aware of this one. We clearly have too many of those ;-)

On a related note, I wonder if it makes sense to move the four non-RTC_LIB
drivers out of drivers/char and into drivers/rtc/legacy/ or something like
that. We wouldn't change the code of course, but in general I like the
idea of grouping code together that does the same thing, even if it doesn't
use the same in-kernel interfaces.

	Arnd
