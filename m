From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Date: Sat, 15 Feb 2020 08:09:44 +0800
Message-ID: <20200215000944.GC110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-4-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141049310.1579-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141049310.1579-100000@iolanthe.rowland.org>
Sender: linux-doc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2020 at 10:58:57AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe atomic RMW +
> > smp_mb__after_atomic() is "strong acquire" (both the read and the write
> > part is ordered).
> 
> "strong acquire" is not an appropriate description -- there is no such
> thing as a strong acquire in the LKMM -- nor is it a good name for the
> litmus test.  A better description would be "stronger than acquire", as
> in the sentence preceding the litmus test in atomic_t.txt.
> 

Agreed, I will change it. 

And I can't help feeling this is another reason to add more litmus tests
into kernel directory. During the review process you found two places
where we can improve the text of the documents to be aligned to LKMM. I
think we all want to use a unversial language (LKMM) to discuss things
of parallel programming in kernel, and providing more litmus tests to
people so that they can handly use them will cerntainly be helpful on
this ;-)

> >  So make it a litmus test in memory-model litmus-tests
> > directory, so that people can access the litmus easily.
> > 
> > Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> > atomic_t.txt for the consistency with the processor numbers in the
> > litmus test, which herd can handle.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  Documentation/atomic_t.txt                    |  6 ++--
> >  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
> >  tools/memory-model/litmus-tests/README        |  5 ++++
> >  3 files changed, 37 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index ceb85ada378e..e3ad4e4cd9ed 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
> >    {
> >    }
> >  
> > -  P1(int *x, atomic_t *y)
> > +  P0(int *x, atomic_t *y)
> >    {
> >      r0 = READ_ONCE(*x);
> >      smp_rmb();
> >      r1 = atomic_read(y);
> >    }
> >  
> > -  P2(int *x, atomic_t *y)
> > +  P1(int *x, atomic_t *y)
> >    {
> >      atomic_inc(y);
> >      smp_mb__after_atomic();
> > @@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
> >  because it would not order the W part of the RMW against the following
> >  WRITE_ONCE.  Thus:
> >  
> > -  P1			P2
> > +  P0			P1
> >  
> >  			t = LL.acq *y (0)
> >  			t++;
> > diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > new file mode 100644
> > index 000000000000..e7216cf9d92a
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > @@ -0,0 +1,29 @@
> > +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> 
> s/Test of/Test that/
> 
> > + * "strong-acquire": both the read and write part of the RMW is ordered before
> 
> This should say "stronger than a normal acquire".  And "part" should be
> "parts", and "is ordered" should be "are ordered".
> 

Thanks! I will improve in the next version.

> Also, please try to arrange the line breaks so that the comment lines
> don't have vastly different lengths.
> 
> Similar changes should be made for the text added to README.
> 

Got it.

Regards,
Boqun

> Alan Stern
> 
