From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Mon, 18 Sep 2017 19:37:22 +0000 (UTC)
Message-ID: <1385244147.12696.1505763442841.JavaMail.zimbra@efficios.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1709181458420.1806-100000@iolanthe.rowland.org> <20170918192935.GW3521@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:48775 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdIRTgg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2017 15:36:36 -0400
In-Reply-To: <20170918192935.GW3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

----- On Sep 18, 2017, at 3:29 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:

> On Mon, Sep 18, 2017 at 03:04:21PM -0400, Alan Stern wrote:
>> On Sun, 17 Sep 2017, Paul E. McKenney wrote:
>> 
>> > Hello!
>> > 
>> > Rough notes from our discussion last Thursday.  Please reply to the
>> > group with any needed elaborations or corrections.
>> > 
>> > Adding Andy and Michael on CC since this most closely affects their
>> > architectures.  Also adding Dave Watson and Maged Michael because
>> > the preferred approach requires that processes wanting to use the
>> > lightweight sys_membarrier() do a registration step.
>> > 
>> > 							Thanx, Paul
>> > 
>> > ------------------------------------------------------------------------
>> > 
>> > Problem:
>> > 
>> > 1.	The current sys_membarrier() introduces an smp_mb() that
>> > 	is not otherwise required on powerpc.
>> > 
>> > 2.	The envisioned JIT variant of sys_membarrier() assumes that
>> > 	the return-to-user instruction sequence handling any change
>> > 	to the usermode instruction stream, and Andy Lutomirski's
>> > 	upcoming changes invalidate this assumption.  It is believed
>> > 	that powerpc has a similar issue.
>> 
>> > E.	Require that threads register before using sys_membarrier() for
>> > 	private or JIT usage.  (The historical implementation using
>> > 	synchronize_sched() would continue to -not- require registration,
>> > 	both for compatibility and because there is no need to do so.)
>> > 
>> > 	For x86 and powerpc, this registration would set a TIF flag
>> > 	on all of the current process's threads.  This flag would be
>> > 	inherited by any later thread creation within that process, and
>> > 	would be cleared by fork() and exec().	When this TIF flag is set,
>> 
>> Why a TIF flag, and why clear it during fork()?  If a process registers
>> to use private expedited sys_membarrier, shouldn't that apply to
>> threads it will create in the future just as much as to threads it has
>> already created?
> 
> The reason for a TIF flag is to keep this per-architecture, as only
> powerpc and x86 need it.
> 
> The reason for clearing it during fork() is that fork() creates a new
> process initially having but a single thread, which might or might
> not use sys_membarrier().  Usually not, as most instances of fork()
> are quickly followed by exec().  In addition, if we give an error for
> unregistered use of private sys_membarrier(), clearing on fork() gets an
> unambiguous error instead of a silent likely failure (due to libraries
> being confused by the fork()).

I think clearing that state on fork() would be unexpected. The child process
inherits from the parent flag in my current implementation. Clearing the
flag is only provided through exec().

Libraries don't get re-initialized on fork, only on exec(). Therefore, it
makes sense for the child process to inherit the state from its parent.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
