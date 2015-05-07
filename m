Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54809 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbbEGLv4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 07:51:56 -0400
Date: Thu, 7 May 2015 13:51:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Message-ID: <20150507115118.GT21418@twins.programming.kicks-ass.net>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
 <20150507102254.GE23123@twins.programming.kicks-ass.net>
 <20150507125053.5d2e8f0a@thinkpad-w530>
 <20150507111231.GF23123@twins.programming.kicks-ass.net>
 <20150507134030.137deeb2@thinkpad-w530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150507134030.137deeb2@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150507115118.h4alAPmFeJkL6xNDEi0XncpOyOOoeQxoCuWT-jXRzWg@z>

On Thu, May 07, 2015 at 01:40:30PM +0200, David Hildenbrand wrote:
> But anyhow, opinions seem to differ how to best handle that whole stuff.
> 
> I think a separate counter just makes sense, as we are dealing with two
> different concepts and we don't want to lose the preempt_disable =^ NOP
> for !CONFIG_PREEMPT.
> 
> I also think that
> 
> pagefault_disable()
> rt = copy_from_user()
> pagefault_enable()
> 
> is a valid use case.
> 
> So any suggestions how to continue?


static inline bool __pagefault_disabled(void)
{
	return current->pagefault_disabled;
}

static inline bool pagefault_disabled(void)
{
	return in_atomic() || __pagefault_disabled();
}

And leave the preempt_disable() + pagefault_disable() for now. You're
right in that that is clearest.

If we ever get to the point where that really is an issue, I'll try and
be clever then :-)
