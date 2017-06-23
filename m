From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 2/5] arm64: signal: Refactor sigcontext parsing in
 rt_sigreturn
Date: Fri, 23 Jun 2017 10:48:59 +0100
Message-ID: <20170623094857.GF8543@e103592.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
 <20170622193235.esxidcqcsz2zdpf2@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754504AbdFWJtD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jun 2017 05:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20170622193235.esxidcqcsz2zdpf2@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 22, 2017 at 10:32:35PM +0300, Yury Norov wrote:
> Hi Dave,
> 
> It seems that your series conflicts with one of patches of my ILP32:
> https://patchwork.kernel.org/patch/9599015/
> 
> Now I try to rebase ilp32 on your patchset, and maybe will have some
> questions. The first question is below. If you have comments on my
> series - please share it.
> 
> Yury
> 
> On Thu, Jun 15, 2017 at 03:03:39PM +0100, Dave Martin wrote:
> > Currently, rt_sigreturn does very limited checking on the
> > sigcontext coming from userspace.
> > 
> > Future additions to the sigcontext data will increase the potential
> > for surprises.  Also, it is not clear whether the sigcontext
> > extension records are supposed to occur in a particular order.
> > 
> > To allow the parsing code to be extended more easily, this patch
> > factors out the sigcontext parsing into a separate function, and
> > adds extra checks to validate the well-formedness of the sigcontext
> > structure.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> > +static int parse_user_sigframe(struct user_ctxs *user,
> > +			       struct rt_sigframe __user *sf)
> 
> You parse sigcontext here in fact. At least you take the pointer to 

That's a fair point...

> the sigcontext from rt_sigframe, and never refer it anymore. rt_sigframe

...however, the final patch [1] (which has not appeared in next yet,
I need to chase it) does refer to the sigframe base in order to
determine when the signal frame exceeds the maximum allowed size.

> is different for lp64 and ilp32, but sigcontext is the same. So if you'll 
> rename the function to parse_user_sigcontext, and will pass sigcontext
> to it directly, I will reuse it in ilp32 code.

Because the rt_sigframe pointer is _only_ used as a base address, the
rt_sigframe definition is not relevant.  So a refactoring along lines of
[2] might work.

Other things that may need attention are the handling of the extra_data
pointer [2] (I changed this from void __user * to u64 after Catalin
pointed out the ABI dependency here), and the way the {fp,lr} frame
record is handled.

I think the RT_SIGFRAME_FP_POS() logic can probably be simplified/
dropped: this is now handled through
rt_sigframe_user_layout.next_frame.  ILP32 would need its own version
of sigframe_size(), or that function should test for current being
ILP32, but the ILP32 equivalent of get_sigframe() would probably look
very similar to the native version after my patches.

(Note that I've not understood the proposed ILP32 signal changes in
detail at this point.)

Cheers
---Dave

[1] [PATCH] arm64: signal: Allow expansion of the signal frame
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/514699.html

[2] [RFC PATCH] arm64: signal: Make parse_user_sigframe() independent of rt_sigframe layout
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/515361.html

> 
> > +{
> > +	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
> > +	struct _aarch64_ctx __user *head =
> > +		(struct _aarch64_ctx __user *)&sc->__reserved;
> > +	size_t offset = 0;
> > +
> > +	user->fpsimd = NULL;
> > +
> > +	while (1) {
> > +		int err;
> > +		u32 magic, size;
> > +
> > +		head = (struct _aarch64_ctx __user *)&sc->__reserved[offset];
> > +		if (!IS_ALIGNED((unsigned long)head, 16))
> > +			goto invalid;
> > +
> > +		err = 0;
> > +		__get_user_error(magic, &head->magic, err);
> > +		__get_user_error(size, &head->size, err);
> > +		if (err)
> > +			return err;
> > +
> > +		switch (magic) {
> > +		case 0:
> > +			if (size)
> > +				goto invalid;
> > +
> > +			goto done;
> > +
> > +		case FPSIMD_MAGIC:
> > +			if (user->fpsimd)
> > +				goto invalid;
> > +
> > +			if (offset > sizeof(sc->__reserved) -
> > +					sizeof(*user->fpsimd) ||
> > +			    size < sizeof(*user->fpsimd))
> > +				goto invalid;
> > +
> > +			user->fpsimd = (struct fpsimd_context __user *)head;
> > +			break;
> > +
> > +		case ESR_MAGIC:
> > +			/* ignore */
> > +			break;
> > +
> > +		default:
> > +			goto invalid;
> > +		}
> > +
> > +		if (size < sizeof(*head))
> > +			goto invalid;
> > +
> > +		if (size > sizeof(sc->__reserved) - (sizeof(*head) + offset))
> > +			goto invalid;
> > +
> > +		offset += size;
> > +	}
> > +
> > +done:
> > +	if (!user->fpsimd)
> > +		goto invalid;
> > +
> > +	return 0;
> > +
> > +invalid:
> > +	return -EINVAL;
> > +}
> > +
> >  static int restore_sigframe(struct pt_regs *regs,
> >  			    struct rt_sigframe __user *sf)
> >  {
> >  	sigset_t set;
> >  	int i, err;
> > -	void *aux = sf->uc.uc_mcontext.__reserved;
> > +	struct user_ctxs user;
> >  
> >  	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
> >  	if (err == 0)
> > @@ -125,12 +200,11 @@ static int restore_sigframe(struct pt_regs *regs,
> >  	regs->syscallno = ~0UL;
> >  
> >  	err |= !valid_user_regs(&regs->user_regs, current);
> > +	if (err == 0)
> > +		err = parse_user_sigframe(&user, sf);
> >  
> > -	if (err == 0) {
> > -		struct fpsimd_context *fpsimd_ctx =
> > -			container_of(aux, struct fpsimd_context, head);
> > -		err |= restore_fpsimd_context(fpsimd_ctx);
> > -	}
> > +	if (err == 0)
> > +		err = restore_fpsimd_context(user.fpsimd);
> >  
> >  	return err;
> >  }
> > -- 
> > 2.1.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
