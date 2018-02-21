Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33840 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933349AbeBUQuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 11:50:32 -0500
Date: Wed, 21 Feb 2018 11:50:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S lock-based
 external-view litmus test
In-Reply-To: <20180221161223.GE3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802211148390.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, 21 Feb 2018, Paul E. McKenney wrote:

> On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> > On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> > 
> > > From: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > 
> > Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> > description?
> 
> Indeed, the name of the test is in fact ISA2.

Sure; and the Changelog entry should reflect this.

> > > accesses with a full memory barrier but without the lock.  This litmus
> > > test asks whether writes carried out by two different processes under the
> > > same lock will be seen in order by a third process not holding that lock.
> > > The answer to this question is "yes" for all architectures supporting
> > > the Linux kernel, but is "no" according to the current version of LKMM.
> > > 
> > > A patch to LKMM is under development.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > ---
> > >  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > 
> > Aren't these tests supposed to be described in litmus-tests/README?

You apparently missed this recommendation.

> > > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > > new file mode 100644
> > > index 000000000000..7a39a0aaa976
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > > @@ -0,0 +1,41 @@
> > > +C ISA2+pooncelock+pooncelock+pombonce.litmus
> > > +
> > > +(*
> > > + * Result: Sometimes
> > > + *
> > > + * This test shows that the ordering provided by a lock-protected S
> > > + * litmus test (P0() and P1()) are not visible to external process P2().
> > > + * This is likely to change soon.
> > 
> > That last line may be premature.  We haven't reached any consensus on 
> > how RISC-V will handle this.  If RISC-V allows the test then the memory 
> > model can't forbid it.
> 
> Agreed.  How about this?  If the RISC-V question is answered by the
> end of next week, I update accordingly.  If not, I update the comment
> to give the details.

The README also should be updated.

> Hey, at least having the memory model go in at about the same time as
> a new architecture is giving us good practice!  ;-)

Hopefully things will settle down in a week or two.

Alan
