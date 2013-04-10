Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:65245 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965029Ab3DJK7p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2013 06:59:45 -0400
MIME-Version: 1.0
In-Reply-To: <51653C5D.4060408@suse.cz>
References: <1365585879-5321-1-git-send-email-geert@linux-m68k.org>
	<51653C5D.4060408@suse.cz>
Date: Wed, 10 Apr 2013 12:59:44 +0200
Message-ID: <CAMuHMdXEvLMz5rRjQrhENxJ6UHRnPCtzyNg=hqitspuY88G7sA@mail.gmail.com>
Subject: Re: [PATCH/RFC] m68k: Add -ffreestanding to KBUILD_CFLAGS
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>
Message-ID: <20130410105944.8RM11_uM-OPXOYfUDbEIv_Npru_Muop4p-BmgRcFT1w@z>

On Wed, Apr 10, 2013 at 12:18 PM, Michal Marek <mmarek@suse.cz> wrote:
> (Added Andi to CC)
>
> On 10.4.2013 11:24, Geert Uytterhoeven wrote:
> [...]
>> E.g. gcc turned
>>
>>     strncat(name, "%d", 2);
>>
>> into a call to strlen() and a 16-bit store, causing a link failure, as
>> arch/m68k/include/asm/string.h provides strlen() using a macro:
>>
>>     ERROR: "strlen" [net/ipv4/ip_tunnel.ko] undefined!
> [...]
>> QUESTION: Should we re-enable -ffreestanding in the main Makefile instead?
>>
>> It was removed in
>>
>> commit 6edfba1b33c701108717f4e036320fc39abe1912
>> Author: Andi Kleen <ak@suse.de>
>> Date:   Sat Mar 25 16:29:49 2006 +0100
>>
>>     [PATCH] x86_64: Don't define string functions to builtin
>
> My understanding is, that with -fnobuiltin, the compiler is not allowed
> to make assumptions about functions if it does not see their definition,
> even if they resemble standard functions. E.g. on x86_64, strlen() is
> out-of-line, so gcc would have to assume, that strcmp() has side
> effects. How about just naming the m68k inline function 'strlen'?

Having an inline function named "strlen" is not sufficient, as it needs an
(exported) symbol named "strlen" at link time or module load time.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
