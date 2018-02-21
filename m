Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753053AbeBUTF0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 14:05:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LJ53XA079743
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 14:05:25 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cg25jtp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 14:05:25 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 14:05:24 -0500
Date: Wed, 21 Feb 2018 11:05:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221175320.GI3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211334560.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211334560.2032-100000@iolanthe.rowland.org>
Message-Id: <20180221190543.GM3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, Feb 21, 2018 at 01:38:35PM -0500, Alan Stern wrote:
> On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> 
> > On Wed, Feb 21, 2018 at 11:50:31AM -0500, Alan Stern wrote:
> > > On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> > > 
> > > > On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> > > > > On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> > > > > 
> > > > > > From: Alan Stern <stern@rowland.harvard.edu>
> > > > > > 
> > > > > > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > > > > > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > > > > 
> > > > > Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> > > > > description?
> > > > 
> > > > Indeed, the name of the test is in fact ISA2.
> > > 
> > > Sure; and the Changelog entry should reflect this.
> > 
> > No argument.
> 
> > ------------------------------------------------------------------------
> > 
> > commit e6658d1d7fcc6391f3d00beaadc484243123a893
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Wed Feb 21 09:49:01 2018 -0800
> > 
> >     tools/memory-order: Add documentation of new litmus test
> >     
> >     The litmus-tests/README file lacked any mention of then litmus test
> 
> s/lacked/lacks/
> s/then/the new/
> 
> >     named ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
> 
> s/named //
> 
> >     adds this test.
> 
> It adds a description of the test, not the test itself.

Good catches, fixed.

> >     Reported-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > index dca7d823ad57..aff3eb90e067 100644
> > --- a/tools/memory-model/litmus-tests/README
> > +++ b/tools/memory-model/litmus-tests/README
> > @@ -32,6 +32,11 @@ IRIW+poonceonces+OnceOnce.litmus
> >  	order of a pair of writes, where each write is to a different
> >  	variable by a different process?
> >  
> > +ISA2+pooncelock+pooncelock+pombonce.litmus
> > +	Tests whether the ordering provided by a lock-protected S litmus
> 
> Call it an ISA2 litmus test, not an S litmus test!

Given the structure of the test, the relationship to S is important
because it helps motivate why anyone might care.  But yes, having ISA2
only in the filename is a bit obtuse.  How about the following?

ISA2+pooncelock+pooncelock+pombonce.litmus
	Tests whether the ordering provided by a lock-protected S
	litmus test is visible to an external process whose accesses are
	separated by smp_mb().	This addition of an external process to
	S is otherwise known as ISA2.

							Thanx, Paul

> > +	test is visible to an external process whose accesses are
> > +	separated by smp_mb().
> > +
> >  ISA2+poonceonces.litmus
> >  	As below, but with store-release replaced with WRITE_ONCE()
> >  	and load-acquire replaced with READ_ONCE().
> 
> Alan
> 
