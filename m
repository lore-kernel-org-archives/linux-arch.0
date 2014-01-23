From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 1/4] qrwlock: A queue read/write lock implementation
Date: Thu, 23 Jan 2014 11:07:51 +0100
Message-ID: <20140123100751.GS30183@twins.programming.kicks-ass.net>
References: <1390426438-31252-1-git-send-email-Waiman.Long@hp.com>
 <1390426438-31252-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55995 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaAWKIa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2014 05:08:30 -0500
Content-Disposition: inline
In-Reply-To: <1390426438-31252-2-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Aswin Chandramouleeswaran\"" <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

On Wed, Jan 22, 2014 at 04:33:55PM -0500, Waiman Long wrote:
> +/**
> + * queue_read_unlock - release read lock of a queue rwlock
> + * @lock : Pointer to queue rwlock structure
> + */
> +static inline void queue_read_unlock(struct qrwlock *lock)
> +{
> +	/*
> +	 * Atomically decrement the reader count
> +	 */
> +	atomic_sub(_QR_BIAS, &lock->cnts.rwa);
> +}
> +
> +/**
> + * queue_write_unlock - release write lock of a queue rwlock
> + * @lock : Pointer to queue rwlock structure
> + */
> +static inline void queue_write_unlock(struct qrwlock *lock)
> +{
> +	/*
> +	 * If the writer field is atomic, it can be cleared directly.
> +	 * Otherwise, an atomic subtraction will be used to clear it.
> +	 */
> +	if (__native_word(lock->cnts.writer))
> +		smp_store_release(&lock->cnts.writer, 0);
> +	else
> +		atomic_sub(_QW_LOCKED, &lock->cnts.rwa);
> +}

Both these unlocks miss a barrier; atomic_sub() doesn't imply any
barrier what so ever.

The smp_store_release() does, but the other two are invalid release ops
in generic.
