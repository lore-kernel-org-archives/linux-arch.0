Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbeJUFQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Oct 2018 01:16:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KL3o3N066746
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 17:04:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n80wh1uc4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 17:04:18 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 17:04:17 -0400
Date: Sat, 20 Oct 2018 14:04:13 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
References: <20181020161049.GA13756@linux.ibm.com>
 <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
Message-ID: <20181020210413.GB2674@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Message-ID: <20181020210413.kx2BdGg8GF7v0C6RIw1TTKWXuTiJcegRiecWVmrJUGM@z>

On Sat, Oct 20, 2018 at 04:18:37PM -0400, Alan Stern wrote:
> On Sat, 20 Oct 2018, Paul E. McKenney wrote:
> 
> > The second (informal) litmus test has a more interesting Linux-kernel
> > counterpart:
> > 
> > 	void t1_interrupt(void)
> > 	{
> > 		r0 = READ_ONCE(y);
> > 		smp_store_release(&x, 1);
> > 	}
> > 
> > 	void t1(void)
> > 	{
> > 		smp_store_release(&y, 1);
> > 	}
> > 
> > 	void t2(void)
> > 	{
> > 		r1 = smp_load_acquire(&x);
> > 		r2 = smp_load_acquire(&y);
> > 	}
> > 
> > On store-reordering architectures that implement smp_store_release()
> > as a memory-barrier instruction followed by a store, the interrupt could
> > arrive betweentimes in t1(), so that there would be no ordering between
> > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
> 
> This is disconcerting only if we assume that t1_interrupt() has to be
> executed by the same CPU as t1().  If the interrupt could be fielded by
> a different CPU then the paranoid outcome is perfectly understandable,
> even in an SC context.
> 
> So the question really should be limited to situations where a handler 
> is forced to execute in the context of a particular thread.  While 
> POSIX does allow such restrictions for user programs, I'm not aware of 
> any similar mechanism in the kernel.

Good point, and I was in fact assuming that t1() and t1_interrupt()
were executing on the same CPU.

This sort of thing happens naturally in the kernel when both t1()
and t1_interrupt() are accessing per-CPU variables.

							Thanx, Paul
