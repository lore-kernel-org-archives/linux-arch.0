From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Date: Fri, 14 Feb 2020 09:18:26 +0100
Message-ID: <20200214081826.GB17708@andrea>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-4-boqun.feng@gmail.com>
 <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> > @@ -0,0 +1,29 @@
> > +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> > + * "strong-acquire": both the read and write part of the RMW is ordered before
> > + * the subsequential memory accesses.
> > + *)
> > +
> > +{
> > +}
> > +
> > +P0(int *x, atomic_t *y)
> > +{
> > +	r0 = READ_ONCE(*x);
> > +	smp_rmb();
> > +	r1 = atomic_read(y);

IIRC, klitmus7 needs a declaration for these local variables, say
(trying to keep herd7 happy):

P0(int *x, atomic_t *y)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*x);
	smp_rmb();
	r1 = atomic_read(y);
}

Thanks,
  Andrea
