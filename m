From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 21/29] nios2: Futex operations
Date: Tue, 15 Jul 2014 12:03:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407151201170.24854@nanos>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-22-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-22-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tue, 15 Jul 2014, Ley Foon Tan wrote:
 +static inline int atomic_futex_op_xchg_set(int oparg, u32 __user *uaddr,
> +					   int *oldval)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	local_irq_save(flags);
> +
> +	ret = get_user(*oldval, uaddr);
> +	if (!ret)
> +		ret = put_user(oparg, uaddr);

This is wrong as it gets. get_user() might fault and sleep.

You need a proper implementation, which handles fault exceptions.

Thanks,

	tglx
