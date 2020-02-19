From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 14:48:34 -0800
Message-ID: <772ACE2A-FD8B-492F-960E-981ECC72E283@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F57E302@ORSMSX115.amr.corp.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33421 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 17:48:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so866385pgk.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 14:48:37 -0800 (PST)
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57E302@ORSMSX115.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, "paulmck@kernel.org" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>


> On Feb 19, 2020, at 2:33 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> One big question here: are memory failure #MC exceptions synchronous
>> or can they be delayed?   If we get a memory failure, is it possible
>> that the #MC hits some random context and not the actual context where
>> the error occurred?
>=20
> There are a few cases:
> 1) SRAO (Software recoverable action optional) [Patrol scrub or L3 cache e=
viction]
> These aren't synchronous with any core execution. Using machine check to s=
ignal
> was probably a mistake - compounded by it being broadcast :-(  Could pick a=
ny CPU
> to handle (actually choose the first to arrive in do_machine_check()). Tha=
t guy should
> arrange to soft offline the affected page. Every CPU can return to what th=
ey were doing
> before.

You could handle this by sending IPI-to-self and dealing with it in the inte=
rrupt handler. Or even wake a high-priority kthread or workqueue. irq_work m=
ay help. Relying on task_work or the non_atomic stuff seems silly - you can=E2=
=80=99t rely on anything about the interrupted context, and the context is m=
ore or less irrelevant anyway.

>=20
> 2) SRAR (Software recoverable action required)
> These are synchronous. Starting with Skylake they may be signaled just to t=
he thread
> that hit the poison. Earlier generations broadcast.

Here=E2=80=99s where dealing with one that came from kernel code is just nas=
ty, right?

I would argue that, if IF=3D0, killing the machine is reasonable.  If IF=3D1=
, we should be okay.  Actually making this work sanely is gross, and arguabl=
y the goal should be minimizing grossness.

Perhaps, if we came from kernel mode, we should IPI-to-self and use a specia=
l vector that is idtentry, not apicinterrupt.  Or maybe even do this for ent=
ries from usermode just to keep everything consistent.

>    2a) Hit in ring3 code ... we want to offline the page and SIGBUS the ta=
sk(s)
>    2b) Memcpy_mcsafe() ... kernel has a recovery path. "Return" to the rec=
overy code instead of to the original RIP.
>    2c) copy_from_user ... not implemented yet. We are in kernel, but would=
 like to treat this like case 2a
>=20
> 3) Fatal
> Always broadcast. Some bank has MCi_STATUS.PCC=3D=3D1. System must be shut=
down.

Easy :)

It would be really, really nice if NMI was masked in MCE context.

>=20
> -Tony
