From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] qspinlock: Add pending bit
Date: Tue, 24 Jun 2014 10:46:19 +0200
Message-ID: <20140624084619.GN13930@laptop.programming.kicks-ass.net>
References: <201406172323.s5HNNveT018439@userz7022.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201406172323.s5HNNveT018439@userz7022.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Waiman Long <waiman.long@hp.com>, linux-arch@vger.kernel.org, riel@redhat.com, kvm@vger.kernel.org, gleb@redhat.com, boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org, david.vrabel@citrix.com, scott.norton@hp.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, chegu_vinod@hp.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 17, 2014 at 07:23:44PM -0400, Konrad Rzeszutek Wilk wrote:
> > Actually in my v11 patch, I subdivided the slowpath into a slowpath for 
> > the pending code and slowerpath for actual queuing. Perhaps, we could 
> > use quickpath and slowpath instead. Anyway, it is a minor detail that we 
> > can discuss after the core code get merged.

> Why not do it the right way the first time around?

Because I told him to not do this. There's the fast path; the inline
single trylock cmpxchg, and the slow path; the out-of-line thing doing
the rest.

Note that pretty much all other locking primitives are implemented
similarly, with fast and slow paths.

I find that having the entire state machine in a single function is
easier.

> That aside - these optimization - seem to make the code harder to
> read. And they do remind me of the scheduler code in 2.6.x which was
> based on heuristics - and eventually ripped out.

Well, it increases the states and thereby the complexity, nothing to be
done about that. Also, its not a random heuristic in the sense that it
has odd behaviour. Its behaviour is very well controlled.

Furthermore, without this the qspinlock performance is too far off the
ticket lock performance to be a possible replacement.

> So are these optimizations based on turning off certain hardware
> features? Say hardware prefetching?

We can try of course, but that doesn't help the code -- in fact, adding
the switch to turn if off _adds_ code on top.

> What I am getting at - can the hardware do this at some point (or
> perhaps already does on IvyBridge-EX?) - that is prefetch the per-cpu
> areas so they are always hot? And rendering this optimization not
> needed?

Got a ref to documentation on this new fancy stuff? I might have an
IVB-EX, but I've not tried it yet.

That said, memory fetches are 100s of cycles, and while prefetch can
hide some of that, I'm not sure we can hide all of it, there's not
_that_ much we do.

If we observe the pending and locked bit set, we immediately drop to the
queueing code and touch it. So there's only a few useful instructions to
do.
