From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/refcount: Implement fast refcount_t handling
Date: Mon, 24 Apr 2017 12:45:39 +0200
Message-ID: <20170424104539.qa2jva2jytwboeam@hirez.programming.kicks-ass.net>
References: <20170421220939.GA65363@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168436AbdDXKqB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 06:46:01 -0400
Content-Disposition: inline
In-Reply-To: <20170421220939.GA65363@beast>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, davem@davemloft.net, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, PaX Team <pageexec@freemail.hu>

On Fri, Apr 21, 2017 at 03:09:39PM -0700, Kees Cook wrote:
> +static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
> +{
> +	const int a = 1;
> +	const int u = 0;
> +	int c, old;
> +
> +	c = atomic_read(&(r->refs));
> +	for (;;) {
> +		if (unlikely(c == (u)))
> +			break;
> +		old = atomic_cmpxchg(&(r->refs), c, c + (a));

Please use atomic_try_cmpxchg(), that generates saner code.

> +		if (likely(old == c))
> +			break;
> +		c = old;
> +	}
> +	return c != u;
> +}
