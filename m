Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408951AbfJRQDN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:03:13 -0400
Subject: Re: [PATCH v5 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20191016042903.61081-1-alex.kogan@oracle.com>
 <20191016042903.61081-4-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <6ce50aeb-6b87-5d1c-9011-4329e8dadfec@redhat.com>
Date: Fri, 18 Oct 2019 12:03:10 -0400
MIME-Version: 1.0
In-Reply-To: <20191016042903.61081-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20191018160310.gBrLGJGR4wUk9TVVvyIuIXI92V2fUNGfYTXP0n6b9S4@z>

On 10/16/19 12:29 AM, Alex Kogan wrote:
> +static inline void cna_pass_lock(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +	struct mcs_spinlock *next_holder = next, *tail_2nd;
> +	u32 val = 1;
> +
> +	u32 scan = cn->pre_scan_result;
> +
> +	/*
> +	 * check if a successor from the same numa node has not been found in
> +	 * pre-scan, and if so, try to find it in post-scan starting from the
> +	 * node where pre-scan stopped (stored in @pre_scan_result)
> +	 */
> +	if (scan > 0)
> +		scan = cna_scan_main_queue(node, decode_tail(scan));
> +
> +	if (!scan) { /* if found a successor from the same numa node */
> +		next_holder = node->next;
> +		/*
> +		 * make sure @val gets 1 if current holder's @locked is 0 as
> +		 * we have to store a non-zero value in successor's @locked
> +		 * to pass the lock
> +		 */
> +		val = node->locked + (node->locked == 0);

node->locked can be 0 when the cpu enters into an empty MCS queue. We
could unconditionally set node->locked to 1 for this case in qspinlock.c
or with your above code. Perhaps, a comment about when node->locked will
be 0.

It may be easier to understand if you just do

    val = node->locked ? node->locked : 1;

Cheers,
Longman
