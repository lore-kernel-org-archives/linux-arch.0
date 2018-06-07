Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753037AbeFGLhK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 07:37:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57BYWwY033041
        for <linux-arch@vger.kernel.org>; Thu, 7 Jun 2018 07:37:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf3kh8sd3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 07:37:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 12:37:07 +0100
Date: Thu, 07 Jun 2018 17:07:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812783350.10068.4690566636762511152.stgit@devbox>
In-Reply-To: <152812783350.10068.4690566636762511152.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Message-ID: <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20180607113700.urlaYxLa4PSs5bkse3_HS-IM-gDnxTw2cqUdcWk7_aU@z>

Masami Hiramatsu wrote:
> Don't call the ->break_handler() from the arm kprobes code,
					    ^^^ powerpc

> because it was only used by jprobes which got removed.
> 
> This also makes skip_singlestep() a static function since
> only ftrace-kprobe.c is using this function.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/kprobes.h   |   10 ----------
>  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
>  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
>  3 files changed, 14 insertions(+), 43 deletions(-)

With 2 small comments...
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen

> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 674036db558b..785c464b6588 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>  extern int kprobe_handler(struct pt_regs *regs);
>  extern int kprobe_post_handler(struct pt_regs *regs);
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -			   struct kprobe_ctlblk *kcb);
> -#else
> -static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -				  struct kprobe_ctlblk *kcb)
> -{
> -	return 0;
> -}
> -#endif
>  #else
>  static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
>  static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 1b316331c2d9..3869b0e5d5c7 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -26,8 +26,8 @@
>  #include <linux/ftrace.h>
> 
>  static nokprobe_inline
> -int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
> +int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> +		    struct kprobe_ctlblk *kcb, unsigned long orig_nip)
>  {
>  	/*
>  	 * Emulate singlestep (and also recover regs->nip)
> @@ -44,16 +44,6 @@ int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
>  	return 1;
>  }
> 
> -int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -		    struct kprobe_ctlblk *kcb)
> -{
> -	if (kprobe_ftrace(p))
> -		return __skip_singlestep(p, regs, kcb, 0);
> -	else
> -		return 0;
> -}
> -NOKPROBE_SYMBOL(skip_singlestep);
> -
>  /* Ftrace callback handler for kprobes */
>  void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  			   struct ftrace_ops *ops, struct pt_regs *regs)
> @@ -82,7 +72,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		__this_cpu_write(current_kprobe, p);
>  		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  		if (!p->pre_handler || !p->pre_handler(p, regs))
> -			__skip_singlestep(p, regs, kcb, orig_nip);
> +			skip_singlestep(p, regs, kcb, orig_nip);

We can probably get rid of skip_singlestep() completely along with 
orig_nip since instructions are always 4 bytes on powerpc. So, the 
changes we do to nip should help to recover the value automatically.

- Naveen
