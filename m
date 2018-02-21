Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S938593AbeBUQMT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 11:12:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LGBtOx043313
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 11:12:18 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g9a9swtq7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 11:12:14 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 11:12:05 -0500
Date: Wed, 21 Feb 2018 08:12:23 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211001030.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211001030.2032-100000@iolanthe.rowland.org>
Message-Id: <20180221161223.GE3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> 
> Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> description?

Indeed, the name of the test is in fact ISA2.

> > accesses with a full memory barrier but without the lock.  This litmus
> > test asks whether writes carried out by two different processes under the
> > same lock will be seen in order by a third process not holding that lock.
> > The answer to this question is "yes" for all architectures supporting
> > the Linux kernel, but is "no" according to the current version of LKMM.
> > 
> > A patch to LKMM is under development.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> 
> Aren't these tests supposed to be described in litmus-tests/README?
> 
> > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > new file mode 100644
> > index 000000000000..7a39a0aaa976
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > @@ -0,0 +1,41 @@
> > +C ISA2+pooncelock+pooncelock+pombonce.litmus
> > +
> > +(*
> > + * Result: Sometimes
> > + *
> > + * This test shows that the ordering provided by a lock-protected S
> > + * litmus test (P0() and P1()) are not visible to external process P2().
> > + * This is likely to change soon.
> 
> That last line may be premature.  We haven't reached any consensus on 
> how RISC-V will handle this.  If RISC-V allows the test then the memory 
> model can't forbid it.

Agreed.  How about this?  If the RISC-V question is answered by the
end of next week, I update accordingly.  If not, I update the comment
to give the details.

Hey, at least having the memory model go in at about the same time as
a new architecture is giving us good practice!  ;-)

							Thanx, Paul

> Alan
> 
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y, spinlock_t *mylock)
> > +{
> > +	spin_lock(mylock);
> > +	WRITE_ONCE(*x, 1);
> > +	WRITE_ONCE(*y, 1);
> > +	spin_unlock(mylock);
> > +}
> > +
> > +P1(int *y, int *z, spinlock_t *mylock)
> > +{
> > +	int r0;
> > +
> > +	spin_lock(mylock);
> > +	r0 = READ_ONCE(*y);
> > +	WRITE_ONCE(*z, 1);
> > +	spin_unlock(mylock);
> > +}
> > +
> > +P2(int *x, int *z)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	r2 = READ_ONCE(*z);
> > +	smp_mb();
> > +	r1 = READ_ONCE(*x);
> > +}
> > +
> > +exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
> > 
> 
> 
