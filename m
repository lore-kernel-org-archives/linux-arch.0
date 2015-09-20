From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Drop IPC_OLD for direct ipc syscalls?
Date: Sun, 20 Sep 2015 15:28:09 +0200
Message-ID: <CAMuHMdWnPx1HsySNhFSdDfVoSew81tnrVyoaWJezyfKMHc7zSw@mail.gmail.com>
References: <CAMuHMdW-w6yMDcgK-T38n45c1rURPHsVw+SwULjbgoG7d1HOOA@mail.gmail.com>
	<87pp1dv0i1.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pp1dv0i1.fsf@igel.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>, Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

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
