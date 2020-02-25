Return-Path: <SRS0=e/bK=4N=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Tue, 25 Feb 2020 15:34:51 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200225073451.GP69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
 <20200214081213.GA17708@andrea>
 <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-doc-owner@vger.kernel.org
To: Andrea Parri <parri.andrea@gmail.com>, Luc Maranget <luc.maranget@inria.fr>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200225073451.pHkLxkKWaE5RZemdFPCB-37e1UeAostN96pN2hCDGsA@z>

Luc,

Could you have a look at the problem Andrea and I discuss here? It seems
that you have done a few things in herd for atomic_add_unless() in
particular, and based on the experiments of Andrea and me, seems
atomic_add_unless() works correctly. So can you confirm that herd now
can handle atomic_add_unless() or there is still something missing?

Thanks!

Regards,
Boqun

On Fri, Feb 14, 2020 at 06:40:03PM +0800, Boqun Feng wrote:
> On Fri, Feb 14, 2020 at 09:12:13AM +0100, Andrea Parri wrote:
> > > @@ -0,0 +1,24 @@
> > > +C Atomic-set-observable-to-RMW
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > > + *)
> > > +
> > > +{
> > > +	atomic_t v = ATOMIC_INIT(1);
> > > +}
> > > +
> > > +P0(atomic_t *v)
> > > +{
> > > +	(void)atomic_add_unless(v,1,0);
> > 
> > We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
> > entry (6b) in tools/memory-model/README; the discussion was here:
> > 
> >   https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com
> > 
> 
> And in an email replying to that email, you just tried and seemed
> atomic_add_unless() works ;-)
> 
> > but unfortunately I can't remember other details at the moment: maybe
> > it is just a matter of or the proper time to update that section.
> > 
> 
> I spend a few time looking into the changes in herd, the dependency
> problem seems to be as follow:
> 
> For atomic_add_unless(ptr, a, u), the return value (true or false)
> depends on both *ptr and u, this is different than other atomic RMW,
> whose return value only depends on *ptr. Considering the following
> litmus test:
> 
> 	C atomic_add_unless-dependency
> 
> 	{
> 		int y = 1;
> 	}
> 
> 	P0(int *x, int *y, int *z)
> 	{
> 		int r0;
> 		int r1;
> 		int r2;
> 
> 		r0 = READ_ONCE(*x);
> 		if (atomic_add_unless(y, 2, r0))
> 			WRITE_ONCE(*z, 42);
> 		else
> 			WRITE_ONCE(*z, 1);
> 	}
> 
> 	P1(int *x, int *y, int *z)
> 	{
> 		int r0;
> 
> 		r0 = smp_load_acquire(z);
> 
> 		WRITE_ONCE(*x, 1);
> 	}
> 
> 	exists
> 	(1:r0 = 1 /\ 0:r0 = 1)
> 
> , the exist-clause will never trigger, however if we replace
> "atomic_add_unless(y, 2, r0)" with "atomic_add_unless(y, 2, 1)", the
> write on *z and the read from *x on CPU 0 are not ordered, so we could
> observe the exist-clause triggered.
> 
> I just tried with the latest herd, and herd can work out this
> dependency. So I think we are good now and can change the limitation
> section in the document. But I will wait for Luc's input for this. Luc,
> did I get this correct? Is there any other limitation on
> atomic_add_unless() now?
> 
> Regards,
> Boqun
> 
> > Thanks,
> >   Andrea
