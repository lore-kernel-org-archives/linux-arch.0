From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 08:59:48 -0700
Message-ID: <20171011155948.GE3521@linux.vnet.ibm.com>
References: <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6309.1507735045@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 11, 2017 at 04:17:25PM +0100, David Howells wrote:
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > FWIW, that's exactly what my patches do, this fixup looks a bit weird
> > because it removes a prior barrier which suggests that either (a) it's in
> > the wrong place to start with, or (b) we're annotating the wrong load.
> 
> There is a loop involved.  The barrier is against the read in the previous
> iteration of the loop.  IIRC, the reason I did it this way is to avoid the
> need for the barrier if there's nothing on the 'after-side' - ie. we examine
> the pointer and see that it's NULL or a leaf.  However, I'm not sure that's a
> particularly necessary optimisation.

Given that smp_read_barrier_depends() is nothingness on anything other
than DEC Alpha, I would argue that this optimization is not necessary.

> So if READ_ONCE() issues a smp_read_barrier_depends() after the read, then
> I've no problem with the removal of these explicit barriers.

Very good!

> I will, however, quibble with the appropriateness of the name READ_ONCE()...
> I still think it's not sufficiently obvious that this is a barrier and the
> barrier is after.  Maybe READ_AND_BARRIER()?

Linus was unhappy with READ_ONCE_CTRL() to tag control dependencies, but
indicated that he might consider it if it helped code-analysis tools.
Adding Dmitry Vyukov for his thoughts on whether tagging READ_ONCE()
for dependencies would help.  Me, I would suggest READ_ONCE_DEP(), but
let's figure out if the bikeshed needs to be painted before arguing over
the color.  ;-)

> Also, does WRITE_ONCE() imply a preceding barrier?

It does not.  In most cases, the barriered version would be
smp_store_release().

							Thanx, Paul
