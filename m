From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] perf: Fix unsafe frame rewinding with hot regs fetching
Date: Thu, 08 Apr 2010 15:52:26 +0200
Message-ID: <1270734746.2215.56.camel@edumazet-laptop>
References: <1269568362-13690-1-git-send-regression-fweisbec@gmail.com>
	 <1269568362-13690-6-git-send-regression-fweisbec@gmail.com>
	 <1270720640.2215.43.camel@edumazet-laptop>  <20100408123209.GA6096@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:42865 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0DHNwc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 09:52:32 -0400
In-Reply-To: <20100408123209.GA6096@nowhere>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>, Archs <linux-arch@vger.kernel.org>

Le jeudi 08 avril 2010 =C3=A0 14:32 +0200, Frederic Weisbecker a =C3=A9=
crit :


>=20
> Can you please test this fix?
>=20
> Thanks.
>=20
> ---
> From 60d5c4e8498efc4a01abceef54ad3bc91993bf41 Mon Sep 17 00:00:00 200=
1
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Thu, 8 Apr 2010 14:05:50 +0200
> Subject: [PATCH] perf: Fix unsafe frame rewinding with hot regs fetch=
ing
>=20
> When we fetch the hot regs and rewind to the nth caller, it
> might happen that we dereference a frame pointer outside the
> kernel stack boundaries, like in this example:
>=20
> 	perf_trace_sched_switch+0xd5/0x120
>         schedule+0x6b5/0x860
>         retint_careful+0xd/0x21
>=20
> Since we directly dereference a userspace frame pointer here while
> rewinding behind retint_careful, this may end up in a crash.
>=20
> Fix this by simply using probe_kernel_address() when we rewind the
> frame pointer.
>=20
> This issue will have a much more proper fix in the next version of th=
e
> perf_arch_fetch_caller_regs() API that will only need to rewind to th=
e
> first caller.
>=20
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Archs <linux-arch@vger.kernel.org>
> ---
>  arch/x86/kernel/dumpstack.h |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/dumpstack.h b/arch/x86/kernel/dumpstack.=
h
> index e39e771..e1a93be 100644
> --- a/arch/x86/kernel/dumpstack.h
> +++ b/arch/x86/kernel/dumpstack.h
> @@ -14,6 +14,8 @@
>  #define get_bp(bp) asm("movq %%rbp, %0" : "=3Dr" (bp) :)
>  #endif
> =20
> +#include <linux/uaccess.h>
> +
>  extern void
>  show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  		unsigned long *stack, unsigned long bp, char *log_lvl);
> @@ -42,8 +44,10 @@ static inline unsigned long rewind_frame_pointer(i=
nt n)
>  	get_bp(frame);
> =20
>  #ifdef CONFIG_FRAME_POINTER
> -	while (n--)
> -		frame =3D frame->next_frame;
> +	while (n--) {
> +		if (probe_kernel_address(&frame->next_frame, frame))
> +			break;
> +	}
>  #endif
> =20
>  	return (unsigned long)frame;

Thanks, no more crash :)

Tested-by: Eric Dumazet <eric.dumazet@gmail.com>
