Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46989 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182AbaGOKDc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 06:03:32 -0400
Date: Tue, 15 Jul 2014 12:03:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 21/29] nios2: Futex operations
In-Reply-To: <1405413956-2772-22-git-send-email-lftan@altera.com>
Message-ID: <alpine.DEB.2.10.1407151201170.24854@nanos>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-22-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715100328.2c_qmCTXUyaeeslwNkmL8-jCaQ8GCXAhHJNVmWKmHdg@z>

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
