From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 30 Jan 2020 17:01:15 -0500
Message-ID: <D6ED40A0-E96D-41F6-AA74-0901C2C37476@oracle.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:34666 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgA3WD1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 17:03:27 -0500
In-Reply-To: <20200122170456.GY14879@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com

Hi, Peter.

It looks good =E2=80=94 thanks for your review!

I have a couple of comments and suggestions.
Please, see below.

> On Jan 22, 2020, at 12:04 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 22, 2020 at 10:51:27AM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
>>>=20
>>> various notes and changes in the below.
>>=20
>> Also, sorry for replying to v7 and v8, I forgot to refresh email on =
the
>> laptop and had spotty cell service last night and only found v7 in =
that
>> mailbox.
>>=20
>> Afaict none of the things I commented on were fundamentally changed
>> though.
Nothing fundamental, but some things you may find objectionable, like=20
the names of new enum elements :)

>=20
> But since I was editing, here is the latest version..
>=20
> ---
>=20
> Index: linux-2.6/kernel/locking/qspinlock_cna.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/kernel/locking/qspinlock_cna.h
> @@ -0,0 +1,261 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _GEN_CNA_LOCK_SLOWPATH
> +#error "do not include this file"
> +#endif
> +
> +#include <linux/topology.h>
> +
> +/*
> + * Implement a NUMA-aware version of MCS (aka CNA, or compact =
NUMA-aware lock).
> + *
> + * In CNA, spinning threads are organized in two queues, a primary =
queue for
> + * threads running on the same NUMA node as the current lock holder, =
and a
> + * secondary queue for threads running on other nodes. Schematically, =
it looks
> + * like this:
> + *
> + *    cna_node
> + *   +----------+     +--------+         +--------+
> + *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  =
[Primary queue]
> + *   |mcs:locked| -.  +--------+         +--------+
> + *   +----------+  |
> + *                 `----------------------.
> + *                                        v
> + *                 +--------+         +--------+
> + *                 |mcs:next| --> ... |mcs:next|            =
[Secondary queue]
> + *                 +--------+         +--------+
> + *                     ^                    |
> + *                     `--------------------'
> + *
> + * N.B. locked :=3D 1 if secondary queue is absent. Otherwise, it =
contains the
> + * encoded pointer to the tail of the secondary queue, which is =
organized as a
> + * circular list.
> + *
> + * After acquiring the MCS lock and before acquiring the spinlock, =
the lock
> + * holder scans the primary queue looking for a thread running on the =
same node
> + * (pre-scan). If found (call it thread T), all threads in the =
primary queue
> + * between the current lock holder and T are moved to the end of the =
secondary
> + * queue.  If such T is not found, we make another scan of the =
primary queue
> + * when unlocking the MCS lock (post-scan), starting at the node =
where pre-scan
> + * stopped. If both scans fail to find such T, the MCS lock is passed =
to the
> + * first thread in the secondary queue. If the secondary queue is =
empty, the
> + * lock is passed to the next thread in the primary queue.
> + *
> + * For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3D49NdSlRXQxlPifNqUk_E7p7Q-nJ0_HP=
9fkF_F_GsC_Y&s=3D0c25gE6r6cKpOC3J0KaPnnkUd4wFXwPNilBflDnNOSQ&e=3D .
> + *
> + * Authors: Alex Kogan <alex.kogan@oracle.com>
> + *          Dave Dice <dave.dice@oracle.com>
> + */
> +
> +struct cna_node {
> +	struct mcs_spinlock	mcs;
> +	int			numa_node;
> +	u32			encoded_tail;    /* self */
> +	u32			partial_order;
I will not argue about names, just point out that I think =
pre_scan_result
is more self-explanatory.

> +};
> +
> +static void __init cna_init_nodes_per_cpu(unsigned int cpu)
> +{
> +	struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
> +	int numa_node =3D cpu_to_node(cpu);
> +	int i;
> +
> +	for (i =3D 0; i < MAX_NODES; i++) {
> +		struct cna_node *cn =3D (struct cna_node =
*)grab_mcs_node(base, i);
> +
> +		cn->numa_node =3D numa_node;
> +		cn->encoded_tail =3D encode_tail(cpu, i);
> +		/*
> +		 * @encoded_tail has to be larger than 1, so we do not =
confuse
> +		 * it with other valid values for @locked or =
@partial_order
> +		 * (0 or 1)
> +		 */
> +		WARN_ON(cn->encoded_tail <=3D 1);
> +	}
> +}
> +
> +static int __init cna_init_nodes(void)
> +{
> +	unsigned int cpu;
> +
> +	/*
> +	 * this will break on 32bit architectures, so we restrict
> +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> +	 */
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store an ecoded tail word in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> +
> +	for_each_possible_cpu(cpu)
> +		cna_init_nodes_per_cpu(cpu);
> +
> +	return 0;
> +}
> +early_initcall(cna_init_nodes);
> +
> +/*
> + * cna_splice_tail -- splice nodes in the primary queue between =
[first, last]
> + * onto the secondary queue.
> + */
> +static void cna_splice_tail(struct mcs_spinlock *node,
> +			    struct mcs_spinlock *first,
> +			    struct mcs_spinlock *last)
> +{
> +	/* remove [first,last] */
> +	node->next =3D last->next;
> +
> +	/* stick [first,last] on the secondary queue tail */
> +	if (node->locked <=3D 1) { /* if secondary queue is empty */
> +		/* create secondary queue */
> +		last->next =3D first;
> +	} else {
> +		/* add to the tail of the secondary queue */
> +		struct mcs_spinlock *tail_2nd =3D =
decode_tail(node->locked);
> +		struct mcs_spinlock *head_2nd =3D tail_2nd->next;
> +
> +		tail_2nd->next =3D first;
> +		last->next =3D head_2nd;
> +	}
> +
> +	node->locked =3D ((struct cna_node *)last)->encoded_tail;
> +}
> +
> +/*
> + * cna_order_queue - scan the primary queue looking for the first =
lock node on
> + * the same NUMA node as the lock holder and move any skipped nodes =
onto the
> + * secondary queue.
Oh man, you took out the ascii figure I was working so hard to put in. =
Oh well.

> + *
> + * Returns 0 if a matching node is found; otherwise return the =
encoded pointer
> + * to the last element inspected (such that a subsequent scan can =
continue there).
> + *
> + * The worst case complexity of the scan is O(n), where n is the =
number
> + * of current waiters. However, the amortized complexity is close to =
O(1),
> + * as the immediate successor is likely to be running on the same =
node once
> + * threads from other nodes are moved to the secondary queue.
> + *
> + * XXX does not compute; given equal contention it should average to =
O(nr_nodes).
Let me try to convince you. Under contention, the immediate waiter would =
be
a local one. So the scan would typically take O(1) steps. We need to =
consider
the extra work/steps we take to move nodes to the secondary queue. The
number of such nodes is O(n) (to be more precise, it is O(n-m), where m
is nr_cpus_per_node), and we spend a constant amount of work, per node,=20=

to scan those nodes and move them to the secondary queue. So in =
2^thresholds
lock handovers, we scan 2^thresholds x 1 + n-m nodes. Assuming=20
2^thresholds > n, the amortized complexity of this function then is =
O(1).

> + */
> +static u32 cna_order_queue(struct mcs_spinlock *node,
> +			   struct mcs_spinlock *iter)
> +{
> +	struct cna_node *cni =3D (struct cna_node =
*)READ_ONCE(iter->next);
> +	struct cna_node *cn =3D (struct cna_node *)node;
> +	int nid =3D cn->numa_node;
> +	struct cna_node *last;
> +
> +	/* find any next waiter on 'our' NUMA node */
> +	for (last =3D cn;
> +	     cni && cni->numa_node !=3D nid;
> +	     last =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
> +		;
> +
> +	if (!cna)
Should be =E2=80=98cni=E2=80=99

> +		return last->encoded_tail; /* continue from here */
> +
> +	if (last !=3D cn)	/* did we skip any waiters? */
> +		cna_splice_tail(node, node->next, (struct mcs_spinlock =
*)last);
> +
> +	return 0;
> +}
> +
> +/*
> + * cna_splice_head -- splice the entire secondary queue onto the head =
of the
> + * primary queue.
> + */
> +static cna_splice_head(struct qspinlock *lock, u32 val,
> +		       struct mcs_spinlock *node, struct mcs_spinlock =
*next)
Missing return value type (struct mcs_spinlock *).

> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +
> +	tail_2nd =3D decode_tail(node->locked);
> +	head_2nd =3D tail_2nd->next;
I understand that you are trying to avoid repeating those two lines
in both places this function is called from, but you do it at the cost
of adding the following unnecessary if-statement, and in general this =
function
looks clunky.

Maybe move those two lines into a separate function, e.g.,

static struct mcs_spinlock *cna_extract_2dary_head_tail(unsigned int =
locked,
								struct =
mcs_spinlock **tail_2nd)

and then call this function from cna_pass_lock(), while here you can do:

	  struct mcs_spinlock *head_2nd, *tail_2nd;

	  head_2nd =3D cna_extract_2dary_head_tail(lock, &tail_2nd);

	  u32 new =3D ((struct cna_node *)tail_2nd)->encoded_tail | =
_Q_LOCKED_VAL;
	  =E2=80=A6


> +
> +	if (lock) {
> +		u32 new =3D ((struct cna_node *)tail_2nd)->encoded_tail =
| _Q_LOCKED_VAL;
> +		if (!atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
> +			return NULL;
> +
> +		/*
> +		 * The moment we've linked the primary tail we can race =
with
> +		 * the WRITE_ONCE(prev->next, node) store from new =
waiters.
> +		 * That store must win.
> +		 */
> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, next);
> +	} else {
> +		tail_2nd->next =3D next;
> +	}
> +
> +	return head_2nd;
> +}
> +
> +/* Abuse the pv_wait_head_or_lock() hook to get some work done */
> +static __always_inline u32 cna_wait_head_or_lock(struct qspinlock =
*lock,
> +						 struct mcs_spinlock =
*node)
> +{
> +	struct cna_node *cn =3D (struct cna_node *)node;
> +
> +	/*
> +	 * Try and put the time otherwise spend spin waiting on
> +	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
> +	 */
> +	cn->partial_order =3D cna_order_queue(node, node);
> +
> +	return 0; /* we lied; we didn't wait, go do so now */
> +}
> +
> +static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 =
val,
> +				      struct mcs_spinlock *node)
> +{
> +	struct mcs_spinlock *next;
> +
> +	/*
> +	 * We're here because the primary queue is empty; check the =
secondary
> +	 * queue for remote waiters.
> +	 */
> +	if (node->locked > 1) {
> +		/*
> +		 * When there are waiters on the secondary queue move =
them back
> +		 * onto the primary queue and let them rip.
> +		 */
> +		next =3D cna_splice_head(lock, val, node, NULL);
> +		if (next) {
And, again, this if-statement is here only because you moved the rest of =
the code
into cna_splice_head(). Perhaps, with cna_extract_2dary_head_tail() you =
can
bring that code back?

> +			arch_mcs_pass_lock(&head_2nd->locked, 1);
Should be next->locked. Better yet, =E2=80=98next' should be called =
=E2=80=98head_2nd=E2=80=99.
> +			return true;
> +		}
> +
> +		return false;
> +	}
> +
> +	/* Both queues empty. */
> +	return __try_clear_tail(lock, val, node);
> +}
> +
> +static inline void cna_pass_lock(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct cna_node *cn =3D (struct cna_node *)node;
> +	u32 partial_order =3D cn->partial_order;
> +	u32 val =3D _Q_LOCKED_VAL;
> +
> +	/* cna_wait_head_or_lock() left work for us. */
> +	if (partial_order) {
> +		partial_order =3D cna_order_queue(node, =
decode_tail(partial_order));
> +
> +	if (!partial_order) {
> +		/*
> +		 * We found a local waiter; reload @next in case we =
called
> +		 * cna_order_queue() above.
> +		 */
> +		next =3D node->next;
> +		val |=3D node->locked;	/* preseve secondary queue */
This is wrong. node->locked can be 0, 1 or an encoded tail at this =
point, and
the latter case will be handled incorrectly.

Should be=20
		  if (node->locked) val =3D node->locked;
instead.

> +
> +	} else if (node->locked > 1) {
> +		/*
> +		 * When there are no local waiters on the primary queue, =
splice
> +		 * the secondary queue onto the primary queue and pass =
the lock
> +		 * to the longest waiting remote waiter.
> +		 */
> +		next =3D cna_splice_head(NULL, 0, node, next);
> +	}
> +
> +	arch_mcs_pass_lock(&next->locked, val);
> +}

Regards,
=E2=80=94 Alex
