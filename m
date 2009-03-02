From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 19:48:51 +0100
Message-ID: <200903021948.51500.bzolnier@gmail.com>
References: <1235996477.5330.174.camel@laptop> <200903021855.02765.bzolnier@gmail.com> <alpine.LFD.2.00.0903021012080.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:33134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZCBSs7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:48:59 -0500
In-Reply-To: <alpine.LFD.2.00.0903021012080.3111@localhost.localdomain>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Linus Torvalds wrote:
> 
> On Mon, 2 Mar 2009, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Could we make just the IDE driver itself enable interrupts? Sure. But that 
> > 
> > Actually it has been doing it for years (some host drivers don't do this by
> > default and still need "hdparm -u" or equivalent but I was planning to change
> > it for 2.6.30).
> 
> The IDE layer has the option to enable irq's during the transfer itself, 
> yes.  But it actually works the reverse way from what you think: the irq 

Hmm, I said nothing about how it is implemented in the IDE code itself. :)

> layer will enable interrupts, and the IDE layer will then _not_ disable 
> them during the transfer if you use "hdparm -u".
> 
> Look at ide_intr: it generally gets called with interrupts _enabled_ 
> (because it doesn't use IRQF_DISABLED) and then it does:
> 
>         spin_lock_irqsave(&hwif->lock, flags);
> 	..
>         spin_unlock(&hwif->lock);
> 	..
>         if (drive->dev_flags & IDE_DFLAG_UNMASK)
>                 local_irq_enable_in_hardirq();
> 	...
> 	spin_lock_irq(&hwif->lock);
> 	...
> 	spin_unlock_irqrestore(&hwif->lock, flags);
> 
> where the magic thing is how it enables irqs again if the "irq unmask" 
> flag is set.
> 
> The point I'm making is that 
> 
>  - as far as the generic irq layer is concerned, IDE might as well have 
>    interrupts enabled all the time (and disabling them is a local issue, 
>    more to do with locking and with timing-induced hardware _bugs_ rather 
>    than anything else)
> 
>  - .. and more importantly, that is AS IT MUST BE. Because quite frankly, 
>    if the irq handler enables interrupts (like IDE does), the generic IRQ 
>    layer really _must_ know about it, because it may depend on 
>    non-reentrancy of that interrupt.

Fixing this is on long-term TODO (there was just a ton of more high-prio
stuff to take care of first).

Thanks,
Bart
