From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 02 Mar 2009 19:07:28 +0100
Message-ID: <1236017249.5330.1011.camel@laptop>
References: <1235996477.5330.174.camel@laptop>
	 <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
	 <200903021855.02765.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46362 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZCBSHk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:07:40 -0500
In-Reply-To: <200903021855.02765.bzolnier@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 2009-03-02 at 18:55 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Could we make just the IDE driver itself enable interrupts? Sure. But that 
> 
> Actually it has been doing it for years (some host drivers don't do this by
> default and still need "hdparm -u" or equivalent but I was planning to change
> it for 2.6.30).

What does it use to do that? A local_irq_enable() in hardirq context
will make lockdep yell bloody murder :-).

Then there is local_irq_enable_in_hardirq(), which plain simply lies
when lockdep is enabled -- IOW it would generate horrid irq latencies.

Not having to deal with IRQ recursion in lockdep helps.
