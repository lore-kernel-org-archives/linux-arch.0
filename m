From: Waiman Long <Waiman.Long@hp.com>
Subject: Re: [PATCH v2 2/3] mutex: Queue mutex spinners with MCS lock to reduce
 cacheline contention
Date: Tue, 16 Apr 2013 08:05:21 -0400
Message-ID: <516D3E81.6060307@hp.com>
References: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>  <1366036679-9702-3-git-send-email-Waiman.Long@hp.com> <1366086275.22463.25.camel@buesod1.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:6350 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab3DPMF3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 08:05:29 -0400
In-Reply-To: <1366086275.22463.25.camel@buesod1.americas.hpqcorp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <davidlohr.bueso@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>

On 04/16/2013 12:24 AM, Davidlohr Bueso wrote:
> On Mon, 2013-04-15 at 10:37 -0400, Waiman Long wrote:
> [...]
>> +typedef struct mspin_node {
>> +	struct mspin_node *next;
>> +	int		   locked;	/* 1 if lock acquired */
>> +} mspin_node_t;
>> +
>> +typedef mspin_node_t	*mspin_lock_t;
> I think we could do without the typedefs, specially mspin_lock_t.
Yes, we can do without the typedefs.

>> +
>> +#define	MLOCK(mutex)	((mspin_lock_t *)&((mutex)->spin_mlock))
>> +
>> +static noinline void mspin_lock(mspin_lock_t *lock,  mspin_node_t *node)
>> +{
>> +	mspin_node_t *prev;
>> +
>> +	/* Init node */
>> +	node->locked = 0;
>> +	node->next   = NULL;
>> +
>> +	prev = xchg(lock, node);
>> +	if (likely(prev == NULL)) {
>> +		/* Lock acquired */
>> +		node->locked = 1;
>> +		return;
>> +	}
>> +	ACCESS_ONCE(prev->next) = node;
>> +	smp_wmb();
>> +	/* Wait until the lock holder passes the lock down */
>> +	while (!ACCESS_ONCE(node->locked))
>> +		arch_mutex_cpu_relax();
>> +}
>> +
>> +static void mspin_unlock(mspin_lock_t *lock,  mspin_node_t *node)
>> +{
>> +	mspin_node_t *next = ACCESS_ONCE(node->next);
>> +
>> +	if (likely(!next)) {
>> +		/*
>> +		 * Release the lock by setting it to NULL
>> +		 */
>> +		if (cmpxchg(lock, node, NULL) == node)
>> +			return;
>> +		/* Wait until the next pointer is set */
>> +		while (!(next = ACCESS_ONCE(node->next)))
>> +			arch_mutex_cpu_relax();
>> +	}
>> +	barrier();
>> +	ACCESS_ONCE(next->locked) = 1;
>> +	smp_wmb();
> Do we really need the compiler barrier call? The CPUs can reorder
> anyway. I assume the smp_wbm() call makes sure no there's no funny
> business before the next lock is acquired, might be worth commenting.

The smp_wmb() calls are to make sure that the writes are committed to 
memory rather than staying in the cache only. They are safety measures. 
The barrier() call probably is not needed because of the next pointer 
data dependency, but it doesn't have an actual cost either as it doesn't 
translate to any instruction.

Regards,
Longman
