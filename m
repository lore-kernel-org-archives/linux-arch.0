Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58188 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaDQP5F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 11:57:05 -0400
Date: Thu, 17 Apr 2014 17:56:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Message-ID: <20140417155649.GR11096@twins.programming.kicks-ass.net>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
 <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140417155649.vS4LkENy8kfT7pKmPmeU4WTqNjss43wkV9F11DVcgrE@z>

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
