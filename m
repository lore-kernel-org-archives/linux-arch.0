From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC 1/2] qrwlock: A queue read/write lock implementation
Date: Thu, 18 Jul 2013 09:43:54 -0400
Message-ID: <51E7F11A.2040301@hp.com>
References: <20130718125501.2620.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:6510 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3GRNvj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2013 09:51:39 -0400
In-Reply-To: <20130718125501.2620.qmail@science.horizon.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: George Spelvin <linux@horizon.com>
Cc: JBeulich@novell.com, linix-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 07/18/2013 08:55 AM, George Spelvin wrote:
> In the interest of more useful Kconfig help, could I recommend the
> following text:
>
> config QUEUE_RWLOCK
> 	bool "Generic queue read/write lock"
> 	depends on ARCH_QUEUE_RWLOCK
> 	help
> 	  Use an alternative reader-writer lock (rwlock) implementation,
> 	  optimized for larger NUMA systems.  These locks use more memory,
> 	  but perform better under high contention.  (Specifically, readers
> 	  waiting for a writer to release the lock will be queued rather
> 	  than all spinning on the same cache line.)
>
> 	  The kernel will operate correctly either way; this only
> 	  affects performance.
>
> 	  For common desktop and server systems systems with only one
> 	  or two CPU sockets, the performance benefits are not worth
> 	  the additional memory; say N here.
>
> My goal is to give someone stumbling across this question for the first
> time in "make oldconfig" the information htey need to answer it.

Thank for the revision, I will make such a change in the next version of 
my patch.

> That said, I think Ingo's idea for simplfying the waiting reader side
> is excellent and should be tried before bifurcating the implementation.
>
> Looking at the lock system, it *seems* like that patch to __read_lock_failed
> is literally the *only* thing that needs changing, since the write
> lock/unlock is all done with relative add/sub anyway.  But I keep thinking
> "there must have been a reason why it wasn't done that way in the first
> place".

As I said in my response to Ingo, that change will make the lock more 
unfair to the writers. However, I can run some tests to find out the 
performance impact of such a way on the benchmarks that I used.

Regards,
Longman
