Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:63332 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab3KYKDJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 05:03:09 -0500
MIME-Version: 1.0
In-Reply-To: <20131125090922.GB13358@samfundet.no>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
	<1385369734-24893-15-git-send-email-geert@linux-m68k.org>
	<20131125090922.GB13358@samfundet.no>
Date: Mon, 25 Nov 2013 11:03:08 +0100
Message-ID: <CAMuHMdVyFhwpnRm4fwH5XcgDRC0qASd-Gmg15aOYuxSZOHsB9g@mail.gmail.com>
Subject: Re: [PATCH 14/24] avr32: Use Kbuild logic to provide <asm/types.h>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>
Message-ID: <20131125100308.v9w2GSsrIcSwPcnY7zyMF7HWBGtPNgqQC0HlDapqS9U@z>

On Mon, Nov 25, 2013 at 10:09 AM, Hans-Christian Egtvedt
<egtvedt@samfundet.no> wrote:
> Around Mon 25 Nov 2013 09:55:24 +0100 or thereabout, Geert Uytterhoeven wrote:
>> The extra definition for BITS_PER_LONG is also indirectly provided
>> by <asm-generic/types.h>, via <asm-generic/int-ll64.h> and
>> <asm/bitsperlong.h>
>
> Are you adding a new include/asm-generic/types.h, which will include
> bitsperlong.h ?

Yes, that's [PATCH 24/24].

Currently you get it through the UAPI <asm-generic/types.h>, via
<asm-generic/int-ll64.h> and <asm/bitsperlong.h>.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
