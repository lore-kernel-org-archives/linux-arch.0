From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Mon, 9 Feb 2015 15:42:17 +0100
Message-ID: <20150209144217.GT5029@twins.programming.kicks-ass.net>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20150112151911.4a51f09d@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53374 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbbBIOm0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Feb 2015 09:42:26 -0500
Content-Disposition: inline
In-Reply-To: <20150112151911.4a51f09d@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz

On Mon, Jan 12, 2015 at 03:19:11PM +0100, David Hildenbrand wrote:
> Thomas, Peter,
> 
> anything that speaks against putting the pagefault_disable counter into
> thread_info (my series) instead of task_struct (rt tree)?
> 
> IOW, what would be the right place for it?

I think we put it in task_struct because lazy; ARM seems one of the few
popular archs where current still goes through thread_info.

And that I think is the only reason to maybe use thread_info, cost of
access. The down-side of using thread_info is of course that it reduces
stack size.

In any case; I think that if you want to go do this; please consider the
route -rt took and completely separate the two, don't leave the
preempt_count_{inc,dec} remnant in pagefault_{en,dis}able() at all.
