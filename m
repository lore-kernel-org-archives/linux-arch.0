Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728418AbeIFXLJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 19:11:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86ISrs1086936
        for <linux-arch@vger.kernel.org>; Thu, 6 Sep 2018 14:34:25 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb6bu18ya-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 06 Sep 2018 14:34:25 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 14:34:24 -0400
Date: Thu, 6 Sep 2018 11:34:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM
 limitations
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
 <20180830091713.GA4617@andrea>
 <20180830221814.GQ4225@linux.vnet.ibm.com>
 <20180831094341.GA4634@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831094341.GA4634@andrea>
Message-ID: <20180906183417.GA4225@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180906183417.TZVPA56izxUQodquMqln_Bfcj26WoupZMtbx8bmTy8I@z>

On Fri, Aug 31, 2018 at 11:43:42AM +0200, Andrea Parri wrote:
> > > > +	b.	The "unless" RMW operations are not currently modeled:
> > > > +		atomic_long_add_unless(), atomic_add_unless(),
> > > > +		atomic_inc_unless_negative(), and
> > > > +		atomic_dec_unless_positive().  These can be emulated
> > > > +		in litmus tests, for example, by using atomic_cmpxchg().
> > > 
> > > There is a prototype atomic_add_unless(): with current herd7,
> > > 
> > > $ cat atomic_add_unless.litmus
> > > C atomic_add_unless
> > > 
> > > {}
> > > 
> > > P0(atomic_t *u, atomic_t *v)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 
> > > 	r0 = atomic_add_unless(u, 1, 2);
> > > 	r1 = atomic_read(v);
> > > }
> > > 
> > > P1(atomic_t *u, atomic_t *v)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 
> > > 	r0 = atomic_add_unless(v, 1, 2);
> > > 	r1 = atomic_read(u);
> > > }
> > > 
> > > exists (0:r1=0 /\ 1:r1=0)
> > > 
> > > $ herd7 -conf linux-kernel.cfg atomic_add_unless.litmus
> > > Test atomic_add_unless Allowed
> > > States 3
> > > 0:r1=0; 1:r1=1;
> > > 0:r1=1; 1:r1=0;
> > > 0:r1=1; 1:r1=1;
> > > No
> > > Witnesses
> > > Positive: 0 Negative: 3
> > > Condition exists (0:r1=0 /\ 1:r1=0)
> > > Observation atomic_add_unless Never 0 3
> > > Time atomic_add_unless 0.00
> > > Hash=fa37a2359831690299e4cc394e45d966
> > > 
> > > The last commit in the herdtools7 repo. related to this implementation
> > > (AFAICT) is:
> > > 
> > >   9523c340917b6a ("herd/linux: make atomic_add_unless a primitive, so as to yield more precise dependencies for the returned boolean.")
> > > 
> > > but I can only vaguely remember those dependencies issues now :/  ...;
> > > maybe we can now solve these issues?  or should we change herd7 to re-
> > > turn a warning?  (Notice that this primitive is currently not exported
> > > to the linux-kernel.def file.)
> > 
> > Cool!  It would be good to add this to the .def file once the underlying
> > herd7 machinery is ready.  And then I would update the documentation
> > accordingly.  Or happily accept a patch updating the documentation,
> > as the case might be.  ;-)
> 
> Fair enough, ;-)  Please feel free to add:
> 
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thank you!  Applied and pushed out, updating the lkmm branch in the
process.

							Thanx, Paul
