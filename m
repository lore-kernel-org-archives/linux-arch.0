Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:35369 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbEGMOt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 08:14:49 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 7 May 2015 13:14:46 +0100
Date: Thu, 7 May 2015 14:14:39 +0200
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Message-ID: <20150507141439.160cb979@thinkpad-w530>
In-Reply-To: <20150507115118.GT21418@twins.programming.kicks-ass.net>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
	<20150507102254.GE23123@twins.programming.kicks-ass.net>
	<20150507125053.5d2e8f0a@thinkpad-w530>
	<20150507111231.GF23123@twins.programming.kicks-ass.net>
	<20150507134030.137deeb2@thinkpad-w530>
	<20150507115118.GT21418@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150507121439.6qW_UErdbyUXQAzBq-gme1tCKClUv3ksZA8MMnxr74s@z>

> On Thu, May 07, 2015 at 01:40:30PM +0200, David Hildenbrand wrote:
> > But anyhow, opinions seem to differ how to best handle that whole stuff.
> > 
> > I think a separate counter just makes sense, as we are dealing with two
> > different concepts and we don't want to lose the preempt_disable =^ NOP
> > for !CONFIG_PREEMPT.
> > 
> > I also think that
> > 
> > pagefault_disable()
> > rt = copy_from_user()
> > pagefault_enable()
> > 
> > is a valid use case.
> > 
> > So any suggestions how to continue?
> 
> 
> static inline bool __pagefault_disabled(void)
> {
> 	return current->pagefault_disabled;
> }
> 
> static inline bool pagefault_disabled(void)
> {
> 	return in_atomic() || __pagefault_disabled();
> }
> 
> And leave the preempt_disable() + pagefault_disable() for now. You're
> right in that that is clearest.
> 
> If we ever get to the point where that really is an issue, I'll try and
> be clever then :-)
> 

Thanks :), well just to make sure I got your opinion on this correctly:

1. You think that 2 counters is the way to go for now

2. You agree that we can't replace preempt_disable()+pagefault_disable() with
preempt_disable() (CONFIG_PREEMPT stuff), so we need to have them separately

3. We need in_atomic() (in the fault handlers only!) in addition to make sure we
don't mess with irq contexts (In that case I would add a good comment to that
place, describing why preempt_disable() won't help)


I think this is the right way to go because:

a) This way we don't have to modify preempt_disable() logic (including
PREEMPT_COUNT).

b) There are not that many users relying on
preempt_disable()+pagefault_disable()  (compared to pure preempt_disable() or
pagefault_disable() users), so the performance overhead of two cache lines
should be small. Users only making use of one of them should see no difference
in performance.

c) We correctly decouple preemption and pagefault logic. Therefore we can now
preempt when pagefaults are disabled, which feels right.

d) We can get some of that -rt flavor into the base kernel

e) We don't require inatomic variants in pagefault_disable() context as Ingo
suggested (For me, this now feels wrong - I had a different opinion back then
when working on the first revision of this patchset).
We would use inatomic() because preempt_disable() behaves differently with
PREEMPT_COUNT, mixing concepts at the user level.


@Ingo, do you have a strong feeling against this whole patchset/idea?


David

