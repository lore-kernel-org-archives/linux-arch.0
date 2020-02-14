From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Date: Sat, 15 Feb 2020 07:52:15 +0800
Message-ID: <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
Sender: linux-doc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2020 at 10:47:48AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe the behavior of
> > an atomic_set() with the an atomic RMW, so add it into the litmus-tests
> > directory to make it easily accessible for anyone who cares about the
> > semantics of our atomic APIs.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++++++
> >  tools/memory-model/litmus-tests/README        |  3 +++
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> 
> I don't like that name, or the corresponding sentence in atomic_t.txt:
> 
> 	A subtle detail of atomic_set{}() is that it should be
> 	observable to the RMW ops.
> 
> "Observable" doesn't get the point across -- the point being that the
> atomic RMW ops have to be _atomic_ with respect to all atomic store
> operations, including atomic_set.
> 
> Suggestion: Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus, with 
> corresponding changes to the comment in the litmus test and the entry 
> in README.
> 

I agree, and thanks for the suggestion! And I change the sentence in
atomic_t.txt with:

	A note for the implementation of atomic_set{}() is that it
	cannot break the atomicity of the RMW ops.

, since I think that part of the doc is more about the suggestion to
anyone who want to implement the atomic_set(). Peter, is that OK to you?

Regards,
Boqun

> Alan
> 
> > diff --git a/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> > new file mode 100644
> > index 000000000000..4326f56f2c1a
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> > @@ -0,0 +1,24 @@
> > +C Atomic-set-observable-to-RMW
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > + *)
> > +
> > +{
> > +	atomic_t v = ATOMIC_INIT(1);
> > +}
> > +
> > +P0(atomic_t *v)
> > +{
> > +	(void)atomic_add_unless(v,1,0);
> > +}
> > +
> > +P1(atomic_t *v)
> > +{
> > +	atomic_set(v, 0);
> > +}
> > +
> > +exists
> > +(v=2)
> > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > index 681f9067fa9e..81eeacebd160 100644
> > --- a/tools/memory-model/litmus-tests/README
> > +++ b/tools/memory-model/litmus-tests/README
> > @@ -2,6 +2,9 @@
> >  LITMUS TESTS
> >  ============
> >  
> > +Atomic-set-observable-to-RMW.litmus
> > +	Test of the result of atomic_set() must be observable to atomic RMWs.
> > +
> >  CoRR+poonceonce+Once.litmus
> >  	Test of read-read coherence, that is, whether or not two
> >  	successive reads from the same variable are ordered.
> > 
> 
