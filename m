From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Enable ARCH_USE_BUILTIN_BSWAP by default
Date: Thu, 29 Oct 2015 08:29:19 +0100
Message-ID: <CAMuHMdXsas0xpMazW8eTyzffWYbryxbeEustN0v2=Xk3zzGz7w@mail.gmail.com>
References: <1446044032.3405.241.camel@infradead.org>
	<20151028.184415.373814461753571638.davem@davemloft.net>
	<1446087994.3405.277.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36254 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbJ2H3U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2015 03:29:20 -0400
Received: by oiao187 with SMTP id o187so21415263oia.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2015 00:29:20 -0700 (PDT)
In-Reply-To: <1446087994.3405.277.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Miller <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>, Wu Fengguang <fengguang.wu@intel.com>

On Thu, Oct 29, 2015 at 4:06 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2015-10-28 at 18:44 -0700, David Miller wrote:
>> From: David Woodhouse <dwmw2@infradead.org>
>> Date: Wed, 28 Oct 2015 23:53:52 +0900
>>
>> > I know MIPS will need some additional libgcc functionality brought
>> > into the kernel, and Ralf has already been looking at that; not
>> sure
>> > about other platforms. Let's find out :)
>>
>> It should properly build on Sparc, but I still need to do my due
>> diligence to see if gcc will actually emit the little-endian loads
>> and stores or not...
>
> The results of the 0-day test (thanks Fengguang) seem to indicate that
> we need an implementation of __bswapdi2 and __bswapsi2 on SPARC, as
> well as blackfin, frv, m32r, m68k, microblaze, mips, mn10300, parisc
> and sh.

Please note that for m68k only m68k-m5475evb_defconfig failed, so
it seems to be compiler/config specific.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
