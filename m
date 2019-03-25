Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731251AbfCYMmC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Mar 2019 08:42:02 -0400
Date: Mon, 25 Mar 2019 20:41:54 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Message-ID: <20190325124154.GA2653@guoren-Inspiron-7460>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
 <20190325121754.GB19244@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325121754.GB19244@altlinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, strace-devel@lists.strace.io, linux-kernel@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190325124154.t_D1f-htB6xYCg92ci54RcDkWyh87dNMrkqgw7lxXH4@z>

Thx Dmitry,

On Mon, Mar 25, 2019 at 03:17:54PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren@kernel.org wrote:
> [...]
> > diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
> > index a4eaa8d..9bf5b1a 100644
> > --- a/arch/csky/include/uapi/asm/ptrace.h
> > +++ b/arch/csky/include/uapi/asm/ptrace.h
> > @@ -62,6 +62,11 @@ struct user_fp {
> >  #define instruction_pointer(regs) ((regs)->pc)
> >  #define profile_pc(regs) instruction_pointer(regs)
> >  
> > +static inline unsigned long regs_return_value(struct pt_regs *regs)
> > +{
> > +	return regs->a0;
> > +}
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* _CSKY_PTRACE_H */
> 
> I wonder why we have this #ifdef __KERNEL__ code in the uapi namespace,
> it defeats the idea of uapi.  Doesn't it belong to non-uapi
> include/asm/ptrace.h namespace?

Yes, I should move __KERNEL__ codes into arch/csky/include/asm/ptrace.h.
But it'll be another patch for the modification. Any other problems?

Best Regards
 Guo Ren
