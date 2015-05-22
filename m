From: Will Deacon <will.deacon@arm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Fri, 22 May 2015 18:30:29 +0100
Message-ID: <20150522173029.GD3072@arm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
 <20150521200212.GW6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150521200212.GW6776@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Thu, May 21, 2015 at 09:02:12PM +0100, Paul E. McKenney wrote:
> On Thu, May 21, 2015 at 08:24:22PM +0100, Will Deacon wrote:
> > On Wed, May 20, 2015 at 07:16:06PM +0100, Paul E. McKenney wrote:
> > > On to #5:
> > > 
> > > 	r1 = atomic_load_explicit(&x, memory_order_consume);
> > > 	if (r1 == 42)
> > > 	  atomic_store_explicit(&y, r1, memory_order_relaxed);
> > > 	----------------------------------------------------
> > > 	r2 = atomic_load_explicit(&y, memory_order_consume);
> > > 	if (r2 == 42)
> > > 	  atomic_store_explicit(&x, 42, memory_order_relaxed);
> > > 
> > > The first thread's accesses are dependency ordered.  The second thread's
> > > ordering is in a corner case that memory-barriers.txt does not cover.
> > > You are supposed to start control dependencies with READ_ONCE_CTRL(), not
> > > a memory_order_consume load (AKA rcu_dereference and friends).  However,
> > > Alpha would have a full barrier as part of the memory_order_consume load,
> > > and the rest of the processors would (one way or another) respect the
> > > control dependency.  And the compiler would have some fun trying to
> > > break it.
> > 
> > But this is interesting because the first thread is ordered whilst the
> > second is not, so doesn't that effectively forbid the compiler from
> > constant-folding values if it can't prove that there is no dependency
> > chain?
> 
> You lost me on this one.  Are you suggesting that the compiler
> speculate the second thread's atomic store?  That would be very
> bad regardless of dependency chains.
> 
> So what constant-folding optimization are you thinking of here?
> If the above example is not amenable to such an optimization, could
> you please give me an example where constant folding would apply
> in a way that is sensitive to dependency chains?

Unless I'm missing something, I can't see what would prevent a compiler
from looking at the code in thread1 and transforming it into the code in
thread2 (i.e. constant folding r1 with 42 given that the taken branch
must mean that r1 == 42). However, such an optimisation breaks the
dependency chain, which means that a compiler needs to walk backwards
to see if there is a dependency chain extending to r1.

> > > So the current Linux memory model would allow (r1 == 42 && r2 == 42),
> > > but I don't know of any hardware/compiler combination that would
> > > allow it.  And no, I am -not- going to update memory-barriers.txt for
> > > this litmus test, its theoretical interest notwithstanding!  ;-)

Of course, I'm not asking for that at all! I'm just trying to see how
your proposal holds up with the example.

Will
