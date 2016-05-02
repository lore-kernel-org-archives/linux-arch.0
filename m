Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33446 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbcEBIpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2016 04:45:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUcrB38jL1_estfq5aK55UFUeF=4JciVGFqcE17pY9X7g@mail.gmail.com>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	<CAMuHMdUcrB38jL1_estfq5aK55UFUeF=4JciVGFqcE17pY9X7g@mail.gmail.com>
Date: Mon, 2 May 2016 10:45:52 +0200
Message-ID: <CAMuHMdV3ZHEKgv-LPPQdZzP8KBY-yiSoeJ-cAXy54qD04--LgA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] genrtc removal
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20160502084552.D61EiMqk4Lm7tgE2pG2vVXLutbJVOGZk7DVQqAbGI8M@z>

Hi Arnd,

On Thu, Apr 28, 2016 at 9:48 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> I ended up stuffing the two patch series into one, as they are now
>> more dependent on one another. This now thoroughly removes the
>> genrtc driver including the asm/rtc.h headers it uses. For all
>> architectures that still have a meaningful asm/rtc.h, this goes
>> through two stages:
>>
>> 1) make the rtc-generic implementation independent of asm/rtc.h
>> 2) remove the asm/rtc.h header and disallow the gen_rtc driver
>>
>> As the last step, the driver itself gets removed.
>
> In general, after fixing the minor nit:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> For the m68k bits:
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

More build coverage uncovered two build failures on m68k due to "[PATCH v3
02/16] rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h":

bvme6000_defconfig:

    In file included from arch/m68k/bvme6000/rtc.c:19:
    include/linux/mc146818rtc.h: In function ‘mc146818_is_updating’:
    include/linux/mc146818rtc.h:138: error: implicit declaration of
function ‘CMOS_READ’
    include/linux/mc146818rtc.h: In function ‘mc146818_get_time’:
    include/linux/mc146818rtc.h:189: error: ‘RTC_ALWAYS_BCD’
undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared
identifier is reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appears in.)
    include/linux/mc146818rtc.h: In function ‘mc146818_set_time’:
    include/linux/mc146818rtc.h:279: error: ‘RTC_ALWAYS_BCD’
undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of
function ‘CMOS_WRITE’

mvme16x_defconfig:

    In file included from arch/m68k/mvme16x/rtc.c:18:
    include/linux/mc146818rtc.h: In function ‘mc146818_is_updating’:
    include/linux/mc146818rtc.h:138: error: implicit declaration of
function ‘CMOS_READ’
    include/linux/mc146818rtc.h: In function ‘mc146818_get_time’:
    include/linux/mc146818rtc.h:189: error: ‘RTC_ALWAYS_BCD’
undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared
identifier is reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appears in.)
    include/linux/mc146818rtc.h: In function ‘mc146818_set_time’:
    include/linux/mc146818rtc.h:279: error: ‘RTC_ALWAYS_BCD’
undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of
function ‘CMOS_WRITE’

These do not show up with a multi-platform config including Atari
support, as arch/m68k/include/asm/mc146818rtc.h provides a definition of
CMOS_READ() if CONFIG_ATARI=y.

Fortunately the fixes are simple: replace <linux/mc146818rtc.h> by
<linux/rtc.h>. Will send patches to fix...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
