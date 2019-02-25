From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Mon, 25 Feb 2019 09:55:17 -0800
Message-ID: <20190225175517.GK4072@linux.ibm.com>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 02:00:14PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 22, 2019 at 12:21:28PM +0100, Andrea Parri wrote:
> > > What I do object to is a model that's weaker than any possible sane
> > > hardware.
> > 
> > Not the first time I hear you calling this out.  And inevitably, every
> > time, other slogans come to my mind:  "C is not an assembly language",
> 
> But it bloody well should be ;-)

Yeah, we had some debates about this sort of thing at the C++ Standards
Committee meeting last week.

Pointer provenance and concurrent algorithms, though for once not
affecting RCU!  We might actually be on the road to a fix that preserves
the relevant optimizations while still allowing most (if not all) existing
concurrent C/C++ code to continue working correctly.  (The current thought
is that loads and stores involving inline assembly, C/C++ atomics, or
volatile get their provenance stripped.  There may need to be some other
mechanisms for plain C-language loads and stores in some cases as well.)

But if you know of any code in the Linux kernel that needs to compare
pointers, one of which might be in the process of being freed, please
do point me at it.  I thought that the smp_call_function() code fit,
but it avoids the problem because only the sending CPU is allowed to
push onto the stack of pending smp_call_function() invocations.

That same concurrent linked stack pattern using cmpxchg() to atomically
push and xchg() to atomically pop the full list -would- have this problem.
The old pointer passed to cmpxchg() might reference an object that was
freed between the time that the old pointer was loaded and the time
that the cmpxchg() executed.  One way to avoid this is to do the push
operation in an RCU read-side critical section and use kfree_rcu()
instead of kfree().  Of course, code in the idle loop or that might
run on offline CPUs cannot use RCU, plus some data structures are not
happy with kfree_rcu() delays, so...

Again, if you know of any code in the Linux kernel that would have
problems with aggressive optimizations based on pointer provenance,
please let me know!

							Thanx, Paul
