From: Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 2/14] alpha: use generic ptrace_resume code
Date: Tue, 2 Feb 2010 23:35:42 -0500
Message-ID: <b4198de61002022035s3111a07ctf6aa94bbf2088c08@mail.gmail.com>
References: <20100202185755.GA3630@lst.de> <20100202185837.GB3630@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:58268 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0BCEfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 23:35:43 -0500
In-Reply-To: <20100202185837.GB3630@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, ink@jurassic.park.msu.ru, rth@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Feb 2, 2010 at 1:58 PM, Christoph Hellwig <hch@lst.de> wrote:
> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
> PTRACE_KILL and PTRACE_SINGLESTEP. =A0This implies defining
> arch_has_single_step in <asm/ptrace.h> and implementing the
> user_enable_single_step and user_disable_single_step functions, which
> also causes the breakpoint information to be cleared on fork, which
> could be considered a bug fix.
>
> Also the TIF_SYSCALL_TRACE thread flag is now cleared on PTRACE_KILL
> which it previously wasn't, which is consistent with all architecture=
s
> using the modern ptrace code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Index: linux-2.6/arch/alpha/kernel/ptrace.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/alpha/kernel/ptrace.c =A0 2010-02-02 11:05:03=
=2E197004058 +0100
> +++ linux-2.6/arch/alpha/kernel/ptrace.c =A0 =A0 =A0 =A02010-02-02 11=
:07:04.091006019 +0100
> @@ -249,6 +249,17 @@ ptrace_cancel_bpt(struct task_struct * c
> =A0 =A0 =A0 =A0return (nsaved !=3D 0);
> =A0}
>
> +void user_enable_single_step(struct task_struct *child)
> +{
> + =A0 =A0 =A0 /* Mark single stepping. =A0*/
> + =A0 =A0 =A0 task_thread_info(child)->bpt_nsaved =3D -1;
> +}
> +
> +void user_disable_single_step(struct task_struct *child)
> +{
> + =A0 =A0 =A0 ptrace_cancel_bpt(child);
> +}
> +
> =A0/*
> =A0* Called by kernel/ptrace.c when detaching..
> =A0*
> @@ -256,7 +267,7 @@ ptrace_cancel_bpt(struct task_struct * c
> =A0*/
> =A0void ptrace_disable(struct task_struct *child)
> =A0{
> - =A0 =A0 =A0 ptrace_cancel_bpt(child);
> + =A0 =A0 =A0 user_disable_single_step(child);
> =A0}
>
> =A0long arch_ptrace(struct task_struct *child, long request, long add=
r, long data)
> @@ -289,52 +300,6 @@ long arch_ptrace(struct task_struct *chi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG(DBG_MEM, ("poke $%ld<-%#lx\n", add=
r, data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D put_reg(child, addr, data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> -
> - =A0 =A0 =A0 case PTRACE_SYSCALL:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* continue and stop at next (return fr=
om) syscall */
> - =A0 =A0 =A0 case PTRACE_CONT: =A0 =A0/* restart after signal. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!valid_signal(data))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (request =3D=3D PTRACE_SYSCALL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_tsk_thread_flag(chi=
ld, TIF_SYSCALL_TRACE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_tsk_thread_flag(c=
hild, TIF_SYSCALL_TRACE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child->exit_code =3D data;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure single-step breakpoint is =
gone. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptrace_cancel_bpt(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_process(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Make the child exit. =A0Best I can do is send it a=
 sigkill.
> - =A0 =A0 =A0 =A0* perhaps it should be put in the status that it wan=
ts to
> - =A0 =A0 =A0 =A0* exit.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 case PTRACE_KILL:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (child->exit_state =3D=3D EXIT_ZOMBI=
E)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child->exit_code =3D SIGKILL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure single-step breakpoint is =
gone. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptrace_cancel_bpt(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_process(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 case PTRACE_SINGLESTEP: =A0/* execute single instructio=
n. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!valid_signal(data))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mark single stepping. =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 task_thread_info(child)->bpt_nsaved =3D=
 -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_tsk_thread_flag(child, TIF_SYSCAL=
L_TRACE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child->exit_code =3D data;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_process(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* give it a chance to run. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D ptrace_request(child, request,=
 addr, data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> Index: linux-2.6/arch/alpha/include/asm/ptrace.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/alpha/include/asm/ptrace.h =A0 =A0 =A02010-02=
-02 11:07:29.091023600 +0100
> +++ linux-2.6/arch/alpha/include/asm/ptrace.h =A0 2010-02-02 11:07:38=
=2E645007248 +0100
> @@ -68,6 +68,7 @@ struct switch_stack {
>
> =A0#ifdef __KERNEL__
>
> +#define arch_has_single_step() =A0 =A0 =A0 =A0 (1)
> =A0#define user_mode(regs) (((regs)->ps & 8) !=3D 0)
> =A0#define instruction_pointer(regs) ((regs)->pc)
> =A0#define profile_pc(regs) instruction_pointer(regs)
>

Acked-by: Matt Turner <mattst88@gmail.com>
