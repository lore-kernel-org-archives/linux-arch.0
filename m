From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Fri, 3 Apr 2015 15:43:34 +0200
Message-ID: <20150403134334.GG32047@worktop.ger.corp.intel.com>
References: <20150401171223.GO23123@twins.programming.kicks-ass.net>
	<20150401174239.GO24151@twins.programming.kicks-ass.net>
	<20150401181744.GE32047@worktop.ger.corp.intel.com>
	<551C3EF5.6090809@hp.com>
	<20150401184858.GA9791@dyad.arnhem.chello.nl>
	<551C4E02.8030806@hp.com>
	<20150401210317.GZ27490@worktop.programming.kicks-ass.net>
	<551D6E2E.1080801@hp.com>
	<20150402172057.GA27490@worktop.programming.kicks-ass.net>
	<20150402194834.GF32047@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150402194834.GF32047@worktop.ger.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 02, 2015 at 09:48:34PM +0200, Peter Zijlstra wrote:
> @@ -158,20 +257,20 @@ static void pv_wait_head(struct qspinloc
>  void __pv_queue_spin_unlock(struct qspinlock *lock)
>  {
>  	struct __qspinlock *l = (void *)lock;
> +	struct pv_hash_bucket *hb;
>  
>  	if (xchg(&l->locked, 0) != _Q_SLOW_VAL)
>  		return;
>  
>  	/*
>  	 * At this point the memory pointed at by lock can be freed/reused,
> +	 * however we can still use the pointer value to search in our hash
> +	 * table.
>  	 *
> +	 * Also, if we observe _Q_SLOW_VAL we _must_ now observe 'our' hash
> +	 * bucket. See pv_wait_head().
>  	 */
> +	hb = pv_hash_find(lock);
> +	pv_kick(hb->cpu);
> +	WRITE_ONCE(hb->lock, NULL); /* unhash */
>  }

So I _think_ I found a problem with this approach :/

If, as per the above, the lock does indeed get freed, it can get
re-allocated and stuck in the hash table (again) before we get the
lookup and unhash it.

I'll have to ponder that a bit more.
