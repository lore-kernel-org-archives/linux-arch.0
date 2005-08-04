Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42F21A05.1050102@yahoo.com.au>
Date: Thu, 04 Aug 2005 23:37:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [patch] make spin_lock_prefetch a noop for UP
References: <42F212F4.5020609@yahoo.com.au> <20050804131037.GC9112@wotan.suse.de> <42F21526.90700@yahoo.com.au> <20050804132539.GU8266@wotan.suse.de>
In-Reply-To: <20050804132539.GU8266@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
>>From include/linux/prefetch.h:
>>
>>"spin_lock_prefetch(x) - prefectches the spinlock *x for taking"
>>
>>So this would reduce icache footprint and possibly memory
>>traffic on UP where taking a spinlock is a noop.
> 
> 
> Ah you want to disable it on UP? 
> Ok that makes more sense. Why didn't you just say that? :)
> 

Well I did, in a confusing kind of way ;) ... with the alternative
input stuff being used here, "noop" becomes ambiguous I guess.

> Anyways, even on UP it might be useful on all these mutex or whatever
> lock is envogue these days preemptive kernels.
> 

I'm sure it would be useful. Though it is something that could be
maintained out of tree.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
