From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 09/19] qspinlock: Prepare for unfair lock support
Date: Thu, 8 May 2014 21:06:49 +0200
Message-ID: <20140508190649.GR2844@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-10-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1399474907-22206-10-git-send-email-Waiman.Long@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 07, 2014 at 11:01:37AM -0400, Waiman Long wrote:
> If unfair lock is supported, the lock acquisition loop at the end of
> the queue_spin_lock_slowpath() function may need to detect the fact
> the lock can be stolen. Code are added for the stolen lock detection.
> 
> A new qhead macro is also defined as a shorthand for mcs.locked.

NAK, unfair should be a pure test-and-set lock.

>  /**
>   * get_qlock - Set the lock bit and own the lock
> - * @lock: Pointer to queue spinlock structure
> + * @lock : Pointer to queue spinlock structure
> + * Return: 1 if lock acquired, 0 otherwise
>   *
>   * This routine should only be called when the caller is the only one
>   * entitled to acquire the lock.
>   */
> -static __always_inline void get_qlock(struct qspinlock *lock)
> +static __always_inline int get_qlock(struct qspinlock *lock)
>  {
>  	struct __qspinlock *l = (void *)lock;
>  
>  	barrier();
>  	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
>  	barrier();
> +	return 1;
>  }

and here you make a horribly named function more horrible;
try_set_locked() is that its now.
