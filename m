From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 13:47:23 -0700
Message-ID: <4BB3B4DB.7040904@kernel.org>
References: <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100331134048.da4e35a7.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, hpa@zytor.com, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/31/2010 01:40 PM, Andrew Morton wrote:
> On Fri, 26 Mar 2010 01:11:00 +0530
> Rabin Vincent <rabin@rab.in> wrote:
> 
>> > On latest git, I'm seeing "start_kernel(): bug: interrupts were enabled
>> > early" messages on ARM (sample log below).
>> > 
>> > This appears to be caused by:
>> > 
>> >   start_kernel -> radix_tree_init -> kmem_cache_create (slub) ->
>> >    down_write -> __down_write (lib/rwsem-spinlock.c) -> spin_unlock_irq
>> > 
>> > radix_tree_init was moved earlier by:
>> > 
>> >   commit 773e3eb7b81e5ba13b5155dfb3bb75b8ce37f8f9
>> >   Author: Yinghai Lu <yinghai@kernel.org>
>> >   Date:   Wed Feb 10 01:20:33 2010 -0800
>> > 
>> >       init: Move radix_tree_init() early
>> > 
>> >       Prepare for using radix trees in early_irq_init().
>> > 
>> >       Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> >       LKML-Reference: <1265793639-15071-30-git-send-email-yinghai@kernel.org>
>> >       Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>> > 
> That's going to be hard to fix.
> 
> Once upon a time, enabling interrupts too early in boot would kill
> powerpc boxes stone dead.  From the lack of noise I assume that this is
> not happening in current kernels for some reason.
> 
> We have two checks in start_kernel():
> 
> 	if (!irqs_disabled()) {
> 		printk(KERN_WARNING "start_kernel(): bug: interrupts were "
> 				"enabled *very* early, fixing it\n");
> 		local_irq_disable();
> 	}
> 	rcu_init();
> 	radix_tree_init();
> 	/* init some links before init_ISA_irqs() */
> 	early_irq_init();
> 	init_IRQ();
> 	prio_tree_init();
> 	init_timers();
> 	hrtimers_init();
> 	softirq_init();
> 	timekeeping_init();
> 	time_init();
> 	profile_init();
> 	if (!irqs_disabled())
> 		printk(KERN_CRIT "start_kernel(): bug: interrupts were "
> 				 "enabled early\n");
> 
> perhaps the second one isn't needed?  Perhaps no architecture requires
> that local interrupts be disabled across the above initialisations?
	
spin_unlock_irq from arm is different from other archs?

YH
