From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 21:00:01 +0200
Message-ID: <1212174001.24826.37.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins>
	 <Pine.LNX.4.64.0805301106360.14564@schroedinger.engr.sgi.com>
	 <1212172742.24826.19.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805301141260.16184@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:55939 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYE3TBL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 15:01:11 -0400
In-Reply-To: <Pine.LNX.4.64.0805301141260.16184@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 11:51 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Peter Zijlstra wrote:
> 
> > For -rt add the spinlock and thereby guarantee mutual exclusion in the
> > face of preemption. This of course does mean reduced performance due to
> > remote cpu memory accesses, but otherwise the allocator (slub in this
> > case) would have far too large preempt-off sections.
> 
> Hmmm.. So you want to lock and then be migrated while still accessing per 
> cpu data of the earlier cpu? That breaks a lot of assumptions in the main 
> kernel and would make cpu ops and local_t etc impossible because these 
> rely on atomicity vs. interrupt vs atomicity vs access from other cpus. If 
> you modify the per cpu data of one processor from multiple processor 
> concurrently then races will result.

Interrupts are not an issue on -rt.

Also, all sites that have but a single word of percpu data can just use
a real atomic update.

All other sites should be converted to a locked version.

We also have DEFINE_PER_CPU_LOCKED() which has a similar get/put
interface as I was asking for - it uses preempt-off for !rt and a lock
for -rt.

> If you want to do it that way then local_t and cpu_ops would not work.
> 
> The cpu ops scheme is to not rely on any locking and still guarantee 
> access to the correct per cpu area regardless of whether the process is 
> rescheduled or not simply by the fact that the per cpu address calculation 
> and the RMW cycle are one instruction.
> 
> Maybe we need to have different types of per cpu areas for both 
> approaches? Your requires a spinlock to be taken for a section of the 
> percpu space.

For -rt we'd need to make the CPU_ops true atomic operations, with that
all the single word stuff works again.

All the multi word stuff (that currently requires preempt-off) must be
converted to a locked version.
