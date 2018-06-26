Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39990 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeFZV6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jun 2018 17:58:12 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so3839672plo.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Jun 2018 14:58:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH for 4.18 2/2] rseq: compat: clear high bits of rseq_cs fields
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20180626211617.8933-2-mathieu.desnoyers@efficios.com>
Date: Tue, 26 Jun 2018 14:58:08 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <D9B93DE9-F61C-4488-B109-432C2DFDCEC2@amacapital.net>
References: <20180626211617.8933-1-mathieu.desnoyers@efficios.com> <20180626211617.8933-2-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, Andi Kleen <andi@firstfloor.org>, "H . Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>, Russell King <linux@arm.linux.org.uk>, Andrew Hunter <ahh@google.com>, Michael Kerrisk <mtk.manpages@gmail.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180626215808.l_NxH4w_q1knnzkL3vzeUrQK2XOSzJVXUlatk8GAX70@z>



> On Jun 26, 2018, at 2:16 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios=
.com> wrote:
>=20
> Make the behavior rseq on compat tasks more robust by ensuring that
> kernel/rseq.c:rseq_get_rseq_cs() clears the high bits of
> rseq_cs->abort_ip, rseq_cs->start_ip and rseq_cs->post_commit_offset
> when a 32-bit binary is run on a 64-bit kernel.
>=20
> The intent here is that if user-space has garbage rather than zeroes
> in its struct rseq_cs fields padding, the behavior will be the same
> whether the binary is run on 32-bit or 64-bit kernels.
>=20
> Use in_compat_syscall() when rseq_get_rseq_cs() is invoked from
> system call context, and use is_compat_frame() when invoked from
> signal delivery.
>=20

And when it=E2=80=99s invoked due to preemption unrelated to a syscall or si=
gnal, you malfunction?

I think the only sane solution is to make these fields be u64, delete the LI=
NUX_FIELD_ macros, and possibly teach the x86 slowpath return to inject a si=
gnal if it=E2=80=99s trying to return to a 32-bit context with garbage in th=
e high bits of regs->ip so that we determistically fail if the user screws u=
p.

Rseq is brand new. It should not need compat code at all.=
