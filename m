From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH 06/40] blackfin: Use set_current_blocked() and block_sigmask()
Date: Thu, 16 Feb 2012 17:28:54 +0800
Message-ID: <CAA_GA1efV+DMrvKF2N5TMQ_1XaGyJM7h4jMUaaFka5XqBNDb7g@mail.gmail.com>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
	<1329219673-28711-7-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48173 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab2BPJ2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2012 04:28:55 -0500
In-Reply-To: <1329219673-28711-7-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, uclinux-dist-devel@blackfin.uclinux.org

On Tue, Feb 14, 2012 at 7:40 PM, Matt Fleming <matt@console-pimps.org> =
wrote:
> From: Matt Fleming <matt.fleming@intel.com>
>
> As described in e6fa16ab ("signal: sigprocmask() should do
> retarget_shared_pending()") the modification of current->blocked is
> incorrect as we need to check whether the signal we're about to block
> is pending in the shared queue.
>
> Also, use the new helper function introduced in commit 5e6292c0f28f
> ("signal: add block_sigmask() for adding sigmask to current->blocked"=
)
> which centralises the code for updating current->blocked after
> successfully delivering a signal and reduces the amount of duplicate
> code across architectures. In the past some architectures got this
> code wrong, so using this helper function should stop that from
> happening again.
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
> =C2=A0arch/blackfin/kernel/signal.c | =C2=A0 17 ++++-------------
> =C2=A01 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/arch/blackfin/kernel/signal.c b/arch/blackfin/kernel/sig=
nal.c
> index d536f35..05ece02 100644
> --- a/arch/blackfin/kernel/signal.c
> +++ b/arch/blackfin/kernel/signal.c
> @@ -99,10 +99,7 @@ asmlinkage int do_rt_sigreturn(unsigned long __unu=
sed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto badframe;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sigdelsetmask(&set, ~_BLOCKABLE);
> - =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&current->sighand->siglock);
> - =C2=A0 =C2=A0 =C2=A0 current->blocked =3D set;
> - =C2=A0 =C2=A0 =C2=A0 recalc_sigpending();
> - =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&current->sighand->siglock);
> + =C2=A0 =C2=A0 =C2=A0 set_current_blocked(&set);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rt_restore_sigcontext(regs, &frame->uc=
=2Euc_mcontext, &r0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto badframe;
> @@ -266,15 +263,9 @@ handle_signal(int sig, siginfo_t *info, struct k=
_sigaction *ka,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set up the stack frame */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D setup_rt_frame(sig, ka, info, olds=
et, regs);
>
> - =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&cur=
rent->sighand->siglock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sigorsets(&current=
->blocked, &current->blocked,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &ka->sa.sa_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(ka->sa.sa_fl=
ags & SA_NODEFER))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sigaddset(&current->blocked, sig);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recalc_sigpending(=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&c=
urrent->sighand->siglock);
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_sigmask(ka, =
sig);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>

Thanks. I'll apply it.

--=20
Regards,
--Bob
