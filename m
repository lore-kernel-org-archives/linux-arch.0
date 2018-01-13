From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
Date: Sat, 13 Jan 2018 15:06:09 -0600
Message-ID: <878td1xyda.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-4-ebiederm@xmission.com>
        <20180112222944.GA22642@ls3530.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:52577 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeAMVHC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jan 2018 16:07:02 -0500
In-Reply-To: <20180112222944.GA22642@ls3530.fritz.box> (Helge Deller's message
        of "Fri, 12 Jan 2018 23:29:44 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> * Eric W. Biederman <ebiederm@xmission.com>:
>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>> This is the same si_code as SI_USER.  Posix and common sense requires
>> that SI_USER not be a signal specific si_code.  As such this use of 0
>> for the si_code is a pretty horribly broken ABI.
>> 
>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>> that uid and pid fields are copied and which might copying the si_addr
>> field by accident but certainly not by design.  Making this a very
>> flakey implementation.
>> 
>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>> appropriate fields will reliably be copied.
>> 
>> This bug is 13 years old and parsic machines are no longer being built
>> so I don't know if it possible or worth fixing it.  But it is at least
>> worth documenting this so other architectures don't make the same
>> mistake.
>
>
> I think we should fix it, even if we now break the ABI.
>
> It's about a "conditional trap" which needs to be handled by userspace.
> I doubt there is any Linux code out which is utilizing this
> parisc-specific trap.
>
> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
> While at it, maybe we should include the already existing FPE_MDAOVF
> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
> can go completely.
>
> Suggested patch is below.
>
> I'm willing to test the patch below on the parisc architecture for a few
> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
> looking at then too.
>
> Thoughts?

I like it.

We have the option of bringing either the ia64 or the frv si_codes
into the generic fold.  Is there any reason you choose frv?
Last I looked ia64 tended in many aspects to be well thought out,
and thus worth a careful look.

Given that a couple of weeks likely puts on the other side of the merge
window I would like to start with my patch so I can close the potential
copying of unitialized memory to userspace.  Then we can build yours on
top.

Although I am more than happy to add new si_codes now.

What I am in the final stages of testing and reviewing internally is the
change to merge all of struct siginfo, struct compat_siginfo,
copy_siginfo_from_user32 and copy_siginfo_to_user32 together.

I need another couple hours and I will be ready to post that.

For long term maintenance the more we can merge together the better,
as clearly some of these bugs have persisted far too long.  And getting
collapsing the arch specific si_codes into just a set of si_codes
looks like one more good step in that direction.

Eric


> Helge
>
>
>
> [PATCH] parisc: Add FPE_CONDTRAP for conditional trap handling
>
> Posix and common sense requires that SI_USER not be a signal specific
> si_code.  Thus add a new FPE_CONDTRAP si_code for conditional traps.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index 8453724b8009..13702f0f5ba1 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -627,9 +627,9 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
>  		   on condition  */
>  		if(user_mode(regs)){
>  			si.si_signo = SIGFPE;
> -			/* Set to zero, and let the userspace app figure it out from
> -			   the insn pointed to by si_addr */
> -			si.si_code = 0;
> +			/* Let userspace app figure out from the insn pointed
> +			 * to by si_addr */
> +			si.si_code = FPE_CONDTRAP;
>  			si.si_addr = (void __user *) regs->iaoq[0];
>  			force_sig_info(SIGFPE, &si, current);
>  			return;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index e447283b8f52..2b759fe42142 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -193,7 +193,9 @@ typedef struct siginfo {
>  #define FPE_FLTRES	6	/* floating point inexact result */
>  #define FPE_FLTINV	7	/* floating point invalid operation */
>  #define FPE_FLTSUB	8	/* subscript out of range */
> -#define NSIGFPE		8
> +#define FPE_MDAOVF	9       /* media overflow */
> +#define FPE_CONDTRAP	10      /* trap on condition */
> +#define NSIGFPE		10
>  
>  /*
>   * SIGSEGV si_codes
