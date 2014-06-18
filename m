From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 04/11] qspinlock: Extract out the exchange of tail code
	word
Date: Wed, 18 Jun 2014 09:50:57 -0400
Message-ID: <20140618135057.GB4729@laptop.dumpdata.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.376621956@chello.nl>
	<20140617205525.GB29634@laptop.dumpdata.com>
	<53A17A09.6010007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53A17A09.6010007@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, gleb@redhat.com, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 18, 2014 at 01:37:45PM +0200, Paolo Bonzini wrote:
> Il 17/06/2014 22:55, Konrad Rzeszutek Wilk ha scritto:
> >On Sun, Jun 15, 2014 at 02:47:01PM +0200, Peter Zijlstra wrote:
> >>From: Waiman Long <Waiman.Long@hp.com>
> >>
> >>This patch extracts the logic for the exchange of new and previous tail
> >>code words into a new xchg_tail() function which can be optimized in a
> >>later patch.
> >
> >And also adds a third try on acquiring the lock. That I think should
> >be a seperate patch.
> 
> It doesn't really add a new try, the old code is:
> 
> 
> -	for (;;) {
> -		new = _Q_LOCKED_VAL;
> -		if (val)
> -			new = tail | (val & _Q_LOCKED_PENDING_MASK);
> -
> -		old = atomic_cmpxchg(&lock->val, val, new);
> -		if (old == val)
> -			break;
> -
> -		val = old;
> -	}
> 
>  	/*
> -	 * we won the trylock; forget about queueing.
>  	 */
> -	if (new == _Q_LOCKED_VAL)
> -		goto release;
> 
> The trylock happens if the "if (val)" hits the else branch.
> 
> What the patch does is change it from attempting two transition with a
> single cmpxchg:
> 
> -	 * 0,0,0 -> 0,0,1 ; trylock
> -	 * p,y,x -> n,y,x ; prev = xchg(lock, node)
> 
> to first doing the trylock, then the xchg.  If the trylock passes and the
> xchg returns prev=0,0,0, the next step of the algorithm goes to the
> locked/uncontended state
> 
> +	/*
> +	 * claim the lock:
> +	 *
> +	 * n,0 -> 0,1 : lock, uncontended
> 
> Similar to your suggestion of patch 3, it's expected that the xchg will
> *not* return prev=0,0,0 after a failed trylock.

I do like your explanation. I hope that Peter will put it in the
description as it explains the change quite well.

> 
> However, I *do* agree with you that it's simpler to just squash this patch
> into 01/11.

Uh, did I say that? Oh I said why don't make it right the first time!

I meant in terms of seperating the slowpath (aka the bytelock on the pending
bit) from the queue (MCS code). Or renaming the function to be called
'complex' instead of 'slowpath' as it is getting quite hairy.

The #1 patch is nice by itself - as it lays out the foundation of the
MCS-similar code - and if Ingo decides he does not want this pending
byte-lock bit business - it can be easily reverted or dropped.

In terms of squashing this in #1 - I would advocate against that.

Thanks!
