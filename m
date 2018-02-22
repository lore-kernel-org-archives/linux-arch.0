Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751978AbeBVENk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 23:13:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1M43jKf083726
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 23:13:40 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9kd0x5cg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 23:13:40 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 23:13:38 -0500
Date: Wed, 21 Feb 2018 20:13:57 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222032349.klcuiq23f52sfop6@tardis>
Message-Id: <20180222041357.GB2855@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, Feb 22, 2018 at 11:23:49AM +0800, Boqun Feng wrote:
> On Tue, Feb 20, 2018 at 03:25:10PM -0800, Paul E. McKenney wrote:
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > accesses with a full memory barrier but without the lock.  This litmus
> > test asks whether writes carried out by two different processes under the
> > same lock will be seen in order by a third process not holding that lock.
> > The answer to this question is "yes" for all architectures supporting
> 
> Hmm.. it this true? Our spin_lock() is RCpc because of PowerPC, so
> spin_lock()+spin_unlock() pairs don't provide transitivity, and that's
> why we have smp_mb__after_unlock_lock(). Is there something I'm missing?
> Or there is an upcomming commit to switch PowerPC's lock implementation?

The PowerPC lock implementation's unlock-lock pair does not order writes
from the previous critical section against reads from the later critical
section, but it does order other combinations of reads and writes.
Some have apparently said that RISC-V 's unlock-lock pair also does not
order writes from the previous critical section against writes from the
later critical section.  And no, I don't claim to have yet gotten my
head around RISC-V memory ordering.  ;-)

							Thanx, Paul

> [Cc ppc maintainers]
> 
> Regards,
> Boqun
> 
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
> > 
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
> > -- 
> > 2.5.2
> > 
