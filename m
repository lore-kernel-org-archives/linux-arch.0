From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 10:29:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021012080.3111@localhost.localdomain>
References: <1235996477.5330.174.camel@laptop> <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain> <200903021855.02765.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46234 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbZCBSaI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:30:08 -0500
In-Reply-To: <200903021855.02765.bzolnier@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>



On Mon, 2 Mar 2009, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Could we make just the IDE driver itself enable interrupts? Sure. But that 
> 
> Actually it has been doing it for years (some host drivers don't do this by
> default and still need "hdparm -u" or equivalent but I was planning to change
> it for 2.6.30).

The IDE layer has the option to enable irq's during the transfer itself, 
yes.  But it actually works the reverse way from what you think: the irq 
layer will enable interrupts, and the IDE layer will then _not_ disable 
them during the transfer if you use "hdparm -u".

Look at ide_intr: it generally gets called with interrupts _enabled_ 
(because it doesn't use IRQF_DISABLED) and then it does:

        spin_lock_irqsave(&hwif->lock, flags);
	..
        spin_unlock(&hwif->lock);
	..
        if (drive->dev_flags & IDE_DFLAG_UNMASK)
                local_irq_enable_in_hardirq();
	...
	spin_lock_irq(&hwif->lock);
	...
	spin_unlock_irqrestore(&hwif->lock, flags);

where the magic thing is how it enables irqs again if the "irq unmask" 
flag is set.

The point I'm making is that 

 - as far as the generic irq layer is concerned, IDE might as well have 
   interrupts enabled all the time (and disabling them is a local issue, 
   more to do with locking and with timing-induced hardware _bugs_ rather 
   than anything else)

 - .. and more importantly, that is AS IT MUST BE. Because quite frankly, 
   if the irq handler enables interrupts (like IDE does), the generic IRQ 
   layer really _must_ know about it, because it may depend on 
   non-reentrancy of that interrupt.

(Small detail: the current irq layer actually does have that 
"IRQ_INPROGRESS" flag to handle re-entrancy issues regardless of anything 
else, so I guess we technically are robust in this regard. But that's 
partly an SMP issue, and conceptually it's still really really important 
information to know whether interrupts can nest. In practice, it does 
affect things like stack usage too, for example, so even with 
IRQ_INPROGRESS, there really is a difference between IRQF_DISABLED and not 
having it on).

		Linus
