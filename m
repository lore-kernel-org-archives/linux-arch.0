From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [patch 1/6] hardirq: Make hardirq bits generic
Date: Thu, 19 Sep 2013 19:02:18 +0200
Message-ID: <87txhg3ftx.fsf@igel.home>
References: <20130917082838.218329307@infradead.org>
	<20130917182350.449685712@linutronix.de>
	<20130917183628.534494408@linutronix.de>
	<CAMuHMdWgrQf+ULDrZyY5R+vT3GtiWEgpsWxmfk0b5pivN7wBmg@mail.gmail.com>
	<alpine.DEB.2.02.1309172315550.4089@ionos.tec.linutronix.de>
	<alpine.DEB.2.02.1309181159520.4089@ionos.tec.linutronix.de>
	<alpine.DEB.2.02.1309191652480.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49560 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3ISRCZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2013 13:02:25 -0400
In-Reply-To: <alpine.DEB.2.02.1309191652480.4089@ionos.tec.linutronix.de>
	(Thomas Gleixner's message of "Thu, 19 Sep 2013 17:14:57 +0200
	(CEST)")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linux/m68k <linux-m68k@vger.kernel.org>

Thomas Gleixner <tglx@linutronix.de> writes:

> +	/*
> +	 * Only the last interrupt leaving the kernel goes through the
> +	 * various exception return checks.
> +	 */
> +	cmpl	#0, %d0
	tstl	%d0

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
