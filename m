From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 04/13] task_isolation: userspace hard isolation from kernel
Date: Thu, 9 Apr 2020 11:00:16 -0700
Message-ID: <915489BC-B2C9-4D47-A205-FC597FC68B98@amacapital.net>
References: <58995f108f1af4d59aa8ccd412cdff92711a9990.camel@marvell.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51647 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDISAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 14:00:19 -0400
Received: by mail-pj1-f67.google.com with SMTP id n4so1616099pjp.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Apr 2020 11:00:19 -0700 (PDT)
In-Reply-To: <58995f108f1af4d59aa8ccd412cdff92711a9990.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>



> On Apr 9, 2020, at 8:21 AM, Alex Belits <abelits@marvell.com> wrote:
>=20
> =EF=BB=BFThe existing nohz_full mode is designed as a "soft" isolation mod=
e
> that makes tradeoffs to minimize userspace interruptions while
> still attempting to avoid overheads in the kernel entry/exit path,
> to provide 100% kernel semantics, etc.
>=20
> However, some applications require a "hard" commitment from the
> kernel to avoid interruptions, in particular userspace device driver
> style applications, such as high-speed networking code.
>=20
> This change introduces a framework to allow applications
> to elect to have the "hard" semantics as needed, specifying
> prctl(PR_TASK_ISOLATION, PR_TASK_ISOLATION_ENABLE) to do so.
>=20
> The kernel must be built with the new TASK_ISOLATION Kconfig flag
> to enable this mode, and the kernel booted with an appropriate
> "isolcpus=3Dnohz,domain,CPULIST" boot argument to enable
> nohz_full and isolcpus. The "task_isolation" state is then indicated
> by setting a new task struct field, task_isolation_flag, to the
> value passed by prctl(), and also setting a TIF_TASK_ISOLATION
> bit in the thread_info flags. When the kernel is returning to
> userspace from the prctl() call and sees TIF_TASK_ISOLATION set,
> it calls the new task_isolation_start() routine to arrange for
> the task to avoid being interrupted in the future.
>=20
> With interrupts disabled, task_isolation_start() ensures that kernel
> subsystems that might cause a future interrupt are quiesced. If it
> doesn't succeed, it adjusts the syscall return value to indicate that
> fact, and userspace can retry as desired. In addition to stopping
> the scheduler tick, the code takes any actions that might avoid
> a future interrupt to the core, such as a worker thread being
> scheduled that could be quiesced now (e.g. the vmstat worker)
> or a future IPI to the core to clean up some state that could be
> cleaned up now (e.g. the mm lru per-cpu cache).
>=20
> Once the task has returned to userspace after issuing the prctl(),
> if it enters the kernel again via system call, page fault, or any
> other exception or irq, the kernel will kill it with SIGKILL.

I could easily imagine myself using task isolation, but not with the SIGKILL=
 semantics. SIGKILL causes data loss. Please at least let users choose what s=
ignal to send.=
