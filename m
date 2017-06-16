From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/5] arm64: signal: Allow expansion of the signal frame
Date: Fri, 16 Jun 2017 11:47:41 +0100
Message-ID: <20170616104740.GA31526@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbdFPKrp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Jun 2017 06:47:45 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 03:03:42PM +0100, Dave P Martin wrote:
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -41,9 +41,10 @@ struct sigcontext {
>   *
>   *	0x210		fpsimd_context
>   *	 0x10		esr_context
> + *	 0x20		extra_context (optional)
>   *	 0x10		terminator (null _aarch64_ctx)
>   *
> - *	0xdd0		(reserved for future allocation)
> + *	0xdb0		(reserved for future allocation)
>   *
>   * New records that can exceed this space need to be opt-in for userspace, so
>   * that an expanded signal frame is not generated unexpectedly.  The mechanism
> @@ -80,4 +81,39 @@ struct esr_context {
>  	__u64 esr;
>  };
>  
> +/*
> + * extra_context: describes extra space in the signal frame for
> + * additional structures that don't fit in sigcontext.__reserved[].
> + *
> + * Note:
> + *
> + * 1) fpsimd_context, esr_context and extra_context must be placed in
> + * sigcontext.__reserved[] if present.  They cannot be placed in the
> + * extra space.  Any other record can be placed either in the extra
> + * space or in sigcontext.__reserved[], unless otherwise specified in
> + * this file.
> + *
> + * 2) There must not be more than one extra_context.
> + *
> + * 3) If extra_context is present, it must be followed immediately in
> + * sigcontext.__reserved[] by the terminating null _aarch64_ctx.
> + *
> + * 4) The extra space to which data points must start at the first
> + * 16-byte aligned address immediately after the terminating null
> + * _aarch64_ctx that follows the extra_context structure in
> + * __reserved[].  The extra space may overrun the end of __reserved[],
> + * as indicated by a sufficiently large value for the size field.
> + *
> + * 5) The extra space must itself be terminated with a null
> + * _aarch64_ctx.
> + */
> +#define EXTRA_MAGIC	0x45585401
> +
> +struct extra_context {
> +	struct _aarch64_ctx head;
> +	void __user *data;	/* 16-byte aligned pointer to extra space */
> +	__u32 size;		/* size in bytes of the extra space */
> +	__u32 __reserved[3];
> +};

Some more thoughts on the type of "data" above. It's the first time we
introduce pointers in sigcontext and wonder whether __u64 would make
more sense (invariable size with the ABI).

Also for discussion - whether using an offset vs absolute address would
be better.

-- 
Catalin
