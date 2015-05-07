From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Date: Thu, 7 May 2015 14:32:08 +0200
Message-ID: <20150507123208.GJ23123@twins.programming.kicks-ass.net>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
 <20150507102254.GE23123@twins.programming.kicks-ass.net>
 <20150507125053.5d2e8f0a@thinkpad-w530>
 <20150507111231.GF23123@twins.programming.kicks-ass.net>
 <20150507134030.137deeb2@thinkpad-w530>
 <20150507115118.GT21418@twins.programming.kicks-ass.net>
 <20150507141439.160cb979@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41451 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbEGMch (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 08:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20150507141439.160cb979@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Thu, May 07, 2015 at 02:14:39PM +0200, David Hildenbrand wrote:
> Thanks :), well just to make sure I got your opinion on this correctly:
> 
> 1. You think that 2 counters is the way to go for now

ack

> 2. You agree that we can't replace preempt_disable()+pagefault_disable() with
> preempt_disable() (CONFIG_PREEMPT stuff), so we need to have them separately

ack

> 3. We need in_atomic() (in the fault handlers only!) in addition to make sure we
> don't mess with irq contexts (In that case I would add a good comment to that
> place, describing why preempt_disable() won't help)

ack

> I think this is the right way to go because:
> 
> a) This way we don't have to modify preempt_disable() logic (including
> PREEMPT_COUNT).
> 
> b) There are not that many users relying on
> preempt_disable()+pagefault_disable()  (compared to pure preempt_disable() or
> pagefault_disable() users), so the performance overhead of two cache lines
> should be small. Users only making use of one of them should see no difference
> in performance.

indeed.

> c) We correctly decouple preemption and pagefault logic. Therefore we can now
> preempt when pagefaults are disabled, which feels right.

Right, that's always been the intent of introducing pagefault_disable().
