From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 21:17:55 +0000
Message-ID: <20090302211755.24a58ec9@lxorguk.ukuu.org.uk>
References: <1235996477.5330.174.camel@laptop>
	<alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756565AbZCBVSn@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

> Now, IDE controllers that we end up using PIO on all tend to be pretty 
> old, but admittedly even the old ones are faster than the worst-case 
> timings, so in practice you're not looking quite at that kind of horror 
> case, but you're still looking at each sector transfer (256 16-bit words) 
> taking on the order of tens of us.

The worst case timings are far worse because of IORDY. 

> Now: I suspect you don't have a single machine that does PIO by default, 
> and you probably haven't had any for the last ten years. These things 
> _are_ old. But they do exist. 

I bet you do for some stuff. Most CF cards are PIO only. Several
controllers need to do PIO for some corner cases. Almost all pre-AHCI
controllers issue command blocks via PIO.

Worse still of course some controllers have an erratum where touching
some of the other registers during a transfer [which is what you need to
do to see if you are the IRQ source] corrupts the transfer. Not all
devices honour the IRQ masking bit on the device either. That makes the
generalised case of doing both unmasked transfers after an IRQ and the
errata cases of handling IRQs you can't mask and must leave disabled
rather more exciting than is nice.

Alan
