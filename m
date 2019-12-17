From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/22] arm64: mte: Handle synchronous and asynchronous
 tag check faults
Date: Tue, 17 Dec 2019 18:01:52 +0000
Message-ID: <20191217180152.GO5624@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-14-catalin.marinas@arm.com>
 <CAMn1gO6RDrpkO6hygTUuXbsE5XTD+FEsZKpo5cqgg+nQWfBVKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMn1gO6RDrpkO6hygTUuXbsE5XTD+FEsZKpo5cqgg+nQWfBVKQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Collingbourne <pcc@google.com>
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, linux-mm@kvack.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, Kostya Serebryany <kcc@google.com>, Evgenii Stepanov <eugenis@google.com>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 13, 2019 at 05:43:15PM -0800, Peter Collingbourne wrote:
> On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index dd2cdc0d5be2..41fae64af82a 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -730,6 +730,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >         regs->regs[29] = (unsigned long)&user->next_frame->fp;
> >         regs->pc = (unsigned long)ka->sa.sa_handler;
> >
> > +       /* TCO (Tag Check Override) always cleared for signal handlers */
> > +       regs->pstate &= ~PSR_TCO_BIT;
> > +
> >         if (ka->sa.sa_flags & SA_RESTORER)
> >                 sigtramp = ka->sa.sa_restorer;
> >         else
> > @@ -921,6 +924,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> >                         if (thread_flags & _TIF_UPROBE)
> >                                 uprobe_notify_resume(regs);
> >
> > +                       if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> > +                               clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> > +                               force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);
> 
> In the case where the kernel is entered due to a syscall, this will
> inject a signal, but only after servicing the syscall. This means
> that, for example, if the syscall is exit(), the async tag check
> failure will be silently ignored. I can reproduce the problem with the
> program below:
[...]
> This patch fixes the problem for me:
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a9d98a443fc..d0c8918dee00 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -94,6 +94,8 @@ static void el0_svc_common(struct pt_regs *regs, int
> scno, int sc_nr,
>                            const syscall_fn_t syscall_table[])
>  {
>         unsigned long flags = current_thread_info()->flags;
> +       if (flags & _TIF_MTE_ASYNC_FAULT)
> +               return;

It needs a bit of thinking. This one wouldn't work if you want to handle
the signal and resume since it would skip the SVC instruction. We'd need
at least to do a regs->pc -= 4 and probably move it further down in this
function.

-- 
Catalin
