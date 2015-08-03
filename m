From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 3 Aug 2015 19:26:58 +0200
Message-ID: <20150803172658.GX25159@twins.programming.kicks-ass.net>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
 <1438621351-15912-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43558 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbHCR1D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2015 13:27:03 -0400
Content-Disposition: inline
In-Reply-To: <1438621351-15912-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org

On Mon, Aug 03, 2015 at 06:02:24PM +0100, Will Deacon wrote:
> +/*
> + * The idea here is to build acquire/release variants by adding explicit
> + * barriers on top of the relaxed variant. In the case where the relaxed
> + * variant is already fully ordered, no additional barriers are needed.
> + */
> +#define __atomic_op_acquire(ret_t, op, ...)				\
> +({									\
> +	ret_t __ret = op##_relaxed(__VA_ARGS__);			\

Do you really need ret_t? Can't we use typeof() on the expression?

> +	smp_mb__after_atomic();						\
> +	__ret;								\
> +})
