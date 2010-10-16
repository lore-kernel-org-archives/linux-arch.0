From: Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [PATCH 3/5] mips: sanitize restart logics
Date: Fri, 15 Oct 2010 22:24:44 -0600
Message-ID: <AANLkTi=ZVzfoBixM8YdXa82FLAWyKcKjz0_qbo5ThuDa@mail.gmail.com>
References: <E1P0eK5-0006j5-4q@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41844 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0JPEYq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Oct 2010 00:24:46 -0400
In-Reply-To: <E1P0eK5-0006j5-4q@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Sep 28, 2010 at 11:50 AM, Al Viro <viro@ftp.linux.org.uk> wrote=
:
>
> Put the original syscall number into ->regs[0] when we leave syscall
> with error. =A0Use it in restart logics. =A0Everything else will have
> it 0 since we pass through SAVE_SOME on all the ways in. =A0Note that
> in places like bad_stack and inllegal_syscall we leave it 0 - it's
> not restartable.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Building 2.6.36-rc8 on a 32-bit mipsel system gives me
the following compile failure:

  LD      .tmp_vmlinux1
arch/mips/built-in.o:/home/shane/linux-mips.org/linux/arch/mips/kernel/=
scall32-o32.S:66:
undefined reference to `PR_R2'
arch/mips/built-in.o:/home/shane/linux-mips.org/linux/arch/mips/kernel/=
scall32-o32.S:66:
undefined reference to `PR_R2'
make: *** [.tmp_vmlinux1] Error 1

I tracked it down to this patch.  In particular, I believe the change
to scall32-o32.S is causing the problem.

> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall3=
2-o32.S
> index 17202bb..d3edb9f 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -63,9 +63,9 @@ stack_done:
> =A0 =A0 =A0 =A0sw =A0 =A0 =A0t0, PT_R7(sp) =A0 =A0 =A0 =A0 =A0 # set =
error flag
> =A0 =A0 =A0 =A0beqz =A0 =A0t0, 1f
>
> + =A0 =A0 =A0 lw =A0 =A0 =A0t1, PR_R2(sp) =A0 =A0 =A0 =A0 =A0 # sysca=
ll number

Should this be PT_R2(sp), rather than PR_R2(sp)?

> =A0 =A0 =A0 =A0negu =A0 =A0v0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0# error
> - =A0 =A0 =A0 sw =A0 =A0 =A0v0, PT_R0(sp) =A0 =A0 =A0 =A0 =A0 # set f=
lag for syscall
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 # restarting
> + =A0 =A0 =A0 sw =A0 =A0 =A0t1, PT_R0(sp) =A0 =A0 =A0 =A0 =A0 # save =
it for syscall restarting
> =A01: =A0 =A0 sw =A0 =A0 =A0v0, PT_R2(sp) =A0 =A0 =A0 =A0 =A0 # resul=
t
>
> =A0o32_syscall_exit:
> @@ -104,9 +104,9 @@ syscall_trace_entry:
> =A0 =A0 =A0 =A0sw =A0 =A0 =A0t0, PT_R7(sp) =A0 =A0 =A0 =A0 =A0 # set =
error flag
> =A0 =A0 =A0 =A0beqz =A0 =A0t0, 1f
>
> + =A0 =A0 =A0 lw =A0 =A0 =A0t1, PT_R2(sp) =A0 =A0 =A0 =A0 =A0 # sysca=
ll number
> =A0 =A0 =A0 =A0negu =A0 =A0v0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0# error
> - =A0 =A0 =A0 sw =A0 =A0 =A0v0, PT_R0(sp) =A0 =A0 =A0 =A0 =A0 # set f=
lag for syscall
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 # restarting
> + =A0 =A0 =A0 sw =A0 =A0 =A0t1, PT_R0(sp) =A0 =A0 =A0 =A0 =A0 # save =
it for syscall restarting
> =A01: =A0 =A0 sw =A0 =A0 =A0v0, PT_R2(sp) =A0 =A0 =A0 =A0 =A0 # resul=
t
>
> =A0 =A0 =A0 =A0j =A0 =A0 =A0 syscall_exit
> @@ -170,7 +170,6 @@ stackargs:
> =A0 =A0 =A0 =A0 */
> =A0bad_stack:
> =A0 =A0 =A0 =A0negu =A0 =A0v0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0# error
> - =A0 =A0 =A0 sw =A0 =A0 =A0v0, PT_R0(sp)
> =A0 =A0 =A0 =A0sw =A0 =A0 =A0v0, PT_R2(sp)
> =A0 =A0 =A0 =A0li =A0 =A0 =A0t0, 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 # set error flag
> =A0 =A0 =A0 =A0sw =A0 =A0 =A0t0, PT_R7(sp)

Changing PR_R2(sp) to PT_R2(sp) allows me to compile
and successfully boot 2.6.36-rc8.  I'll whip up a quick patch
to make this change and submit it.

Shane
