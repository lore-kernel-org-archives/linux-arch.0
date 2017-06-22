From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 2/5] arm64: signal: Refactor sigcontext parsing in
 rt_sigreturn
Date: Thu, 22 Jun 2017 22:32:35 +0300
Message-ID: <20170622193235.esxidcqcsz2zdpf2@yury-thinkpad>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:57700
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbdFVTcs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jun 2017 15:32:48 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

Hi Dave,

It seems that your series conflicts with one of patches of my ILP32:
https://patchwork.kernel.org/patch/9599015/

Now I try to rebase ilp32 on your patchset, and maybe will have some
questions. The first question is below. If you have comments on my
series - please share it.

Yury

On Thu, Jun 15, 2017 at 03:03:39PM +0100, Dave Martin wrote:
> Currently, rt_sigreturn does very limited checking on the
> sigcontext coming from userspace.
> 
> Future additions to the sigcontext data will increase the potential
> for surprises.  Also, it is not clear whether the sigcontext
> extension records are supposed to occur in a particular order.
> 
> To allow the parsing code to be extended more easily, this patch
> factors out the sigcontext parsing into a separate function, and
> adds extra checks to validate the well-formedness of the sigcontext
> structure.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

> +static int parse_user_sigframe(struct user_ctxs *user,
> +			       struct rt_sigframe __user *sf)

You parse sigcontext here in fact. At least you take the pointer to 
the sigcontext from rt_sigframe, and never refer it anymore. rt_sigframe
is different for lp64 and ilp32, but sigcontext is the same. So if you'll 
rename the function to parse_user_sigcontext, and will pass sigcontext
to it directly, I will reuse it in ilp32 code.

> +{
> +	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
> +	struct _aarch64_ctx __user *head =
> +		(struct _aarch64_ctx __user *)&sc->__reserved;
> +	size_t offset = 0;
> +
> +	user->fpsimd = NULL;
> +
> +	while (1) {
> +		int err;
> +		u32 magic, size;
> +
> +		head = (struct _aarch64_ctx __user *)&sc->__reserved[offset];
> +		if (!IS_ALIGNED((unsigned long)head, 16))
> +			goto invalid;
> +
> +		err = 0;
> +		__get_user_error(magic, &head->magic, err);
> +		__get_user_error(size, &head->size, err);
> +		if (err)
> +			return err;
> +
> +		switch (magic) {
> +		case 0:
> +			if (size)
> +				goto invalid;
> +
> +			goto done;
> +
> +		case FPSIMD_MAGIC:
> +			if (user->fpsimd)
> +				goto invalid;
> +
> +			if (offset > sizeof(sc->__reserved) -
> +					sizeof(*user->fpsimd) ||
> +			    size < sizeof(*user->fpsimd))
> +				goto invalid;
> +
> +			user->fpsimd = (struct fpsimd_context __user *)head;
> +			break;
> +
> +		case ESR_MAGIC:
> +			/* ignore */
> +			break;
> +
> +		default:
> +			goto invalid;
> +		}
> +
> +		if (size < sizeof(*head))
> +			goto invalid;
> +
> +		if (size > sizeof(sc->__reserved) - (sizeof(*head) + offset))
> +			goto invalid;
> +
> +		offset += size;
> +	}
> +
> +done:
> +	if (!user->fpsimd)
> +		goto invalid;
> +
> +	return 0;
> +
> +invalid:
> +	return -EINVAL;
> +}
> +
>  static int restore_sigframe(struct pt_regs *regs,
>  			    struct rt_sigframe __user *sf)
>  {
>  	sigset_t set;
>  	int i, err;
> -	void *aux = sf->uc.uc_mcontext.__reserved;
> +	struct user_ctxs user;
>  
>  	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
>  	if (err == 0)
> @@ -125,12 +200,11 @@ static int restore_sigframe(struct pt_regs *regs,
>  	regs->syscallno = ~0UL;
>  
>  	err |= !valid_user_regs(&regs->user_regs, current);
> +	if (err == 0)
> +		err = parse_user_sigframe(&user, sf);
>  
> -	if (err == 0) {
> -		struct fpsimd_context *fpsimd_ctx =
> -			container_of(aux, struct fpsimd_context, head);
> -		err |= restore_fpsimd_context(fpsimd_ctx);
> -	}
> +	if (err == 0)
> +		err = restore_fpsimd_context(user.fpsimd);
>  
>  	return err;
>  }
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
