From: Guo Ren <guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Date: Mon, 25 Mar 2019 20:41:54 +0800
Message-ID: <20190325124154.GA2653@guoren-Inspiron-7460>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
 <20190325121754.GB19244@altlinux.org>
Reply-To: strace development discussions <strace-devel-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <strace-devel-bounces-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190325121754.GB19244-u2l5PoMzF/Vg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.strace.io/mailman/options/strace-devel>,
 <mailto:strace-devel-request-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.strace.io/pipermail/strace-devel/>
List-Post: <mailto:strace-devel-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org>
List-Help: <mailto:strace-devel-request-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.strace.io/mailman/listinfo/strace-devel>,
 <mailto:strace-devel-request-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org?subject=subscribe>
Errors-To: strace-devel-bounces-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org
Sender: "Strace-devel" <strace-devel-bounces-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org>
To: "Dmitry V. Levin" <ldv-u2l5PoMzF/Vg9hUCZPvPmw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, strace-devel-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Thx Dmitry,

On Mon, Mar 25, 2019 at 03:17:54PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org wrote:
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
-- 
Strace-devel mailing list
Strace-devel-3+4lAyCyj6AWlMsSdNXQLw@public.gmane.org
https://lists.strace.io/mailman/listinfo/strace-devel
