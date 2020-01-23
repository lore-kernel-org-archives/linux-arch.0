From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 23 Jan 2020 10:00:38 +0100
Message-ID: <20200123090038.GD14946@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200122170456.GY14879@hirez.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 22, 2020 at 06:04:56PM +0100, Peter Zijlstra wrote:
> +/*
> + * cna_splice_head -- splice the entire secondary queue onto the head of the
> + * primary queue.
> + */
> +static cna_splice_head(struct qspinlock *lock, u32 val,
> +		       struct mcs_spinlock *node, struct mcs_spinlock *next)
> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +
> +	tail_2nd = decode_tail(node->locked);
> +	head_2nd = tail_2nd->next;
> +
> +	if (lock) {

That should be: if (!next) {

> +		u32 new = ((struct cna_node *)tail_2nd)->encoded_tail | _Q_LOCKED_VAL;
> +		if (!atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
> +			return NULL;
> +
> +		/*
> +		 * The moment we've linked the primary tail we can race with
> +		 * the WRITE_ONCE(prev->next, node) store from new waiters.
> +		 * That store must win.
> +		 */

And that still is a shit comment; I'll go try again.

> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, next);
> +	} else {
> +		tail_2nd->next = next;
> +	}
> +
> +	return head_2nd;
> +}
