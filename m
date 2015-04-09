From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 13/15] pvqspinlock: Only kick CPU at unlock time
Date: Thu, 9 Apr 2015 22:07:14 +0200
Message-ID: <20150409200714.GV24151@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-14-git-send-email-Waiman.Long@hp.com>
	<20150409195721.GA5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150409195721.GA5029@twins.programming.kicks-ass.net>
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

On Thu, Apr 09, 2015 at 09:57:21PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 06, 2015 at 10:55:48PM -0400, Waiman Long wrote:
> 
> > @@ -219,24 +236,30 @@ static void pv_wait_node(struct mcs_spinlock *node)
> >  }
> >  
> >  /*
> > + * Called after setting next->locked = 1 & lock acquired.
> > + * Check if the the CPU has been halted. If so, set the _Q_SLOW_VAL flag
> > + * and put an entry into the lock hash table to be waken up at unlock time.
> >   */
> > -static void pv_kick_node(struct mcs_spinlock *node)
> > +static void pv_scan_next(struct qspinlock *lock, struct mcs_spinlock *node)
> 
> I'm not too sure about that name change..
> 
> >  {
> >  	struct pv_node *pn = (struct pv_node *)node;
> > +	struct __qspinlock *l = (void *)lock;
> >  
> >  	/*
> > +	 * Transition CPU state: halted => hashed
> > +	 * Quit if the transition failed.
> >  	 */
> > +	if (cmpxchg(&pn->state, vcpu_halted, vcpu_hashed) != vcpu_halted)
> > +		return;
> > +
> > +	/*
> > +	 * Put the lock into the hash table & set the _Q_SLOW_VAL in the lock.
> > +	 * As this is the same CPU that will check the _Q_SLOW_VAL value and
> > +	 * the hash table later on at unlock time, no atomic instruction is
> > +	 * needed.
> > +	 */
> > +	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
> > +	(void)pv_hash(lock, pn);
> >  }
> 
> This is broken. The unlock path relies on:
> 
>   pv_hash()
>    MB
>   l->locked = SLOW
> 
> such that when it observes SLOW, it must then also observe a consistent
> bucket.
> 
> The above can have us do pv_hash_find() _before_ we actually hash the
> lock, which will result in us triggering that BUG_ON() in there.

Urgh, clearly its late and I cannot read. The comment explains it.
