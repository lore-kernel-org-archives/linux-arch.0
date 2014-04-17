From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Thu, 17 Apr 2014 17:56:49 +0200
Message-ID: <20140417155649.GR11096@twins.programming.kicks-ass.net>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
> +struct __qspinlock {
> +	union {
> +		atomic_t val;
> +		struct {
> +#ifdef __LITTLE_ENDIAN
> +			u16	locked_pending;
> +			u16	tail;
> +#else
> +			u16	tail;
> +			u16	locked_pending;
> +#endif
> +		};
> +	};
> +};
> +
> +/**
> + * clear_pending_set_locked - take ownership and clear the pending bit.
> + * @lock: Pointer to queue spinlock structure
> + * @val : Current value of the queue spinlock 32-bit word
> + *
> + * *,1,0 -> *,0,1
> + */
> +static __always_inline void
> +clear_pending_set_locked(struct qspinlock *lock, u32 val)
> +{
> +	struct __qspinlock *l = (void *)lock;
> +
> +	ACCESS_ONCE(l->locked_pending) = 1;

You lost the __constant_le16_to_cpu(_Q_LOCKED_VAL) there. The
unconditional 1 is wrong. You also have to flip the bytes in
locked_pending.
