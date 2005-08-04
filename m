Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 4 Aug 2005 15:25:39 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] make spin_lock_prefetch a noop for UP
Message-ID: <20050804132539.GU8266@wotan.suse.de>
References: <42F212F4.5020609@yahoo.com.au> <20050804131037.GC9112@wotan.suse.de> <42F21526.90700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F21526.90700@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

> From include/linux/prefetch.h:
> 
> "spin_lock_prefetch(x) - prefectches the spinlock *x for taking"
> 
> So this would reduce icache footprint and possibly memory
> traffic on UP where taking a spinlock is a noop.

Ah you want to disable it on UP? 
Ok that makes more sense. Why didn't you just say that? :)

Anyways, even on UP it might be useful on all these mutex or whatever
lock is envogue these days preemptive kernels.

-Andi
