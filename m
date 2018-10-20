Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbeJUAVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Oct 2018 20:21:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KGA1rK113061
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 12:10:57 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n80hbc16v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 12:10:56 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 12:10:55 -0400
Date: Sat, 20 Oct 2018 09:10:49 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20181020161049.GA13756@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: davidtgoldblatt@gmail.com, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Message-ID: <20181020161049.Ob7FaAdiFFBIMOoqKd9M380tKM_TMUaTpKnKjYRJyp8@z>

Hello!

David Goldblatt (CCed) came up with an interesting pair of C++ litmus
tests involving POSIX signals that have Linux-kernel counterparts
involving interrupts.  These litmus tests can (in paranoid theory, anyway)
produce counter-intuitive results on architectures that use explicit
fences to enforce ordering as part of a larger primitive, which in the
specific case of smp_store_release() includes all architectures other than
arm64, ia64, s390, SPARC, x86, and of course any UP-only architecture.

David's first litmus test made use of the C11 sequentially consistent
store, which in the Linux kernel would require two separate statements
anyway (a WRITE_ONCE() either preceded or followed by smp_mb()), so
the outcome that is counter-intuitive in C11 should be expected in the
Linux kernel.  (Yes, there are similar but more complicated examples that
would have more interesting outcomes in the Linux kernel, but let's keep
it simple for the moment.)

The second (informal) litmus test has a more interesting Linux-kernel
counterpart:

	void t1_interrupt(void)
	{
		r0 = READ_ONCE(y);
		smp_store_release(&x, 1);
	}

	void t1(void)
	{
		smp_store_release(&y, 1);
	}

	void t2(void)
	{
		r1 = smp_load_acquire(&x);
		r2 = smp_load_acquire(&y);
	}

On store-reordering architectures that implement smp_store_release()
as a memory-barrier instruction followed by a store, the interrupt could
arrive betweentimes in t1(), so that there would be no ordering between
t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.

In practice, we analyzed exception paths in the sys_membarrier() review,
and ended up with this function:

static void ipi_mb(void *info)
{
	smp_mb();	/* IPIs should be serializing but paranoid. */
}

So how paranoid should we be with respect to interrupt handlers for
smp_store_release(), smp_load_acquire(), and the various RMW atomic
operations that are sometimes implemented with separate memory-barrier
instructions?  ;-)

							Thanx, Paul
