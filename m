Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934040AbeBURxI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 12:53:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LHnRaY014120
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 12:53:07 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9bcmef6v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 12:53:03 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 12:53:02 -0500
Date: Wed, 21 Feb 2018 09:53:21 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221161223.GE3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211148390.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211148390.2032-100000@iolanthe.rowland.org>
Message-Id: <20180221175320.GI3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, Feb 21, 2018 at 11:50:31AM -0500, Alan Stern wrote:
> On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> 
> > On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> > > On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> > > 
> > > > From: Alan Stern <stern@rowland.harvard.edu>
> > > > 
> > > > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > > > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > > 
> > > Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> > > description?
> > 
> > Indeed, the name of the test is in fact ISA2.
> 
> Sure; and the Changelog entry should reflect this.

No argument.

> > > > accesses with a full memory barrier but without the lock.  This litmus
> > > > test asks whether writes carried out by two different processes under the
> > > > same lock will be seen in order by a third process not holding that lock.
> > > > The answer to this question is "yes" for all architectures supporting
> > > > the Linux kernel, but is "no" according to the current version of LKMM.
> > > > 
> > > > A patch to LKMM is under development.
> > > > 
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > ---
> > > >  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++++++++
> > > >  1 file changed, 41 insertions(+)
> > > >  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > > 
> > > Aren't these tests supposed to be described in litmus-tests/README?
> 
> You apparently missed this recommendation.

I did, please accept my apologies and please see below.

> > > > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > > > new file mode 100644
> > > > index 000000000000..7a39a0aaa976
> > > > --- /dev/null
> > > > +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > > > @@ -0,0 +1,41 @@
> > > > +C ISA2+pooncelock+pooncelock+pombonce.litmus
> > > > +
> > > > +(*
> > > > + * Result: Sometimes
> > > > + *
> > > > + * This test shows that the ordering provided by a lock-protected S
> > > > + * litmus test (P0() and P1()) are not visible to external process P2().
> > > > + * This is likely to change soon.
> > > 
> > > That last line may be premature.  We haven't reached any consensus on 
> > > how RISC-V will handle this.  If RISC-V allows the test then the memory 
> > > model can't forbid it.
> > 
> > Agreed.  How about this?  If the RISC-V question is answered by the
> > end of next week, I update accordingly.  If not, I update the comment
> > to give the details.
> 
> The README also should be updated.

Agreed.

> > Hey, at least having the memory model go in at about the same time as
> > a new architecture is giving us good practice!  ;-)
> 
> Hopefully things will settle down in a week or two.

Here is hoping!

							Thanx, Paul

------------------------------------------------------------------------

commit e6658d1d7fcc6391f3d00beaadc484243123a893
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Feb 21 09:49:01 2018 -0800

    tools/memory-order: Add documentation of new litmus test
    
    The litmus-tests/README file lacked any mention of then litmus test
    named ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
    adds this test.
    
    Reported-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index dca7d823ad57..aff3eb90e067 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -32,6 +32,11 @@ IRIW+poonceonces+OnceOnce.litmus
 	order of a pair of writes, where each write is to a different
 	variable by a different process?
 
+ISA2+pooncelock+pooncelock+pombonce.litmus
+	Tests whether the ordering provided by a lock-protected S litmus
+	test is visible to an external process whose accesses are
+	separated by smp_mb().
+
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
