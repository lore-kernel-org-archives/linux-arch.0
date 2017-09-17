From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Rough notes from sys_membarrier() lightning BoF
Date: Sun, 17 Sep 2017 15:36:08 -0700
Message-ID: <20170917223608.GA14577@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751876AbdIQWgO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Sep 2017 18:36:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8HMXhW6104439
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2017 18:36:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d1r16a5w4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2017 18:36:13 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 17 Sep 2017 18:36:13 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mathieu.desnoyers@efficios.com, will.deacon@arm.com, stern@rowland.harvard.edu
Cc: luto@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davejwatson@fb.com, maged.michael@gmail.com

Hello!

Rough notes from our discussion last Thursday.  Please reply to the
group with any needed elaborations or corrections.

Adding Andy and Michael on CC since this most closely affects their
architectures.  Also adding Dave Watson and Maged Michael because
the preferred approach requires that processes wanting to use the
lightweight sys_membarrier() do a registration step.

							Thanx, Paul

------------------------------------------------------------------------

Problem:

1.	The current sys_membarrier() introduces an smp_mb() that
	is not otherwise required on powerpc.

2.	The envisioned JIT variant of sys_membarrier() assumes that
	the return-to-user instruction sequence handling any change
	to the usermode instruction stream, and Andy Lutomirski's
	upcoming changes invalidate this assumption.  It is believed
	that powerpc has a similar issue.


Here are diagrams indicating the memory-ordering requirements:

Scenario 1:  Access preceding sys_membarrier() must see changes
	from thread that concurrently switches in.

	----------------------------------------------------------------

	Scheduler			sys_membarrier()
	---------			----------------

	smp_mb();

					usermode load or store to Y

					/* begin system call */

					sys_membarrier()
					  smp_mb();
					  Check rq->curr

	rq->curr = new_thread;
	smp_mb(); /* not powerpc! */

	/* return to user */

	usermode load or store to X

					  smp_mb();

	----------------------------------------------------------------

	Due to the fr link from the check of rq->curr to the scheduler's
	write, we need full memory barriers on both sides.  However,
	we don't want to lose the powerpc optimization, at least not in
	the common case.


Scenario 2:  Access following sys_membarrier() must see changes
	from thread that concurrently switches out.

	----------------------------------------------------------------

	Scheduler			sys_membarrier()
	---------			----------------

					/* begin system call */

					sys_membarrier()
					  smp_mb();

	usermode load or store to X

	/* Schedule from user */

	smp_mb();
	rq->curr = new_thread;

					  Check rq->curr
					  smp_mb();

	smp_mb(); /* not powerpc! */

					/* return to user */

					usermode load or store to Y

	----------------------------------------------------------------

	Here less ordering is required, given that a read is returning
	the value previously written.  Weaker barriers could be used,
	but full memory barriers are in place in any case.


Potential resolutions, including known stupid ones:

A.	IPI all CPUs all the time.  Not so good for real-time workloads,
	and a usermode-induced set of IPIs could potentially be used for
	a denial-of-service (DoS) attack.

B.	Lock all runqueues all the time.  This could potentially also be
	used in a usermode-induced DoS attack.

C.	Explicitly interact with all threads rather than with CPUs.
	This can be quite expensive for the surprisingly common case
	where applications have very large numbers of thread.  (Java,
	we are looking at you!!!)

D.	Just keep the redundant smp_mb() and just say "no" to Andy's
	x86 optimizations.  We would like to avoid the performance
	degradation in both cases.

E.	Require that threads register before using sys_membarrier() for
	private or JIT usage.  (The historical implementation using
	synchronize_sched() would continue to -not- require registration,
	both for compatibility and because there is no need to do so.)

	For x86 and powerpc, this registration would set a TIF flag
	on all of the current process's threads.  This flag would be
	inherited by any later thread creation within that process, and
	would be cleared by fork() and exec().	When this TIF flag is set,
	the return-to-user path would execute additional code that would
	ensure that ordering and newly JITed code was handled correctly.
	We believe that checks for these TIF flags could be combined with
	existing checks to avoid adding any overhead in the common case
	where the process was not using these sys_membarrier() features.

	For all other architecture, the registration step would be
	a no-op.

Does anyone have any better solution?  If so, please don't keep it
a secret!

							Thanx, Paul
