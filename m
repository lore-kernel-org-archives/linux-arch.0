From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
	for the qspinlock
Date: Thu, 9 Apr 2015 20:23:14 +0200
Message-ID: <20150409182314.GU24151@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
	<20150409181327.GY5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150409181327.GY5029@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 09, 2015 at 08:13:27PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 06, 2015 at 10:55:44PM -0400, Waiman Long wrote:
> > +#define PV_HB_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_bucket))

> > +static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
> > +{
> > +	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
> > +	struct pv_hash_bucket *hb, *end;
> > +
> > +	if (!hash)
> > +		hash = 1;
> > +
> > +	init_hash = hash;
> > +	hb = &pv_lock_hash[hash_align(hash)];
> > +	for (;;) {
> > +		for (end = hb + PV_HB_PER_LINE; hb < end; hb++) {
> > +			if (!cmpxchg(&hb->lock, NULL, lock)) {
> > +				WRITE_ONCE(hb->node, node);
> > +				/*
> > +				 * We haven't set the _Q_SLOW_VAL yet. So
> > +				 * the order of writing doesn't matter.
> > +				 */
> > +				smp_wmb(); /* matches rmb from pv_hash_find */
> > +				goto done;
> > +			}
> > +		}
> > +
> > +		hash = lfsr(hash, pv_lock_hash_bits, 0);
> 
> Since pv_lock_hash_bits is a variable, you end up running through that
> massive if() forest to find the corresponding tap every single time. It
> cannot compile-time optimize it.
> 
> Hence:
> 		hash = lfsr(hash, pv_taps);
> 
> (I don't get the bits argument to the lfsr).
> 
> In any case, like I said before, I think we should try a linear probe
> sequence first, the lfsr was over engineering from my side.
> 
> > +		hb = &pv_lock_hash[hash_align(hash)];

So one thing this does -- and one of the reasons I figured I should
ditch the LFSR instead of fixing it -- is that you end up scanning each
bucket HB_PER_LINE times.

The 'fix' would be to LFSR on cachelines instead of HBs but then you're
stuck with the 0-th cacheline.

> > +		BUG_ON(hash == init_hash);
> > +	}
> > +
> > +done:
> > +	return &hb->lock;
> > +}
