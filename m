Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42F21526.90700@yahoo.com.au>
Date: Thu, 04 Aug 2005 23:16:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [patch] make spin_lock_prefetch a noop for UP
References: <42F212F4.5020609@yahoo.com.au> <20050804131037.GC9112@wotan.suse.de>
In-Reply-To: <20050804131037.GC9112@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 11:07:00PM +1000, Nick Piggin wrote:
> 
>>Is this any good?
>>
>>The counter argument would be that one might prefetch a
>>spinlock in the head of a data structure, and expect
>>the rest of the cacheline to be in cache as well. Though
>>in that case, maybe prefetch/prefetchw should be used
>>instead.
> 
> 
> Can you describe what the supposed improvement of the patch is? 
> 

 From include/linux/prefetch.h:

"spin_lock_prefetch(x) - prefectches the spinlock *x for taking"

So this would reduce icache footprint and possibly memory
traffic on UP where taking a spinlock is a noop.

Granted, there aren't many users of spin_lock_prefetch at the
moment.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
