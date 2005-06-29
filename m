Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C26552.5020304@yahoo.com.au>
Date: Wed, 29 Jun 2005 19:09:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Remaining arch problems in cpu_idle
References: <42C24874.8030702@yahoo.com.au> <20050629080058.GA2694@linux-sh.org>
In-Reply-To: <20050629080058.GA2694@linux-sh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Paul Mundt wrote:
> On Wed, Jun 29, 2005 at 05:06:28PM +1000, Nick Piggin wrote:
> 
>>h8300, ia64, and sh64 still have possible outstanding issues,
>>which I've put at the end of the Documentation/ file. It
>>would be nice to get these looked at.
>>
> 
> Looking at this, sh64 is pretty much in the same category as h8300. sh
> is as well, but we seem to be missing the local_irq_disable/enable around
> the need_resched check there completely, which is even more bogus.
> 

Well you only need to disable IRQs if you are about to go to
sleep waiting for the next pending IRQ. So your hlt_counter
case looks OK.

In the case that you do sleep until the next IRQ, sh64 does indeed
disable irqs over the need_resched check, however it re-enables them
before sleeping. So disabling at all is basically useless because
any pending IRQs will probably all get serviced right as soon as IRQs
are re-eanbled.

>>+
>>+h8300 - Is such sleeping racy vs interrupts? (See #4a).
>>+        The H8/300 manual I found indicates yes, however disabling IRQs
>>+        over the sleep mean only NMIs can wake it up, so can't fix easily
>>+        without doing spin waiting.
>>+
> 
> We have the same problem for sh/sh64 (which isn't surprising, considering
> they all share ancestry).
> 
> There are several different states that can be entered, with different
> method for exiting, although at least the sleep and deep sleep states
> both require an interrupt, NMI, or a reset request.
> 
> I can update sh and sh64 to follow the h8300 change, but that still
> doesn't address the race. What sort of spin waiting do you have in mind?

Well as you probably know, but just to be clear: architectures
that handle this without a race have an instruction that basically
turns on interrupts and go to sleep at the same time. I'm not aware
of a simple way to do it without that facility.

Unless you can easily raise an NMI from another processor as an IPI.

As far as spin waiting goes, something like:

	while (!need_resched())
		cpu_relax();

Is generally used.

Now this might introduce some power and heat penalty. What's more,
your race isn't a fatal one: in the worst case, it should just
stall until the next timer interrupt (aside, that might be fatal
with a tickless kernel).

So you may want a bootup or runtime switchable parameter there to
choose between good power saving and optimal performance &
scheduling latency.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
