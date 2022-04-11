Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD5C4332F
	for <linux-arch@archiver.kernel.org>; Mon, 11 Apr 2022 09:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbiDKJni (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbiDKJnF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 05:43:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FAFA33E83;
        Mon, 11 Apr 2022 02:40:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF2B1691;
        Mon, 11 Apr 2022 02:40:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D7E83F73B;
        Mon, 11 Apr 2022 02:40:50 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:40:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, peterz@infradead.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: atomic: Add custom atomic.h implementation
Message-ID: <YlP3ngtgfaQeq5Q9@FVFF77S0Q05N>
References: <20220406125436.685264-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406125436.685264-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 06, 2022 at 08:54:36PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The generic atomic.h used cmpxchg to implement the atomic
> operations, it will cause daul loop to reduce the forward
> guarantee. The patch implement csky custom atomic operations with
> ldex/stex instructions for the best performance.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/include/asm/atomic.h | 251 +++++++++++++++++++++++++++++++++
>  1 file changed, 251 insertions(+)
>  create mode 100644 arch/csky/include/asm/atomic.h

> +static __always_inline							\
> +int arch_atomic_fetch_##op(int i, atomic_t *v)				\
> +{									\
> +	register int ret, tmp;						\
> +	__asm__ __volatile__ (						\
> +	"1:	ldex.w		%0, (%3) \n"				\
> +	ACQUIRE_FENCE							\
> +	"	mov		%1, %0   \n"				\
> +	"	" #op "		%0, %2   \n"				\
> +	RELEASE_FENCE							\
> +	"	stex.w		%0, (%3) \n"				\
> +	"	bez		%0, 1b   \n"				\
> +		: "=&r" (tmp), "=&r" (ret)				\
> +		: "r" (I), "r"(&v->counter) 				\
> +		: "memory");						\
> +	return ret;							\
> +}

I believe this suffers the problem described in:

  8e86f0b409a44193 ("arm64: atomics: fix use of acquire + release for full barrier semantics")

... and does not provide FULL ordering semantics.

Thanks,
Mark.
