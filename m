From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Wed, 18 May 2016 19:32:18 +0200
Message-ID: <20160518173218.GE3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 18, 2016 at 04:10:59PM +0100, David Howells wrote:
> +/**
> + * __atomic_add_unless - add unless the number is already a given value
> + * @v: pointer of type atomic_t
> + * @a: the amount to add to v...
> + * @u: ...unless v is equal to u.
> + *
> + * Atomically adds @a to @v, so long as @v was not already @u.
> + * Returns the old value of @v.
> + */
> +static __always_inline int __atomic_add_unless(atomic_t *v,
> +					       int addend, int unless)
> +{
> +	int c = atomic_read(v);
> +
> +	while (likely(c != unless)) {
> +		if (__atomic_compare_exchange_n(&v->counter,
> +						&c, c + addend,
> +						false,
> +						__ATOMIC_SEQ_CST,
> +						__ATOMIC_RELAXED))
> +			break;
> +	}
> +	return c;
> +}

Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
loop and not a loop around an LL/SC cmpxchg.
