From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Thu, 31 Jan 2019 11:00:09 +0100
Message-ID: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-4-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> Choose the next lock holder among spinning threads running on the same
> socket with high probability rather than always. With small probability,
> hand the lock to the first thread in the secondary queue or, if that
> queue is empty, to the immediate successor of the current lock holder
> in the main queue.  Thus, assuming no failures while threads hold the
> lock, every thread would be able to acquire the lock after a bounded
> number of lock transitions, with high probability.
> 
> Note that we could make the inter-socket transition deterministic,
> by sticking a counter of intra-socket transitions in the head node
> of the secondary queue. At the handoff time, we could increment
> the counter and check if it is below a threshold. This adds another
> field to queue nodes and nearly-certain local cache miss to read and
> update this counter during the handoff. While still beating stock,
> this variant adds certain overhead over the probabilistic variant.

(also heavily suffers from the socket == node confusion)

How would you suggest RT 'tunes' this?

RT relies on FIFO fairness of the basic spinlock primitives; you just
completely wrecked that.
