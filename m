From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 14:12:58 -0700
Message-ID: <20150312211258.GX5412@linux.vnet.ibm.com>
References: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
 <1243872207.287578.1426193760572.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:43055 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbbCLVND (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2015 17:13:03 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 12 Mar 2015 15:13:03 -0600
Content-Disposition: inline
In-Reply-To: <1243872207.287578.1426193760572.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Sullivan <sully@msully.net>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org

On Thu, Mar 12, 2015 at 08:56:00PM +0000, Mathieu Desnoyers wrote:
> (sorry for re-send, my mail client tricked me into posting HTML
> to lkml)
> 
> Hi, 
> 
> Michael Sullivan proposed a clever hack abusing mprotect() to 
> perform the same effect as sys_membarrier() I submitted a few 
> years ago ( https://lkml.org/lkml/2010/4/18/15 ). 
> 
> At that time, the sys_membarrier implementation was deemed 
> technically sound, but there were not enough users of the system call 
> to justify its inclusion. 
> 
> So far, the number of users of liburcu has increased, but liburcu 
> still appears to be the only direct user of sys_membarrier. On this 
> front, we could argue that many other system calls have only 
> one user: glibc. In that respect, liburcu is quite similar to glibc. 
> 
> So the question as it stands appears to be: would you be comfortable 
> having users abuse mprotect(), relying on its side-effect of issuing 
> a smp_mb() on each targeted CPU for the TLB shootdown, as 
> an effective implementation of process-wide memory barrier ? 
> 
> Thoughts ? 

Are there any architectures left that use hardware-assisted global
TLB invalidation?  On such an architecture, you might not get a memory
barrier except on the CPU executing the mprotect() or munmap().

(Here is hoping that no one does -- it is a cute abuse^Whack otherwise!)

							Thanx, Paul

> Thanks! 
> 
> Mathieu 
> 
> 
> 
> 
> 
> From: "Michael Sullivan" <sully@msully.net> 
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com> 
> Cc: lttng-dev@lists.lttng.org 
> Sent: Thursday, March 12, 2015 12:04:07 PM 
> Subject: Re: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu 
> 
> On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoyers < mathieu.desnoyers@efficios.com > wrote: 
> 
> 
> 
> 
> Even though it depends on internal behavior not currently specified by mprotect, 
> I'd very much like to see the prototype you have, 
> 
> 
> I ended up posting my code at https://github.com/msullivan/userspace-rcu/tree/msync-barrier . 
> The interesting patch is https://github.com/msullivan/userspace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0 . 
> 
> Quick blog post I wrote about it at http://www.msully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotect2/ . 
> (I talked briefly about sys_membarrier in the post as best as I could piece together from LKML; if my comment on it is inaccurate I can edit the post.) 
> 
> -Michael Sullivan 
> 
> 
> 
> -- 
> Mathieu Desnoyers 
> EfficiOS Inc. 
> http://www.efficios.com 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
