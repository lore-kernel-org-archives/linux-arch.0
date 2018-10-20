Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbeJUFSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Oct 2018 01:18:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KL3pwA015829
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 17:06:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n7w8sg74j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 20 Oct 2018 17:06:52 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 17:06:51 -0400
Date: Sat, 20 Oct 2018 14:06:46 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
References: <20181020161049.GA13756@linux.ibm.com>
 <20181020202229.GA10526@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020202229.GA10526@andrea>
Message-ID: <20181020210646.GC2674@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Message-ID: <20181020210646.c34z5l7Lkelge8h88tvIA98B_qKaoDs1GLpDeZ01qVA@z>

On Sat, Oct 20, 2018 at 10:22:29PM +0200, Andrea Parri wrote:
> [...]
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
> FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
> but I admit that I've only run this test in *my mind*: in an SC world,
> 
>   CPU1				CPU2
> 
>   t1()
>     t1_interrupt()
>       r0 = READ_ONCE(y); // =0
> 				t2()
> 				  r1 = smp_load_acquire(&x); // =0
>       smp_store_release(&x, 1);
>     smp_store_release(&y, 1);
> 				  r2 = smp_load_acquire(&y); // =1

OK, so did I get the outcome messed up again?  :-/

							Thanx, Paul

> > So how paranoid should we be with respect to interrupt handlers for
> > smp_store_release(), smp_load_acquire(), and the various RMW atomic
> > operations that are sometimes implemented with separate memory-barrier
> > instructions?  ;-)
> 
> Good question! ;-)
> 
>   Andrea
> 
> 
> > 
> > 							Thanx, Paul
> > 
> 
