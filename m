From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date: Tue, 16 Jul 2019 12:20:34 +0200
Message-ID: <20190716102034.GN3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-3-alex.kogan@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:33PM -0400, Alex Kogan wrote:

> +/*
> + * set_locked_empty_mcs - Try to set the spinlock value to _Q_LOCKED_VAL,
> + * and by doing that unlock the MCS lock when its waiting queue is empty
> + * @lock: Pointer to queued spinlock structure
> + * @val: Current value of the lock
> + * @node: Pointer to the MCS node of the lock holder
> + *
> + * *,*,* -> 0,0,1
> + */
> +static __always_inline bool __set_locked_empty_mcs(struct qspinlock *lock,
> +						   u32 val,
> +						   struct mcs_spinlock *node)
> +{
> +	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
> +}

That name is nonsense. It should be something like:

static __always_inline bool __try_clear_tail(...)


> +/*
> + * pass_mcs_lock - pass the MCS lock to the next waiter
> + * @node: Pointer to the MCS node of the lock holder
> + * @next: Pointer to the MCS node of the first waiter in the MCS queue
> + */
> +static __always_inline void __pass_mcs_lock(struct mcs_spinlock *node,
> +					    struct mcs_spinlock *next)
> +{
> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
> +}

I'm not entirely happy with that name either; but it's not horrible like
the other one. Why not mcs_spin_unlock_contended() ?
