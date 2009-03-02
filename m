From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 19:27:22 +0100
Message-ID: <200903021927.22781.bzolnier@gmail.com>
References: <1235996477.5330.174.camel@laptop> <200903021855.02765.bzolnier@gmail.com> <1236017249.5330.1011.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:8158 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbZCBSZZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:25:25 -0500
In-Reply-To: <1236017249.5330.1011.camel@laptop>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Peter Zijlstra wrote:
> On Mon, 2009-03-02 at 18:55 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Could we make just the IDE driver itself enable interrupts? Sure. But that 
> > 
> > Actually it has been doing it for years (some host drivers don't do this by
> > default and still need "hdparm -u" or equivalent but I was planning to change
> > it for 2.6.30).
> 
> What does it use to do that? A local_irq_enable() in hardirq context
> will make lockdep yell bloody murder :-).
> 
> Then there is local_irq_enable_in_hardirq(), which plain simply lies
> when lockdep is enabled -- IOW it would generate horrid irq latencies.
> 
> Not having to deal with IRQ recursion in lockdep helps.

Lockdep problems are the least of our worries here (please read Linus'
original mail for details).  If you're asking why it is not handled in
softirq -- that's solely because of the historical reasons and I have
high hopes w.r.t. threaded IRQs work here [that it will allow us to
address this issue without too much pain].

Thanks,
Bart
