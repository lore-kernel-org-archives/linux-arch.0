From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Thu, 19 Feb 2015 15:48:05 +0100
Message-ID: <20150219154805.2651257d@thinkpad-w530>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
	<20150112151911.4a51f09d@thinkpad-w530>
	<20150209144217.GT5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:47671 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbbBSOsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Feb 2015 09:48:14 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 19 Feb 2015 14:48:12 -0000
In-Reply-To: <20150209144217.GT5029@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz

> On Mon, Jan 12, 2015 at 03:19:11PM +0100, David Hildenbrand wrote:
> > Thomas, Peter,
> > 
> > anything that speaks against putting the pagefault_disable counter into
> > thread_info (my series) instead of task_struct (rt tree)?
> > 
> > IOW, what would be the right place for it?
> 
> I think we put it in task_struct because lazy; ARM seems one of the few
> popular archs where current still goes through thread_info.
> 
> And that I think is the only reason to maybe use thread_info, cost of
> access. The down-side of using thread_info is of course that it reduces
> stack size.
> 
> In any case; I think that if you want to go do this; please consider the
> route -rt took and completely separate the two, don't leave the
> preempt_count_{inc,dec} remnant in pagefault_{en,dis}able() at all.
> 
> 

Thanks Peter,

I am currently preparing/testing a series that does the requested separation
(getting rid of preempt_count_{inc,dec} ...) while putting the pagefault disable
count into task_info.

Downside is that now that I have to touch all fault handlers, I have to go
through all archs again.

Think I'll have something to show in a couple of days.

David
