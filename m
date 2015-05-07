From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Date: Thu, 7 May 2015 13:40:30 +0200
Message-ID: <20150507134030.137deeb2@thinkpad-w530>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
	<20150507102254.GE23123@twins.programming.kicks-ass.net>
	<20150507125053.5d2e8f0a@thinkpad-w530>
	<20150507111231.GF23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:36345 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbEGLkm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 07:40:42 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 7 May 2015 12:40:40 +0100
In-Reply-To: <20150507111231.GF23123@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org

> On Thu, May 07, 2015 at 12:50:53PM +0200, David Hildenbrand wrote:
> > Just to make sure we have a common understanding (as written in my cover
> > letter):
> > 
> > Your suggestion won't work with !CONFIG_PREEMPT (!CONFIG_PREEMPT_COUNT). If
> > there is no preempt counter, in_atomic() won't work. 
> 
> But there is, we _always_ have a preempt_count, and irq_enter() et al.
> _always_ increment the relevant bits.
> 
> The thread_info::preempt_count field it never under PREEMPT_COUNT
> include/asm-generic/preempt.h provides stuff regardless of
> PREEMPT_COUNT.
> 
> See how __irq_enter() -> preempt_count_add(HARDIRQ_OFFSET) ->
> __preempt_count_add() _always_ just works.


Okay thinking about this further, I think I got your point. That basically means
that the in_atomic() check makes sense for irqs.

But in my opinion, it does not help do replace

preempt_disable()
pagefault_disable()

by

preempt_disable()


(as discussed because of the PREEMPT_COUNT stuff)

So I agree that we should better add it to not mess with hard/soft irq.

> 
> Its only things like preempt_disable() / preempt_enable() that get
> munged depending on PREEMPT_COUNT/PREEMPT.
> 

But anyhow, opinions seem to differ how to best handle that whole stuff.

I think a separate counter just makes sense, as we are dealing with two
different concepts and we don't want to lose the preempt_disable =^ NOP
for !CONFIG_PREEMPT.

I also think that

pagefault_disable()
rt = copy_from_user()
pagefault_enable()

is a valid use case.

So any suggestions how to continue?

Thanks!

David
