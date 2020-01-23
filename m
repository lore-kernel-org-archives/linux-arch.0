From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 23 Jan 2020 10:26:58 +0100
Message-ID: <20200123092658.GC14879@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200115035920.54451-4-alex.kogan@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 14, 2020 at 10:59:18PM -0500, Alex Kogan wrote:
> +/* this function is called only when the primary queue is empty */
> +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> +				       struct mcs_spinlock *node)
> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +	u32 new;
> +
> +	/* If the secondary queue is empty, do what MCS does. */
> +	if (node->locked <= 1)
> +		return __try_clear_tail(lock, val, node);
> +
> +	/*
> +	 * Try to update the tail value to the last node in the secondary queue.
> +	 * If successful, pass the lock to the first thread in the secondary
> +	 * queue. Doing those two actions effectively moves all nodes from the
> +	 * secondary queue into the main one.
> +	 */
> +	tail_2nd = decode_tail(node->locked);
> +	head_2nd = tail_2nd->next;
> +	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> +
> +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> +		/*
> +		 * Try to reset @next in tail_2nd to NULL, but no need to check
> +		 * the result - if failed, a new successor has updated it.
> +		 */

I think you actually have an ordering bug here; the load of head_2nd
*must* happen before the atomic_try_cmpxchg(), otherwise it might
observe the new next and clear a valid next pointer.

What would be the best fix for that; I'm thinking:

	head_2nd = smp_load_acquire(&tail_2nd->next);

Will?

> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
> +		arch_mcs_pass_lock(&head_2nd->locked, 1);
> +		return true;
> +	}
> +
> +	return false;
> +}
