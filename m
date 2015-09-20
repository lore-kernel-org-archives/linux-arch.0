Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36123 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbbITN2K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2015 09:28:10 -0400
MIME-Version: 1.0
In-Reply-To: <87pp1dv0i1.fsf@igel.home>
References: <CAMuHMdW-w6yMDcgK-T38n45c1rURPHsVw+SwULjbgoG7d1HOOA@mail.gmail.com>
	<87pp1dv0i1.fsf@igel.home>
Date: Sun, 20 Sep 2015 15:28:09 +0200
Message-ID: <CAMuHMdWnPx1HsySNhFSdDfVoSew81tnrVyoaWJezyfKMHc7zSw@mail.gmail.com>
Subject: Re: Drop IPC_OLD for direct ipc syscalls?
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>, Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>
Message-ID: <20150920132809.4iRmcgPukGPP2FgbC6gGMllJfgeT2bjnB0gh__UfbR0@z>

Hi Andreas,

On Sun, Sep 20, 2015 at 12:38 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Should I postpone wiring up the direct ipc syscalls on m68k (and thus renumber
>> __NR_membarrier) until the above is resolved, or can they go in in v4.3?
>
> If you wire up the direct ipc calls know you create an ABI that is
> harder to get rid of.

That's what I was mostly worried about.
Thanks for confirming!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
