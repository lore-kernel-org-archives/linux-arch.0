From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/29] asm-generic: add generic futex for
 !CONFIG_SMP
Date: Sat, 25 Oct 2014 22:50:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410252243110.5308@nanos>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <1414139071-3818-2-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51156 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaJYUud (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Oct 2014 16:50:33 -0400
In-Reply-To: <1414139071-3818-2-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, lftan.linux@gmail.com, cltang@codesourcery.com, Peter Zijlstra <peterz@infradead.org>

B1;2802;0cOn Fri, 24 Oct 2014, Ley Foon Tan wrote:
> +#ifndef CONFIG_SMP
> +static inline int
> +futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)

If we add this to the generic code we want to have a proper docbook
comment describing the function.

> +{
> +	int op = (encoded_op >> 28) & 7;
> +	int cmp = (encoded_op >> 24) & 15;
> +	int oparg = (encoded_op << 8) >> 20;
> +	int cmparg = (encoded_op << 20) >> 20;
> +	int oldval, ret;
> +	u32 tmp;
> +
> +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
> +		oparg = 1 << oparg;
> +
> +	pagefault_disable();	/* implies preempt_disable() */

Now this mindlessly copied comment does not have any real value.

1) That pagefault_disable() implies preempt_disable() is an
   implementation detail which is not guaranteed to be true forever.

2) It's not telling at all, that this code really relies on both
   pagefault AND preemption being disabled.

> +
> +static inline int
> +futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> +			      u32 oldval, u32 newval)
> +{

Docbook comment missing as well. But what's worse is, that it does not
explain what the calling convention for this function is.

As above it requires both pagefault AND preemption being disabled. The
fact that both are the same are again just an implementation detail of
todays code ....

> +	u32 val;
> +
> +	if (unlikely(get_user(val, uaddr) != 0))
> +		return -EFAULT;
> +
> +	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
> +		return -EFAULT;
> +
> +	*uval = val;
> +
> +	return 0;
> +}

Thanks,

	tglx
