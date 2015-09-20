From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Drop IPC_OLD for direct ipc syscalls?
Date: Sun, 20 Sep 2015 12:38:46 +0200
Message-ID: <87pp1dv0i1.fsf@igel.home>
References: <CAMuHMdW-w6yMDcgK-T38n45c1rURPHsVw+SwULjbgoG7d1HOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW-w6yMDcgK-T38n45c1rURPHsVw+SwULjbgoG7d1HOOA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Sun, 20 Sep 2015 11:07:28 +0200")
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>, Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Should I postpone wiring up the direct ipc syscalls on m68k (and thus renumber
> __NR_membarrier) until the above is resolved, or can they go in in v4.3?

If you wire up the direct ipc calls know you create an ABI that is
harder to get rid of.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
