Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439E1381.2060201@yahoo.com.au>
Date: Tue, 13 Dec 2005 11:19:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:

> +	/* set up my own style of waitqueue */
> +	waiter.task = tsk;
> +

Any reason why you're setting up your own style of waitqueue in
mutex-simple.c instead of just using the kernel's style of waitqueue?

> +
> +/*
> + * release a single token back to a mutex
> + * - entered with lock held and interrupts disabled
> + * - the queue will not be empty
> + */
> +void __up(struct mutex *mutex)
> +{
> +	struct mutex_waiter *waiter;
> +	struct task_struct *tsk;
> +
> +	/* grant the token to the process at the front of the queue */
> +	waiter = list_entry(mutex->wait_list.next, struct mutex_waiter, list);
> +
> +	/* we must be careful not to touch 'waiter' after we set ->task = NULL.
> +	 * - it is an allocated on the waiter's stack and may become invalid at
> +	 *   any time after that point (due to a wakeup from another source).
> +	 */
> +	list_del_init(&waiter->list);
> +	tsk = waiter->task;
> +#ifdef CONFIG_DEBUG_MUTEX_OWNER
> +	mutex->__owner = tsk;
> +#endif
> +	mb();

This should be smp_mb(), I think.

> +	waiter->task = NULL;
> +	wake_up_process(tsk);
> +	put_task_struct(tsk);
> +}

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
