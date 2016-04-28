Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34762 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbcD1HZ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 03:25:26 -0400
MIME-Version: 1.0
In-Reply-To: <1461796470-1291527-14-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	<1461796470-1291527-14-git-send-email-arnd@arndb.de>
Date: Thu, 28 Apr 2016 09:25:25 +0200
Message-ID: <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] char/genrtc: remove powerpc support
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20160428072525.5W2FEmCAU0HYRoUSDqiFQLWeJLmU0HaO9rtbL2X3CIs@z>

On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -321,6 +321,17 @@ config OF_RTC
>           Uses information from the OF or flattened device tree to instantiate
>           platform devices for direct mapped RTC chips like the DS1742 or DS1743.
>
> +config GEN_RTC
> +       bool "Use the platform RTC operations from user space"
> +       select RTC_CLASS
> +       select RTC_DRV_GENERIC
> +       help
> +         This option provides backwards compatibility with the old gen_rtc.ko
> +         module that was traditionally used for old PowerPC machines.
> +         Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
> +         replacing changing their get_rtc_time/set_rtc_time callbacks with

Drop "changing".

> +         a proper RTC device driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
