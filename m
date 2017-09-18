From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Mon, 18 Sep 2017 15:04:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709181458420.1806-100000@iolanthe.rowland.org>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51276 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750781AbdIRTEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2017 15:04:22 -0400
In-Reply-To: <20170917223608.GA14577@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mathieu.desnoyers@efficios.com, will.deacon@arm.com, luto@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davejwatson@fb.com, maged.michael@gmail.com

On Sun, 17 Sep 2017, Paul E. McKenney wrote:

> Hello!
> 
> Rough notes from our discussion last Thursday.  Please reply to the
> group with any needed elaborations or corrections.
> 
> Adding Andy and Michael on CC since this most closely affects their
> architectures.  Also adding Dave Watson and Maged Michael because
> the preferred approach requires that processes wanting to use the
> lightweight sys_membarrier() do a registration step.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> Problem:
> 
> 1.	The current sys_membarrier() introduces an smp_mb() that
> 	is not otherwise required on powerpc.
> 
> 2.	The envisioned JIT variant of sys_membarrier() assumes that
> 	the return-to-user instruction sequence handling any change
> 	to the usermode instruction stream, and Andy Lutomirski's
> 	upcoming changes invalidate this assumption.  It is believed
> 	that powerpc has a similar issue.

> E.	Require that threads register before using sys_membarrier() for
> 	private or JIT usage.  (The historical implementation using
> 	synchronize_sched() would continue to -not- require registration,
> 	both for compatibility and because there is no need to do so.)
> 
> 	For x86 and powerpc, this registration would set a TIF flag
> 	on all of the current process's threads.  This flag would be
> 	inherited by any later thread creation within that process, and
> 	would be cleared by fork() and exec().	When this TIF flag is set,

Why a TIF flag, and why clear it during fork()?  If a process registers
to use private expedited sys_membarrier, shouldn't that apply to
threads it will create in the future just as much as to threads it has
already created?

> 	the return-to-user path would execute additional code that would
> 	ensure that ordering and newly JITed code was handled correctly.
> 	We believe that checks for these TIF flags could be combined with
> 	existing checks to avoid adding any overhead in the common case
> 	where the process was not using these sys_membarrier() features.
> 
> 	For all other architecture, the registration step would be
> 	a no-op.

Don't we want to fail private expedited sys_membarrier calls if the 
process hasn't registered for them?  This requires the registration 
call to set a flag for the process, even on architectures where no 
additional memory barriers are actually needed.  It can't be a no-op.

Alan Stern
