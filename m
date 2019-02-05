Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44446 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfBEJXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2019 04:23:15 -0500
Date: Tue, 5 Feb 2019 10:22:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190205092256.MB7t4zMU44Q9B9_3ut4x-AYsTReCljtQCu-08jFXi0w@z>

On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
> 
> > On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> >> Choose the next lock holder among spinning threads running on the same
> >> socket with high probability rather than always. With small probability,
> >> hand the lock to the first thread in the secondary queue or, if that
> >> queue is empty, to the immediate successor of the current lock holder
> >> in the main queue.  Thus, assuming no failures while threads hold the
> >> lock, every thread would be able to acquire the lock after a bounded
> >> number of lock transitions, with high probability.
> >> 
> >> Note that we could make the inter-socket transition deterministic,
> >> by sticking a counter of intra-socket transitions in the head node
> >> of the secondary queue. At the handoff time, we could increment
> >> the counter and check if it is below a threshold. This adds another
> >> field to queue nodes and nearly-certain local cache miss to read and
> >> update this counter during the handoff. While still beating stock,
> >> this variant adds certain overhead over the probabilistic variant.
> > 
> > (also heavily suffers from the socket == node confusion)
> > 
> > How would you suggest RT 'tunes' this?
> > 
> > RT relies on FIFO fairness of the basic spinlock primitives; you just
> > completely wrecked that.
> 
> This is true that CNA trades some fairness for shorter lock handover
> latency, much like any other NUMA-aware lock.
> 
> Can you explain, however, what exactly breaks here?

Timeliness guarantees. FIFO-fair has well defined time behaviour; you
know exactly how long you get to wait before you acquire the lock,
namely however many waiters are in front of you multiplied by the worst
case wait time.

Doing time analysis on a randomized algorithm isn't my idea of fun.

> It seems that even today, qspinlock does not support RT_PREEMPT, given
> that it uses per-CPU queue nodes.

It does work with RT, commit:

  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")

it a direct result of RT observing funnies with it. I've no idea why you
think it would not work.
